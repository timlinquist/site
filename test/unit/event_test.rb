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

  def test_find_by_identifier
    a = Event.find_by_identifier('mwrc2010')

    assert_equal 1, a.id
  end

  def test_find_by_identifier_failure
    a = Event.find_by_identifier('wrong')

    refute a

    b = Event.find_by_identifier(49494)

    refute b
  end
end
