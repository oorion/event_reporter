require 'pry'
require 'csv'
require_relative 'help'
require_relative 'model'
require_relative 'event_queue'

class CLI
  include Help

  attr_reader :outstream, :instream, :command, :converted_command, :model, :queue

  def initialize(instream, outstream)
     @instream  = instream
     @outstream = outstream
     @command   = ''
     @converted_command = ''
     @model = Model.new
     @queue = EventQueue.new
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
        file_name = @converted_command[1] || 'event_attendees.csv'
        load(file_name)
      when find?
        model_search = @model.find(@converted_command[1], @converted_command[2])
        if model_search == []
          outstream.puts "Nothing returned"
        else
          @queue.add_people(model_search)
        end
      when queue?
        #code
      end
    end
  end

  def load(file_name)
    @model.load(file_name)
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

  def queue?
    @converted_command[0] == 'queue'
  end
end
