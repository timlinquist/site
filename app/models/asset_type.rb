class AssetType < ActiveRecord::Base
  has_many :assets

  cattr_reader :per_page

  @@per_page = 25
end
