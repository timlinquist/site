require 'rvideo'

class Asset < ActiveRecord::Base

  belongs_to :asset_type

  belongs_to :video

  has_many :streaming_for, :class_name => 'Video'

  has_attached_file :data,
    :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension",
    :url => "/system/:class/:attachment/:id/:style/:basename.:extension"

  scope :downloadable,
    :joins => :asset_type,
    :conditions => ['asset_types.downloadable = ?', true],
    :order => 'data_file_size desc'

  before_save :populate_metadata

  def size
    if width && height
      if width > 0 and height > 0
        "#{width}x#{height}"
      else
        ""
      end
      ""
    end
  end

  def display_description
    helpers = Object.new.extend(ActionView::Helpers::NumberHelper)
    elements = Array.new
    if asset_type && asset_type.description == "Video" then
      elements << (description.blank? ? nil : description)
      elements << size
      elements << data_content_type
      elements << helpers.number_to_human_size(data_file_size)
      elements << duration
      elements.compact.join(" - ")
    elsif asset_type && asset_type.description == "Audio" then
      elements << (description.blank? ? nil : description)
      elements << data_content_type
      elements << helpers.number_to_human_size(data_file_size)
      elements << duration
      elements.compact.join(" - ")
    else
      if description.blank?
        "no description available"
      else
        description
      end
    end
  end

  def populate_metadata
    unless self.data_content_type == "video/quicktime"
      self.width, self.height, self.duration = self.get_metadata
    end
  end

  def get_metadata
    if data
      file = data.path

      begin
        tmp1 = RVideo::Inspector.new :file => file

        raw_response = tmp1.raw_response

        pos1 = (tmp1.raw_response =~ /Duration:/)

        unless pos1.nil?
          duration = tmp1.raw_response[(pos1 + 10),8]
        else
          duration =""
        end

        pos2 = (tmp1.raw_response =~ /Video:/)

        unless pos2.nil?
          tmp2 = tmp1.raw_response[pos2,50]
          width, height = tmp2[(tmp2 =~ /x/) - 4, 9].split(',')[0].split('x')
        else
          width, height = 0,0
        end
      rescue
        width = 0
        height = 0
        duration = ""
      end
      return width, height, duration
    else
      return 0,0,""
    end
  end
end
