# prompt message
def prompt(message)
  puts "=> #{message}"
end

# Integer validity check (for loan and interest rate)
def check_valid(num)
  if num > 0 && !num.nil?
    true
  else
    false
  end
end

# Welcome message
prompt("Welcome to mortgage calculator app.")

loop do
  # Ask for the loan amount. Ex: 200000 for 200,000$. Check formatting
  loan = ''
  loop do
    prompt("Please enter the loan amount (Ex: 2000 for 2,000£)")
    loan = Kernel.gets().chomp().to_i
    if check_valid(loan)
      break
    else
      prompt("The number you entered is invalid")
    end
  end

  # Ask for the interested rate. Ex: 5 for 5%. Check formatting
  rate = ''
  loop do
    prompt("Please enter the interest rate (Ex: 5 for 5%)")
    rate = Kernel.gets().chomp().to_i
    if check_valid(rate)
      break
    else
      prompt("The number you entered is not valid, check formatting")
    end
  end

  # Ask for the loan duration. Ex: 16 for 16 months/1.5 years. Check formatting
  duration = ''
  loop do
    prompt("Please enter the loan duration in months (Ex: 16 for 1.5 years)")
    duration = Kernel.gets().chomp().to_i
    if check_valid(duration)
      break
    else
      prompt("Duration you entered is not valid")
    end
  end

  # Calculate the payment and give the message
  payment = loan * ((rate * 0.1) / (1 - (1 + (rate * 0.1))**-duration))
  prompt("Calculating...")
  prompt("Your monthly payment will be #{payment.to_i}£")

  # Ask if user wants to run another calculation
  prompt("Would you like to run the calculator again? (Y to run)")
  rerun = Kernel.gets().chomp().to_s.downcase
  if rerun != 'y'
    break
  end
end

prompt("Thanks for using the mortgage calculator")
prompt("Bye!")
