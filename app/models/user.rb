class User < ActiveRecord::Base
  attr_accessible :username, :time_zone, :email, :session_token, :admin,
    :password, :password_confirmation, :first_name, :last_name

  attr_accessor :password, :password_confirmation

  attr_accessor :signup

  validates_length_of :username, :within => 3..40
  validates_presence_of :username, :email, :time_zone
  validates_uniqueness_of :username, :email
  validates_confirmation_of :password

  has_many :votes

  has_one :profile

  before_save :hash_and_salt_password, :if => :password

  after_create :welcome_email

  cattr_reader :per_page

  @@per_page = 25

  def self.authenticate username, password
    user = find(:first, :conditions => ['LOWER(username) = LOWER(?)',username])
    if user && user.password?(password)
      user.last_login_date = Time.zone.now
      user.save
      user
    end
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
    UserMailer.deliver_welcome_email(self)
  end
end
