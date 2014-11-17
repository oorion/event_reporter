require 'csv'
require_relative 'help'
require_relative 'model'

class CLI
  include Help

  attr_reader :outstream, :instream

  def initialize(instream, outstream)
     @instream  = instream
     @outstream = outstream
     @command   = ''
     @converted_command = ''
     @queue = event_attendeeslsQueue.new
  end

  def load(file_name='event_attendees.csv')
    Model.new(file_name)
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
        @model = load(@converted_command[1])
      when find?
        model_search = @model.find(@converted_command[1], @converted_command[2])
        if model_search == []
          outstream.puts "Nothing returned"
        else
          @queue.add_people(model_search)
        end
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

  def find?
    @converted_command[0] == 'find'
  end
end