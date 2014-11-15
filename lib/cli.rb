require 'csv'
require_relative 'help'

class CLI
  include Help

  attr_reader :outstream, :instream

  def initialize(instream, outstream)
     @instream  = instream
     @outstream = outstream
     @command   = ''
     @converted_command = ''
  end

  def load(file='event_attendees.csv')
    path_to_file = File.expand_path("../data", __dir__)
    file_path = File.join(path_to_file, file)
    file = File.open(file_path, 'r')
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

  def call
    until quit?
      outstream.print prompt
      @command = instream.gets.chomp.downcase
      @converted_command = convert_command
      case
      when help?
        if @converted_command.length > 1
          outstream.puts help_commands[@converted_command[1..-1].join(' ')]
        else
          help_commands.values.each { |help_command| outstream.puts help_command }
        end
      when load?
        #code
      end
    end
  end

  def prompt
    "> "
  end

  def convert_command
    @command.split
  end

  def quit?
    @converted_command[0] == 'quit'
  end

  def help?
    @converted_command[0] == 'help'
  end

  def load?
    @converted_command[0] == 'load'
  end
end