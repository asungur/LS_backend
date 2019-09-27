class Cat
  attr_accessor :name, :purr_factor

  def initialize(name, factor)
    @name = name
    @purr_factor = factor
  end

  def miaow
    "#{name} is miaowing."
  end
end