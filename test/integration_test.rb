require_relative 'test_helper'

class IntegrationTest < Minitest::Test
  def test_help_can_look_up_help_message
    instream = StringIO.new("help load\nquit\n")
    outstream = StringIO.new
    cli = CLI.new(instream, outstream).call
    assert_includes outstream.string, "load: Loads the default file.\nload <filename>: Loads the specified file."
  end

  def test_queue_can_print
    instream = StringIO.new("load\nfind first_name Shiyu\nqueue print\nquit\n")
    outstream = StringIO.new
    cli = CLI.new(instream, outstream).call
    print_result = " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,"
                "Street,City,State,Zipcode\n9,11/13/08 1:32,Shiyu,Armideo,"
                "odfarg06@jumpstartlab.com,8084974000,644 Ikemaka PL,Kailua,HI,96734"
    assert_equal print_result, outstream.string
  end
end
