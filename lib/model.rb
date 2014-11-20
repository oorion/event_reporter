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
    @headers = convert_header(file_name)
    csv_file.each do |row|
      @entry_repository << Entry.new(row.to_hash)
    end

    # original_file = get_file(file_name)
    # original_csv_file = convert_file_to_csv(original_file)
    # normalize_csv(file_name, original_csv_file)
    # normalized_file = get_file('.temp_'+file_name)
    # @converted_csv_file = convert_file_to_csv(normalized_file)
  end

  def find(attribute, criteria)
    @entry_repository.select do |element|
      element.entry[attribute.to_sym] == criteria
    end
  end

  # def normalize_csv(file_name, original_csv_file)
  #   file_path = get_file_path('.temp_'+file_name)
  #   CSV.open(file_path, 'wb') do |csv|
  #
  #     original_csv_file.each do |row|
  #       temp_phone = row[:homephone].gsub(/[() .-]+/, '')
  #       csv << [
  #         "#{row[:_]}",
  #         "#{row[:regdate]}",
  #         "#{row[:first_name].downcase.strip}",
  #         "#{row[:last_name].downcase.strip}",
  #         "#{row[:email_address].downcase}",
  #         "#{temp_phone[0..2]}-#{temp_phone[3..5]}-#{temp_phone[6..9]}",
  #         "#{row[:street].downcase if row[:street] != nil}",
  #         "#{row[:city].downcase if row[:city] != nil}",
  #         "#{row[:state].downcase if row[:state] != nil}",
  #         "#{row[:zipcode].to_s.rjust(5,"0")[0..4]}"
  #         ]
  #     end
  #   end
  # end

  def load_attendees(filename)
    csv = CSV.open("./data/#{filename}", headers: true, header_converters: :symbol)
    csv.map do |row|
      Entry.new(row)
    end
  end

  def convert_header(file_name)
    file_path = get_file_path(file_name)
    header = CSV.open(file_path,'r').first
    capital_headers = header.map { |h| h.upcase }
    capital_headers.shift(2)
    capital_headers
  end
end
