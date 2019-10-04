class Series
  def initialize(str)
    @item = str.split('').map(&:to_i)
  end

  def slices(n)
    return_arr = []
    if n > @item.size
      raise ArgumentError, "slice size is larger than input string"
    else
      index = 0
      while index + n - 1 < @item.size
        return_arr << @item[index..(index + n - 1)]
        index += 1
      end
    end
    return_arr
  end
end