class WordProblem
  OPERATIONS = {
  '+' => 'plus',
  '-' => 'minus',
  '/' => 'divided by',
  '*' => 'multiplied by',
  }

  def initialize(question)
    unless question =~ /What is /
      raise ArgumentError, "Invalid Question"
    else
      @operation = question.gsub(/(What is |\?)/, '')
    end
  end

  def answer
    conversion
    calculation
  end

  private

  def conversion
    OPERATIONS.each do |k,v|
      @operation.gsub!(v, k)
    end
  end

  def calculation
    operation_arr = @operation.split(' ')
    num1 = operation_arr.shift.to_i
    while operation_arr.size > 0 do
      operation = operation_arr.shift
      unless OPERATIONS.keys.include? operation
        raise ArgumentError, "Invalid Operator"
      end
      num2 = operation_arr.shift.to_i
      num1 = num1.send(operation, num2)
    end
    num1
  end
end
