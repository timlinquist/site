class Asset < ActiveRecord::Base
  belongs_to :asset_type

  belongs_to :video

  has_attached_file :data,
    :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension",
    :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
    :styles => {
      :default_url => "/assets/:style/missing.png"}

  cattr_reader :per_page

  @@per_page = 10

end
