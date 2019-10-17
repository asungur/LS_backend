# Challenge: write a method that changes dates in the format 2016-06-17 or 2016/06/17 to the format 17.06.2016. You must use a regular expression and should use methods described in this section.


def format_date(string)
  string.sub(/\A(\d\d\d\d)([\/\-])(\d\d)\2(\d\d)\z/, '\4.\3.\1')
end


p format_date('2016-06-17') # -> '17.06.2016'
p format_date('2017/05/03') # -> '03.05.2017'
p format_date('2015/01-31') # -> '2015/01-31' (no change)