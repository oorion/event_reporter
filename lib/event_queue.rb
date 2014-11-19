class EventQueue
  include BuildFile

  attr_reader :entry_repository

  def initialize
    @entry_repository = []
  end

  def add_entries(entries)
    people_array = convert_to_array(entries)
    @entry_repository += people_array
  end

  def convert_to_array(people_csv)
    people_csv.map do |csv|
      csv.to_hash.values
    end
  end

  def save(file_name)
    #needs headers
    file_path = get_file_path(file_name)
    CSV.open(file_path, 'wb') do |csv|
      @entry_repository.each do |person|
        csv << person
      end
    end
  end

  def count
    @entry_repository.length
  end

  def print(outstream)
    
  end

  def print_by

  end

  def clear
    @entry_repository = []
  end
end
