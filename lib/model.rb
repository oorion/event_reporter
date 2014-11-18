require 'pry'
require_relative 'build_file'

class Model
  include BuildFile

  attr_reader :converted_csv_file

  def load(file_name)
    original_file = get_file(file_name)
    @headers = original_file.first.chomp.split(",")
    original_csv_file = convert_file_to_csv(original_file)
    normalize_csv(file_name, original_csv_file)
    normalized_file = get_file('.temp_'+file_name)
    @converted_csv_file = convert_file_to_csv(normalized_file)
  end

  def find(attribute, criteria)
    @converted_csv_file.select do |element|
      element[attribute.to_sym] == criteria
    end
  end

  def normalize_csv(file_name, original_csv_file)
    file_path = get_file_path('.temp_'+file_name)
    CSV.open(file_path, 'wb') do |csv|
      csv << @headers
      original_csv_file.each do |row|
        temp_phone = row[:homephone].gsub(/[() .-]+/, '')
        csv << [
          "#{row[:_]}",
          "#{row[:regdate]}",
          "#{row[:first_name].downcase.strip}",
          "#{row[:last_name].downcase.strip}",
          "#{row[:email_address].downcase}",
          "#{temp_phone[0..2]}-#{temp_phone[3..5]}-#{temp_phone[6..9]}",
          "#{row[:street].downcase if row[:street] != nil}",
          "#{row[:city].downcase if row[:city] != nil}",
          "#{row[:state].downcase if row[:state] != nil}",
          "#{row[:zipcode].to_s.rjust(5,"0")[0..4]}"
          ]
      end
    end
  end

  def load_attendees(filename)
    csv = CSV.open("./data/#{filename}", headers: true, header_converters: :symbol)
    csv.map do |row|
      Entry.new(row)
    end
  end
end
