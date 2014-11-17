class EventQueue
  attr_reader :people

  def initialize
    @people = []
  end

  def add_people(more_people)
    @people += more_people
  end
end