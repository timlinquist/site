class Conference < ActiveRecord::Base
  has_many :events

  cattr_reader :per_page

  validates_uniqueness_of :name

  @@per_page = 10
end
