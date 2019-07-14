# Given the array below

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# Turn this array into a hash where the names are the keys and the values are the positions in the array.

flintstones_2 = Hash.new

flintstones.each_with_index do |val,i|
    flintstones_2[val] = i
end
puts flintstones_2