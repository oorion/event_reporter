class Model
  attr_reader  :csv_file

  def initialize(file_name)
    @csv_file = load(file_name)
  end

  def load(file_name)
    path_to_file = File.expand_path("../data", __dir__)
    file_path = File.join(path_to_file, file_name)
    file = File.open(file_path, 'r')
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

  def find(attribute, criteria)
    csv_file.select do |element|
      element[attribute.to_sym] == criteria
    end
  end
end