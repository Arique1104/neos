require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test

  def set_up
    neo = NearEarthObjects.new("09-30-2020")

  end
  def test_a_date_returns_a_list_of_neos
    results = NearEarthObjects.find_neos_by_date('2019-03-30')
    assert_equal '(2019 GD4)', results[:asteroid_list][0][:name]
  end

  # def test_it_can_load
  #   results = NearEarthObjects.find_neos_by_date('2019-03-30')
  #   assert_equal "", results.formatted_asteroid_data
  # end
end
