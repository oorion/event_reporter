require_relative '../test/test_helper'

class EventQueueTest < Minitest::Test
  def setup
    file = File.open('/Users/orion/Turing/event_reporter/data/test.csv', 'r')
    @csv_file = CSV.open(file, headers: true, header_converters: :symbol)
    @matches = @csv_file.map { |n| n }
    @queue = EventQueue.new
    @queue.add_entry(@matches)
  end

  def test_has_converted_CSVs
    converted_matches = @matches.map { |n| n.to_hash.values }
    assert_equal converted_matches, @queue.entry_repository
  end

  # def test_can_save_to_a_file
  #   @queue.save("csv_test_save.csv")
  #   test_file = File.open('/Users/orion/Turing/event_reporter/data/csv_test_save.csv', 'r')
  #   test_csv_file = CSV.open(test_file, headers: true, header_converters: :symbol)
  #   assert_equal @csv_file, test_csv_file
  # end
end
