require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative '01_car'

class CarTest < MiniTest::Test
  # setup
  def setup
    @car = Car.new
  end
  # assert
  def test_car_exists
    assert(@car)
  end
  # assert_equal
  def test_wheels
    assert_equal(4, @car.wheels)
  end
  # assert_nil
  def test_name_is_nil
    assert_nil(@car.name)
  end
  # assert_raises
  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      Car.new(name: "Joey")
    end
  end
  # assert_instance_of
  def test_instance_of_car
    assert_instance_of(Car, @car)
  end
  # assert_includes
  def test_includes_car
    arr = [1, 2, 3]
    arr << @car
  
    assert_includes(arr, @car)
  end
end