# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"
# ex:

# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

freq = Hash.new(0)
statement.split('').uniq.each do |k|
  freq[k] = statement.split('').count(k)
end

puts freq