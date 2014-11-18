require_relative '../test/test_helper'


class ModelTest < Minitest::Test
  def setup
    @model = Model.new
    @model.load("test.csv")
  end

  def test_find_returns_an_object
    assert @model.find(:first_name, "Allison")
  end

  # def test_find_returns_multipule_object
  #   assert_equal 2, @model.find(:first_name, "shannon").length
  # end

  def test_finds_the_first_name
    assert_equal "allison", @model.find(:first_name, "allison").first[:first_name]
  end
end
