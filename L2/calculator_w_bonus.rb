LANGUAGE = 'en'

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt1(key)
  message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message}")
end

def prompt2(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  /\d/.match(num) && /^\d*\.?\d*$/.match(num)
end

def operation_to_message(op)
  op = case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
  op
end

prompt1('welcome')

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt1('no_name')
  else
    break
  end
end

prompt2("Hi #{name}")

loop do # main loop
  number1 = ''
  loop do
    prompt1('ask_num_1')
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt1('invalid_num')
    end
  end

  number2 = ''
  loop do
    prompt1('ask_num_2')
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt1('invalid_num')
    end
  end

  prompt1('operator_prompt')

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt1('validate_op')
    end
  end

  operator_prompt= <<-MSG
  What operation would you like to perform?
  1) add
  2) subtract
  3) multiply
  4) divide
  MSG

  prompt2("#{operation_to_message(operator)} the two numbers...")

  result =
    case operator
    when '1'
      number1.to_i() + number2.to_i()
    when '2'
      number1.to_i() - number2.to_i()
    when '3'
      number1.to_i() * number2.to_i()
    when '4'
      number1.to_f() / number2.to_f()
    end

  prompt2("The result is #{result}")

  prompt1('reoperate')
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt1('exit_msg')
