require_relative '../test/test_helper'

class CLITest < Minitest::Test
  def test_load_default_load_csv
    cli = CLI.new($stdin, $stdout)
    cli.execute_load
    test_name = "#{cli.model.converted_csv_file.first[2]} #{cli.model.converted_csv_file.first[3]}"
    assert_equal "allison hankins", test_name
  end
end
