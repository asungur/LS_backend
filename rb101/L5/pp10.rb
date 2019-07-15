=begin
Given the following data structure and without modifying the original 
array, use the map method to return a new array identical 
in structure to the original but where the value of each integer 
is incremented by 1.
=end

a = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

b = a

b.map do |hsh|
  temp = {}
  hsh.each do |key, value|
    temp[key] = value + 1
  end
  temp
end

