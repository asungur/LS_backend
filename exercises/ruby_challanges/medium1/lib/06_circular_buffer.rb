class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(num)
    @buffer = []
    @size = num
  end

  def read
    raise BufferEmptyException if @buffer.empty?
    if @buffer.any?
      @buffer.shift
    end
  end

  def write(item)
    raise BufferFullException if @buffer.size == @size
    @buffer << item if !!item
  end

  def write!(item)
    if !!item
      @buffer.delete_at(0) if @buffer.size == @size
      @buffer << item
    end
  end

  def clear
    @buffer = []
  end
end

