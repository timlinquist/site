class Conference < ActiveRecord::Base
  has_many :events

  cattr_reader :per_page

  validates_uniqueness_of :name

  @@per_page = 10

  def to_param
    "#{id}-#{slug}"
  end

  def slug
    name.gsub(" ","-").downcase
  end
end
