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

  test_validations_for :title, :presence
  test_validations_for :recorded_at, :presence

  test "random should return video with a streaming_video" do
    v = Video.random

    assert_not_nil v.streaming_video

    v = videos(:no_streaming)

    refute v.streaming_video
  end
end
