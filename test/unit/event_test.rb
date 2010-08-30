require 'test_helper'

class EventTest < ActiveSupport::TestCase
  fixtures :events, :conferences

  model_template_for Event do
    {
      :conference_id => 1,
      :name_suffix => 2010,
      :short_code => 'test2010'
    }
  end

  def test_new_event
    e = create_event

    assert e.save
  end
end
