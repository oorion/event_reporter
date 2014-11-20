require 'pry'
require_relative 'build_file'
require_relative 'entry'

class Model
  include BuildFile

  attr_reader :entry_repository, :headers

  def initialize
    @entry_repository = []
  end

  def load(file_name)
    csv_file = convert_file_to_csv(file_name)
    @headers = get_headers(file_name)
    csv_file.each do |row|
      @entry_repository << Entry.new(row.to_hash)
    end
  end

  def get_headers(file_name)
    file_name_is_event_attendees?(file_name) ? convert_original_header(file_name) : convert_saved_file_header(file_name)
  end

  def file_name_is_event_attendees?(file_name)
    file_name == "event_attendees.csv"
  end

  def find(attribute, criteria)
    @entry_repository.select do |element|
      element.entry[attribute.to_sym] == criteria
    end
  end

  def load_attendees(filename)
    csv = CSV.open("./data/#{filename}", headers: true, header_converters: :symbol)
    csv.map do |row|
      Entry.new(row)
    end
  end
end
