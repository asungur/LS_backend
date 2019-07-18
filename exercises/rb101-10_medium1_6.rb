=begin
Write a method that implements a miniature stack-and-register-based programming language that has the following commands:

n Place a value n in the "register". Do not modify the stack.
PUSH Push the register value on to the stack. Leave the value in the register.
ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
POP Remove the topmost item from the stack and place in register
PRINT Print the register value
All operations are integer operations (which is only important with DIV and MOD).

Programs will be supplied to your language method via a string passed in as an argument. Your program may assume that all programs are correct programs; that is, they won't do anything like try to pop a non-existent value from the stack, and they won't contain unknown tokens.

You should initialize the register to 0.

Examples:

minilang('PRINT')
# 0

minilang('5 PUSH 3 MULT PRINT')
# 15
=end


def minilang(input)
  stack = []
  register = 0
  input.split(' ').each_with_index do |val,i|
  if val.is_a?.integer
    register += val.to_i
  else
    when val
      case 'PUSH' then stack << register
      case 'ADD' then register += stack.pop
      case 'SUB' then register -= stack.pop
      case 'MULT' then register *= stack.pop
      case 'DIV' then register = register / stack.pop
      case 'MOD' then register = register % stack.pop
      case 'POP' then register = stack.pop
      case 'PRINT' then puts register
    end
  end
end
