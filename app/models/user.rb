class User < ActiveRecord::Base
  attr_accessible :username, :time_zone, :email, :session_token, :admin,
    :password, :password_confirmation, :first_name, :last_name,
    :presenter_id, :avatar, :location, :title

  attr_accessor :password, :password_confirmation

  attr_accessor :signup

  before_validation :check_admin

  validates_length_of :username, :within => 3..40
  validates_presence_of :username, :email, :time_zone
  validates_uniqueness_of :username, :email
  validates_confirmation_of :password

  has_many :votes

  belongs_to :presenter

  has_one :profile

  has_one :twitter_account, :dependent => :destroy

  has_many :activities,
           :order => 'created_at desc',
           :conditions => ['suppressed = ?', false]

  before_save :hash_and_salt_password, :if => :password

  after_create :welcome_email

  has_attached_file :avatar,
    :path => ":rails_root/public/system/:class/:attachment/:id/:basename-:style.:extension",
    :url => "/system/:class/:attachment/:id/:basename-:style.:extension",
    :styles => {
      :tiny => '50x50',
      :small => '100x100',
      :medium => '200x200',
      :large  => '300x300',
      :xl     => '400x400',
      :xxl    => '500x500',
      :xxxl    => '600x600'
      },
    :default_url => '/system/:class/:attachment/missing-:style.png'

  cattr_reader :per_page

  @@per_page = 25

  def has_twitter_oauth?
    self.twitter_account and
      self.twitter_account.token and
      self.twitter_account.secret
  end

  def create_or_update_twitter_account_with_oauth_token(token,secret)
    twitter_account = self.twitter_account ? self.twitter_account : TwitterAccount.new(:user_id => self.id)
    twitter_account.token = token
    twitter_account.secret = secret
    twitter_account.save!
  end

  def self.authenticate username, password
    user = find(:first, :conditions => ['LOWER(username) = LOWER(?)',username])
    if user && user.password?(password)
      user.last_login_date = Time.zone.now
      user.save
      self.record_activity user, "logged in successfully."
      user
    end
  end

  def check_admin
    self.admin = (User.count == 0) unless admin
    true
  end

  def self.signup params
    create({:signup => true}.merge(params))
  end

  def password? password
    password_hash == Confreaks::Crypto.digest(password_salt, password)
  end

  def password_reset password
    self.password = password
    save
    UserMail.deliver_reset_email self, password
  end

  def hash_and_salt_password
    unless self.password.empty?
      self.password_salt ||= Confreaks::Crypto.salt(username)
      self.password_hash   = Confreaks::Crypto.digest(password_salt, password)
    end
  end

  def forget!
    update_attribute :session_token, nil
  end

  def remember!
    update_attribute :session_token, Confreaks::Crypto.salt(id)
    session_token
  end

  def welcome_email
    self.record_activity self, "Welcome email has been sent"
    UserMailer.deliver_welcome_email(self)
  end

  def full_name
    if first_name && username
      "#{first_name} #{last_name} (#{username})"
    else
      "#{username}"
    end
  end

  # Returns a Gravatar URL associated with the email parameter.
  #
  # Gravatar Options:
  # -rating: Can be one of G, PG, R or X. Default is X.
  # -size: Size of the image. Default is 80px.
  #  default: URL for fallback image if none is found or image exceeds rating.
  def gravatar_url(gravatar_options={})
    grav_url = 'http://www.gravatar.com/avatar.php?'
    grav_url << "gravatar_id=#{Digest::MD5.new.update(self.email)}"
    if gravatar_options[:rating]
      grav_url << "&rating=#{gravatar_options[:rating]}"
    end
    grav_url << "&size=#{gravatar_options[:size]}" if gravatar_options[:size]
    if gravatar_options[:default]
      grav_url << "&default=#{gravatar_options[:default]}"
    end

    return grav_url
  end

  private

  def self.record_activity user, message
    user.activities.create!(:message => message)
  end
end
