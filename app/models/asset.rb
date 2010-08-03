class Asset < ActiveRecord::Base
  belongs_to :asset_type

  belongs_to :video

  has_attached_file :data,
    :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension",
    :url => "/system/:class/:attachment/:id/:style/:basename.:extension"

  named_scope :downloadable, 
    :joins => :asset_type, 
    :conditions => ['asset_types.downloadable = ?', true],
    :order => 'data_file_size desc'

  def display_description
    description.blank? ? asset_type.description : description
  end

end
