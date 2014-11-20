require_relative 'test_helper'

class IntegrationTest < Minitest::Test
  def test_help_can_look_up_help_message
    instream = StringIO.new("help load\nquit\n")
    outstream = StringIO.new
    cli = CLI.new(instream, outstream).call
    assert_includes outstream.string, "load: Loads the default file.\nload <filename>: Loads the specified file."
  end

  def test_can_load_csv_file
    instream = StringIO.new("load\nquit\n")
    outstream = StringIO.new
    cli = CLI.new(instream, outstream)
    cli.call
    assert cli.model.entry_repository.length > 0
  end

  def test_can_count_the_queue
    instream = StringIO.new("load\nfind first_name John\nqueue count\nquit\n")
    outstream = StringIO.new
    cli = CLI.new(instream, outstream)
    cli.call
    assert_includes outstream.string, "63"
  end

  def test_can_print_queue
    instream = StringIO.new("load\nfind first_name John\nqueue print\nquit\n")
    outstream = StringIO.new
    cli = CLI.new(instream, outstream)
    cli.call
    test_string = "abdulkarim	john	iwbaugh@jumpstartlab.com	19149	philadelphia	"
                  "pa	1434 elbridge st	215-743-4000"
    assert_includes outstream.string, test_string
  end

  def test_can_print_queue_by_attribute
    instream = StringIO.new("load\nfind first_name John\nqueue print by last_name\nquit\n")
    outstream = StringIO.new
    cli = CLI.new(instream, outstream)
    cli.call
    test_string = "LAST_NAME	FIRST_NAME	EMAIL_ADDRESS	ZIPCODE	CITY	STATE	STREET	HOMEPHONE\nabdulkarim	john	iwbaugh@jumpstartlab.com	19149	philadelphia	pa	1434 elbridge st	215-743-4000"
    assert_includes outstream.string, test_string
  end
end
