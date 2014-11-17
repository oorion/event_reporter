require_relative '../test/test_helper'

class EventQueueTest < Minitest::Test
  def test_has_collection_of_csv_objects
    matches = [CSV.new("name"), CSV.new("name")]
    queue = EventQueue.new
    queue.add_people(matches)
    assert_equal matches, queue.people
  end
end