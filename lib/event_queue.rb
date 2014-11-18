class EventQueue
  include BuildFile

  attr_reader :people

  def initialize
    @people = []
  end

  def add_people(more_people)
    people_array = convert_to_array(more_people)
    @people += people_array
  end

  def convert_to_array(people_csv)
    people_csv.map do |csv|
      csv.to_hash.values
    end
  end

  def save(file_name)
    file_path = get_file_path(file_name)
    CSV.open(file_path, 'wb') do |csv|
      @people.each do |person|
        csv << person
      end
    end
  end
end
