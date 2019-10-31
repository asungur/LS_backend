# Example 1: Output a string if it is longer than 0.

string='Hello'

if [[ -n $string ]]
then
  echo $string
fi

# Example 2: Compare two integers and output a string if they are equal.

integer_1=10
integer_2=10

if [[ $integer_1 -eq $integer_2 ]]
then
  echo $integer_1 and $integer_2 are the same!
fi

# Example 3: Output 'File exists' if the file hello_world.sh exists.

if [[ -e ./hello_world.sh ]]
then
  echo 'File exists'
fi

# MULTIPLE CONDITIONS

# Example 1: nested if statement

integer=4

if [[ $integer -lt 10 ]]
then
  echo $integer is less than 10

  if [[ $integer -lt 5 ]]
  then
    echo $integer is also less than 5
  fi
fi

# Example 2: two conditional branches with if and else

integer=15

if [[ $integer -lt 10 ]]
then
  echo $integer is less than 10
else
  echo $integer is not less than 10
fi

# Example 3: three conditional branches with if, elif, and else

integer=15

if [[ $integer -lt 10 ]]
then
  echo $integer is less than 10
elif [[ $integer -gt 20 ]]
then
  echo $integer is greater than 20
else
  echo $integer is between 10 and 20
fi

# Example 4: matching two conditions using && (and)

integer=15

if [[ $integer -gt 10 ]] && [[ $integer -lt 20 ]]
then
  echo $integer is between 10 and 20
fi

# Example 5: matching one of two conditions using || (and)

integer=7

if ! ([ $integer -eq 5 ]) || ! ([ $integer -eq 6 ])
then
  echo $integer is not 5 or 6
fi