require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def test_new_event
    e = Event.new
    e.name = "Ruby Conference"
    e.year = 2007
    
    assert e.save
  end
end
