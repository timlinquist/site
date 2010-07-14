require 'iconv'

class Video < ActiveRecord::Base

  belongs_to :event

  validates_presence_of :title
  validates_presence_of :recorded_at

  has_many :presentations

  has_many :presenters, :through => :presentations

  accepts_nested_attributes_for :presentations,
    :reject_if => lambda { |a| a[:presenter_id].blank? },
    :allow_destroy => true

  cattr_reader :per_page

  @@per_page = 10

  def self.random
    if Rails.env == "production"
      order = 'rand()'
    else
      order = 'random()'
    end
      Video.find(:first,
                 :conditions => ["available = ?",true],
                 :order => order)
  end

  def display_presenters
    out = ""
    self.presenters.each do |p|
      out = out + p.display_name + ", "
    end
    out = out [0,out.length-2]
  end

  def width
    out = 640
    if display_format == "SD"
      out = 480
    end
    out
  end

  def height
    out = 360
    if display_format == "DW"
      out = 240
    end
    out
  end

  def uri size
    unless event.slug_format[0].downcase == "override"
      "http://#{event.short_code}.confreaks.com/videos/#{slug}-#{size}.#{extension}"
    else
      "http://#{event.short_code}.confreaks.com/videos/#{slug}_#{width}x#{height}.#{extension}"
    end
  end

  def thumbnail
    "http://#{event.short_code}.confreaks.com/images/#{slug}#{event.joiner}thumb.#{event.image_extension}"
  end

  def preview
    "http://#{event.short_code}.confreaks.com/images/#{slug}#{event.joiner}preview.#{event.image_extension}"
  end

  def extension
    if event.nil?  || event.video_extension.nil?
      "mp4"
    else
      event.video_extension
    end
  end

  def slug
    if override && !override.empty?
      out = override
    else
      out = event.slug_format.map{ |p| eval "#{p}"}.join(event.joiner)

      unless event.slug_format[0].downcase == "override"
        out = Iconv.iconv("ascii//translit",
                          "iso-8859-1",
                          out
                          )[0].tr('^A-Za-z0-9 \\-','')
        out = recorded_at.strftime(event.slug_date_format).downcase +
          out.downcase.strip.gsub(/\W+/, '-')
      end
    end

    out
  end

end

