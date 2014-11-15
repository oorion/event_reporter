module Help
  def help_commands
    {
      'help'             => "help <command>: Print help information for specified command.",
      'load'             => "load: Loads the default file.\nload <filename>: Loads the specified file.",
      'find'             => "find <attribute> <criteria>: Finds all items with attributes that match the criteria.",
      'queue count'      => "queue count: View the number of items in the queue.",
      'queue print'      => "queue print: Print the items in the queue.\nqueue print by <attribute>: Print the queue in the order of the specified attribute.",
      'queue save'       => "queue save to <filename.csv>: Save the queue to a new csv file.",
      'queue clear'      => "queue clear: Erases the current queue.",
      'quit'             => "quit: Exit the system."
    }
  end
end