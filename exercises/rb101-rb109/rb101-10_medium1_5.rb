=begin
1. Set row element of n spaces
2. mid element is always a star
3. print the element n times
4. each iteration adds two stars either side of the centre star
5. iteration add until (n+1)/2
6. iteration subtract stars till the end
=end
# SOLUTION 1
=begin
def diamonds(num)
  spaces = " " * num
  star = "*"
  num.times do |index|
    star += ("*" * 2) if index <= (num-1)/2 && index > 0
    star = star.chop.chop if index >= (num+1)/2
    puts star.center(spaces.size)
  end
end
diamonds(3)
=end
#FURTHER EXPLORATION - AKA BORDER PYRAMID
=begin
def diamonds(num)
  spaces = " " * num
  star = "*"
  num.times do |index|
    star += ("*" * 2) if index <= (num-1)/2 && index > 0
    star = star.chop.chop if index >= (num+1)/2
    puts star.center(spaces.size) if  star.size == 1
    puts ("*" + " " * (star.size-2) + "*").center(spaces.size) if star.size > 1
  end
end
diamonds(7)
=end