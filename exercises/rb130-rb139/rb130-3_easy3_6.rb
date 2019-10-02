class NoExperienceError < StandardError; end

class Employee
  def hire
    raise NoExperienceError
  end
end


require 'minitest/autorun'


class ExceptionAssertions < Minitest::Test
  def setup
    @jon = Employee.new
  end
  def test_hire
    assert_raises(NoExperienceError) { @jon.hire}
  end
end