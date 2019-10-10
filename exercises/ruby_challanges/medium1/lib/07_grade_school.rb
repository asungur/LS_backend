class School
  def initialize
    @class = Hash.new([])
  end

  def to_h
    @class.sort.map { |key, val| [key,val.sort] }.to_h
  end

  def add(student, grade)
    @class.has_key?(grade) ? @class[grade] << student : @class[grade] = [student]
  end

  def grade(grade)
    @class.has_key?(grade) ? @class[grade] : []
  end
end
