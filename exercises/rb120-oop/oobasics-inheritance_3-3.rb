=begin
Using the following code, allow Truck to accept 
a second argument upon instantiation. Name the 
parameter bed_type and implement the modification 
so that Car continues to only accept one argument.
=end

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  #SOLUTION
  def initialize(year, bed_type)
    super(year)
    @bed_type = bed_type
  end
  #END OF THE SOLUTION
end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type

=begin
Expected output:

1994
Short
=end