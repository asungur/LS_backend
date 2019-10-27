class Triangle
  attr_reader :rows
  def initialize(max)
    @max = max
    generate
  end

  private
  
  def generate
    @rows = []
    last_row = [1]
    1.upto(@max) do |num|
      @rows << last_row if num == 1
      temp = []
      num.times { |n| last_row[n] }
    end
  end
end

