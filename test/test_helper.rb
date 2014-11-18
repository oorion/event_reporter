lib_dir = File.expand_path("../lib", __dir__)
$LOAD_PATH.unshift(lib_dir)


gem 'minitest', '~> 5.2'

require 'minitest/autorun'
require 'minitest/pride'
require 'csv'

require 'cli'
require 'event_queue'
require 'build_file'
