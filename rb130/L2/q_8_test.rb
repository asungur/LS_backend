require 'minitest/autorun'
require_relative 'q_8'


class CatTest < MiniTest::Test
  def setup
    @kitty = Cat.new('Kitty', 3)
  end

  def test_is_cat; end

  def test_name
    assert_equal(@kitty.name, 'Milo')
  end

  def test_miaow
  end

  def test_raises_error; end

  def test_is_not_purrier
  end
end