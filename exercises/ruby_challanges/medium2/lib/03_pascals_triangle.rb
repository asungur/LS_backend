class Triangle
  attr_reader :rows
  def initialize(max)
    @max = max
    generate
  end

  private

  def generate
    @rows = []
    1.upto(@max) do |row_num|
      row_arr = []
      1.upto(row_num) do |num|
        if num == 1 || num == row_num
          row_arr << 1
        else
          new_val = @rows[row_num - 2][num - 2] + @rows[row_num - 2][num - 1]
          row_arr << new_val
        end
      end
      @rows << row_arr
    end
  end
end
