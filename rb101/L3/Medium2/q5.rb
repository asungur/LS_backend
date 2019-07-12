def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
  # NEW
  return [a_string_param, an_array_param]
end

my_string = "pumpkins"
my_array = ["pumpkins"]
# current tricky_method(my_string, my_array)
my_string = tricky_method(my_string, my_array)[0]
my_array = tricky_method(my_string, my_array)[1]


# ANSWER


puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

#How can we refactor this practice problem to make 
# the result easier to predict and easier for the next programmer to maintain?

