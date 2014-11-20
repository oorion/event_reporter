module BuildFile
  def get_file_path(file_name)
    path_to_file = File.expand_path("../data", __dir__)
    file_path = File.join(path_to_file, file_name)
  end

  def convert_saved_file_header(file_name)
    file_path = get_file_path(file_name)
    header = CSV.open(file_path,'r').first
    capital_headers = header.map { |h| h.upcase }
  end

  def convert_original_header(file_name)
    capital_headers = convert_saved_file_header(file_name)
    capital_headers.shift(2)
    capital_headers
  end

  def convert_file_to_csv(file_name)
    file_path = get_file_path(file_name)
    CSV.open(file_path, headers: true, header_converters: :symbol)
  end
end
