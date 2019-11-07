class Bst
  attr_reader :data, :left, :right
  def initialize(int)
    @data = int
  end

  def insert(int)
    case int <=> data
    when 0, -1
      @left&.insert(int) || @left = Bst.new(int)
    else
      @right&.insert(int) || @right = Bst.new(int)
    end
  end

  def each
    return to_enum(:each) unless block_given?

    @left.each { |node| yield(node) } if @left
    yield(@data)
    @right.each { |node| yield(node) } if @right
  end
end
