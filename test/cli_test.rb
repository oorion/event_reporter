require_relative '../test/test_helper'

class CLITest < Minitest::Test
  def test_load_default_load_csv
    cli       = CLI.new($stdin, $stdout)
    csv_file      = cli.load
    test_name = "#{csv_file.first[2]} #{csv_file.first[3]}"
    assert_equal "Allison Hankins", test_name
  end

end
