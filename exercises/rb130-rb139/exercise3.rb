require 'minitest/autorun'


class RefuteIncludes < Minitest::Test
  def setup
    @value = [1, 2, 3]
  end

  def test_includes
    refute_includes(@value, 'xyz')
  end
end