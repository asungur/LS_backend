# Write a method that returns true if its argument looks like a URL, false if it does not.

def url?(string)
  !!(string =~ /\Ahttps?:\/\/\S+\z/)
end


p url?('http://launchschool.com')   # -> true
p url?('https://example.com')       # -> true
p url?('https://example.com hello') # -> false
p url?('   https://example.com')    # -> false