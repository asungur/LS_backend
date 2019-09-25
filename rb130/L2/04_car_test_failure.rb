require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative '01_car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
  # FAILURES
  def test_bad_wheels
    car = Car.new
    assert_equal(3, car.wheels)
  end
end