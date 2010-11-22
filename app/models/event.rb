class Event < ActiveRecord::Base
  named_scope :active, 
              :conditions => ["display = ?",true], 
              :order => 'start_at desc'

  belongs_to :conference

  has_many :videos, :order => 'recorded_at asc'
  has_many :available_videos, :class_name => 'Video',
           :order => 'recorded_at desc', :conditions => ['available = ?',true]

  has_many :rooms

  has_event_calendar

  has_attached_file :logo,
    :path => ":rails_root/public/system/:class/:attachment/:id/:basename-:style.:extension",
    :url => "/system/:class/:attachment/:id/:basename-:style.:extension",
    :styles => {
      :tiny   => '50x50',
      :small  => '100x100',
      :medium => '200x200',
      :large  => '300x300',
      :xl     => '400x400',
      :xxl    => '500x500',
      :xxxl    => '600x600'
      },
    :default_url => '/system/:class/:attachment/missing-:style.png'

  validates_uniqueness_of :short_code
  validates_presence_of   :short_code

  cattr_reader :per_page

  @@per_page = 25

  def to_param
    short_code || id
  end

  def self.find_by_identifier(identifier)
    unless identifier.to_i == 0
      find_by_id(identifier)
    else
      find_by_short_code(identifier)
    end
  end

  def display_name
    "#{name_prefix} #{conference.name} #{name_suffix}".strip! unless conference.nil?
  end

  def logo_file
    unless logo.nil?
      File.join('events',short_code, logo)
    else
      ""
    end
  end

  def date_occurred
    unless start_at.nil?
      unless start_at == end_at
        "#{start_at.strftime("%b %d")} - #{end_at.strftime("%d, %Y")}"
      else
        "#{start_at.strftime("%b %d, %Y")}"
      end
    else
      if end_at.nil?
        ""
      else
        "#{end_at.strftime("%b %d, %Y")}"
      end
    end
  end
end
