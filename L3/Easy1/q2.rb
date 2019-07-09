=begin
Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:

what is != and where should you use it?
put ! before something, like !user_name
put ! after something, like words.uniq!
put ? before something
put ? after something
put !! before something, like !!user_name
=end

#ANSWER

=begin

Defines the way given method works.
! if methods defines the caller
? if method returns a boolean

1. not equal to, can be used as not logic gate
2. 1 != 2 => true
3. a = "Hello"
    a.downcase => wont mutate
    a.downcase! => will mutate
4. conditional ? Do sth if true : Do sth if false
5. method? method returns boolean acc. to the argument
6. !!object = notnot, gives boolean equiv. of the object

=end

