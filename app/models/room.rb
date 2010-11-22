class Room < ActiveRecord::Base
  belongs_to :event

  validates_presence_of :name
  validates_presence_of :number
end
