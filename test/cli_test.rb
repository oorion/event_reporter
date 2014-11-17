require_relative '../test/test_helper'

class CLITest < Minitest::Test
  def test_load_default_load_csv
    cli       = CLI.new($stdin, $stdout)
    model     = cli.load
    test_name = "#{model.csv_file.first[2]} #{model.csv_file.first[3]}"
    assert_equal "Allison Hankins", test_name
  end

end
