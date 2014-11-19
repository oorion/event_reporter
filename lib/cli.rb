require 'pry'
require 'csv'
require_relative 'help'
require_relative 'model'
require_relative 'event_queue'
require_relative 'build_file'

class CLI
  include Help

  attr_reader :outstream, :instream, :command, :model, :queue

  def initialize(instream, outstream)
     @instream  = instream
     @outstream = outstream
     @command = []
     @model = Model.new
     @queue = EventQueue.new
  end

  def call
    until quit?
      outstream.print prompt
      input = instream.gets.chomp.downcase
      @command = convert_command(input)
      case
      when help?
        help
      when load?
        load
      when find?
        find
      when queue?
        queue
      end
    end
  end

  def help
    if @command.length > 1
      outstream.puts help_commands[@command[1..-1].join(' ')]
    else
      help_commands.values.each { |help_command| outstream.puts help_command }
    end
  end

  def load
    file_name = @command[1] || 'event_attendees.csv'
    @model.load(file_name)
    outstream.puts "Successfully loaded #{file_name}"
  end

  def find
    matches = @model.find(@command[1], @command[2])
    if matches == []
      outstream.puts "Nothing returned"
    else
      @queue.add_entries(matches)
      outstream.puts "There are #{@queue.count} results with #{@command[2]}"
    end
  end

  def queue
    case @command[1]
    when 'save'
      @queue.save(@command[3])
    when 'count'
      outstream.puts @queue.count
    when 'print'

      @command[2] == 'by' ? @queue.print_by : @queue.print(outstream)
    when 'clear'
      @queue.clear
    end
  end

  def prompt
    "> "
  end

  def convert_command(command_string)
    command_string.split
  end

  def quit?
    @command[0] == 'quit'
  end

  def help?
    @command[0] == 'help'
  end

  def load?
    @command[0] == 'load'
  end

  def find?
    @command[0] == 'find'
  end

  def queue?
    @command[0] == 'queue'
  end

  def save?

  end
end
