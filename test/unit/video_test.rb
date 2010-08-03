require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  fixtures :videos, :presenters, :events

  model_template_for Video do
    {
      :title => 'Writing Modular Ruby Code: Lessons Learned from Rails 3',
      :event_id => events(:mwrc2010).id,
      :recorded_at => Time.zone.now,
      :available => true
    }
  end

  def test_new_with_validations
    v = Video.new
    assert_equal false, v.save

    v = Video.new
    v.event = events(:mwrc2010)
    v.title = "presentation title"
    v.recorded_at = Time.zone.now

    assert v.save
  end
end
