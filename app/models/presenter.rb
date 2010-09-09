class Presenter < ActiveRecord::Base
  has_many :presentations
  has_many :videos, :through => :presentations

  has_one :user

  has_one :most_recent_video,
          :class_name => 'Video',
          :through => :presentations,
          :order => 'recorded_at desc'

  cattr_reader :per_page

  validates_uniqueness_of :first_name, :scope => :last_name

  @@per_page = 24

  def to_param
    "#{id}-#{name_slug}"
  end

  def name_slug
    display_name.gsub('.','').gsub(' ','-').gsub("'",'').downcase
  end

  def display_name
    if aka_name.blank?
      if user.nil?
        "#{first_name} #{last_name}"
      else
        if user.first_name  || user.last_name
          "#{user.first_name} #{user.last_name}"
        else
          "#{first_name} #{last_name}"
        end
      end
    else
      aka_name
    end
  end
end
