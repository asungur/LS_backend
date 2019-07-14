# Given the munsters hash below

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
=begin
Modify the hash such that each member of the Munster family has an additional
"age_group" key that has one of three values describing the age group the family 
member is in (kid, adult, or senior).
a kid is in the age range 0 - 17, an adult is in the range 
18 - 64 and a senior is aged 65+.
=end
munsters.each_value do |val|
  case val["age"] 
  when [0..17]
    val["age_group"] = "kid"
  when [18..64]
    val["age_group"] = "adult"
  else
    val["age_group"] = "senior"
  end
end
puts munsters