require 'test_helper'

class AssetTest < ActiveSupport::TestCase

  test "validate metadata" do
    a = Asset.new
    a.data = File.new('test/fixtures/jeff-patton-small.mp4')
    a.save

    #puts a.data_file_name
    #puts a.data_file_size
    #puts a.data_updated_at
    #puts a.data_content_type
    #puts a.duration
    #puts a.width
    #puts a.height
    #puts a.streaming

    a.get_metadata
    assert_not_nil a.duration, "duration is nil"
    assert_not_nil a.width,  "width is nil"
    assert_not_nil a.height, "height is nil"
    assert_not_nil a.raw_response, "raw response is nil"
  end

  test "validate height" do
    a = Asset.new
    a.data = File.new('test/fixtures/jeff-patton-small.mp4')
    a.save

    assert_not_nil a.height
  end

  test "validate width" do
    a = Asset.new
    a.data = File.new('test/fixtures/jeff-patton-small.mp4')
    a.save
    
    assert_not_nil a.width
  end

  test "validate duration" do
    a = Asset.new
    a.data = File.new('test/fixtures/jeff-patton-small.mp4')
    a.save

    assert_not_nil a.duration
  end

end
