require 'csv'

class CLI
  def initialize(instream, outstream)
     @instream  = instream
     @outstream = outstream
  end

  def load(file='event_attendees.csv')
    path_to_file = File.expand_path("../data", __dir__)
    file_path = File.join(path_to_file, file)
    file = File.open(file_path, 'r')
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end
end