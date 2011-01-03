require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  def test_new_activity
    a = Activity.new
    a.message = "test message"
    a.user_id = 1

    assert a.save
  end

  def test_destroy
    start = Activity.find(:all).count

    a = Activity.new
    a.message = "test message"
    a.user_id = 1
    assert a.save

    assert_equal Activity.find(:all).count, start + 1

    assert a.destroy

    assert_equal Activity.find(:all).count, start
  end
end
