class EventQueue
  include BuildFile

  attr_reader :entry_repository

  def initialize
    @entry_repository = []
  end

  def add_headers(headers)
    @headers = headers
    add_printable_headers
  end

  def add_entries(entries)
    @entry_repository = entries
  end

  def save(file_name)
    file_path = get_file_path(file_name)
    CSV.open(file_path, 'wb') do |csv|
      csv << @printable_headers
      add_csv_elements(csv)
    end
  end

  def add_csv_elements(csv)
    @entry_repository.map do |element|
      row = []
      element.entry.each do |key, val|
        row << val
      end
      csv << row
    end
  end

  def count
    @entry_repository.length
  end

  def add_printable_headers
    @printable_headers = [@headers[1],@headers[0],@headers[2],@headers[7],@headers[5],@headers[6],@headers[4],@headers[3]]
  end

  def print(outstream)
    print_header(outstream)
    queue_staging.each do |entry|
      outstream.puts entry.join("\t")
    end
  end

  def print_by(outstream, attribute)
    print_header(outstream)
    index_to_sort_by = downcase_headers.index(attribute)
    sorted_entries = queue_staging.sort_by { |entry| entry[index_to_sort_by]}
    sorted_entries.each do |entry|
      outstream.puts entry.join("\t")
    end
  end

  def print_header(outstream)
    outstream.puts @printable_headers.join("\t")
  end

  def queue_staging
    @entry_repository.map do |entry|
      @printable_headers.map do |header|
        entry.entry[header.downcase.to_sym]
      end
    end
  end

  def downcase_headers
    @printable_headers.map { |header| header.downcase }
  end

  def clear
    @entry_repository = []
  end
end
