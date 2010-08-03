class AssetType < ActiveRecord::Base
  has_many :assets

  cattr_reader :per_page

  @@per_page = 25

  def height
    if streaming
      width, height = description.split(" ")[0].split("x")
      return height.to_i
    end
  end

  def width
    if streaming
      width, height = description.split(" ")[0].split("x")
      return width.to_i
    end
  end
end
