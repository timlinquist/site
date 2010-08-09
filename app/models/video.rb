class Video < ActiveRecord::Base

  attr_accessible :available, :title, :recorded_at, :event_id,
    :presentations_attributes, :assets_attributes, :include_random

  belongs_to :event

  has_many :assets

  has_one :thumbnail_image,
          :class_name => 'Asset',
          :conditions => ["asset_type_id in (select id from asset_types where description = 'Thumbnail')"]

  has_one :streaming_video,
          :class_name => 'Asset',
          :conditions => ['asset_type_id in (select id from asset_types where streaming = ?)',true]

  has_one :preview_image,
          :class_name => 'Asset',
          :conditions => ["asset_type_id in (select id from asset_types where description = 'Preview')"]

  validates_presence_of :title
  validates_presence_of :recorded_at

  has_many :presentations

  has_many :presenters, :through => :presentations

  accepts_nested_attributes_for :presentations,
    :reject_if => lambda { |a| a[:presenter_id].blank? },
    :allow_destroy => true

  accepts_nested_attributes_for :assets,
    :reject_if => lambda { |a| a[:asset_type_id].blank? },
    :allow_destroy => true

  cattr_reader :per_page

  @@per_page = 25

  def self.random
      if Rails.env == "production"
        order = 'rand()'
      else
        order = 'random()'
      end


      Video.find(:first,
                 :joins => "inner join assets on assets.video_id = videos.id inner join asset_types on assets.asset_type_id = asset_types.id",
                 :conditions => ["available = ? and include_random = ? and asset_types.streaming = ?",
                                 true,
                                 true,
                                 true],
                 :order => order)
  end

  def streaming_video_url
    # TODO figure out how to remove the need for this stupid hack
    # paperclip adds the cache buster to the URL automatically, I need
    # it to go away, probably a really easy paperclip option, but not
    # finding it at the moment.
    unless streaming_video.nil?
      streaming_video.data.url.split("?")[0]
    else
      nil
    end
  end

  def display_presenters
    out = ""
    self.presenters.each do |p|
      out = out + p.display_name + ", "
    end
    out = out [0,out.length-2]
  end
end

