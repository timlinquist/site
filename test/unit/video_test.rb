require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  def test_new_with_validations
    v = Video.new
    assert_equal false, v.save

    v = Video.new
    v.title = "presentation title"

    assert v.save
  end
end
