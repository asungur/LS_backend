=begin
Write a method that displays an 8-pointed star in an nxn grid,
where n is an odd integer that is supplied as an argument to the method.
The smallest such star you need to handle is a 7x7 grid.
=end


def star(n)
  puts "ERROR!" if n.even?
  center = "*" * n
  base = (" " * n).split('')
  mid = (n-1)/2
  n.times do |i|
    if i < mid || i > mid
      puts base.map.with_index {
        |item, t| [i,-(i+1)+n,mid].include?(t) ? "*" : " "
      }.join('')
    elsif i == mid
      puts center
    else
      puts "ERROR!"
    end
  end
end

