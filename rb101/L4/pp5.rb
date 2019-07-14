# In the array:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
# Find the index of the first name that starts with "Be"

flintstones.each_with_index do |v,i|
  puts i if v[0..1] == "Be"
end

