# Shorten this sentence:

advice = "Few things in life are as important as house training your pet dinosaur."
# ...remove everything starting from "house".

p advice.slice!(39..-1)

# OR LS solution

advice.slice!(0, advice.index('house'))
