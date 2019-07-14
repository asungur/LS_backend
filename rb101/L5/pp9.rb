#Given this data structure, return a new array of the same structure 
#but with the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map do |arr|
  arr.sort do |a, b|
    b <=> a
  end
end