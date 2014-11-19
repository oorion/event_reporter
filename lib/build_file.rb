module BuildFile
  def get_file_path(file_name)
    path_to_file = File.expand_path("../data", __dir__)
    file_path = File.join(path_to_file, file_name)
  end

  # def get_file(file_name)
  #   File.open(get_file_path(file_name), 'r')
  # end

  def convert_file_to_csv(file_name)
    file_path = get_file_path(file_name)
    CSV.open(file_path, headers: true, header_converters: :symbol)
  end
end
