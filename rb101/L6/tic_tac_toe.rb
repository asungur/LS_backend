require 'pry'
=begin
1. Display the initial empty 3x3 board
2. Ask the user to mark a square
3. Computer marks a square.
4. Display the updated board state
5. If winner, display winner.
6. If board full, display tie.
7. Nor go to #2
8. Play again?
9. If yes, go to #1
10.Ending message
=end
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  system 'clear'
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[2]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[3]}  |  #{brd[4]}  |  #{brd[5]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[6]}  |  #{brd[7]}  |  #{brd[8]}  "
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each {|iter| new_board[iter] = INITIAL_MARKER}
  new_board
end

def empty_squares(brd)
  brd.keys.select{|num| brd[num] == INITIAL_MARKER}
end

def player_places_pieces!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{empty_squares(brd).join(', ')}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "That's not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  sqr = empty_squares(brd).sample
  brd[sqr] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  winning_lines [[1,2,3], [4,5,6], [7,8,9]] + # rows
                [[1,4,7], [2,5,8], [3,6,9]] + # columns
                [[1,5,9], [3,5,7]]            # diagonals

  winning_lines.each do |line|

board = initialize_board
display_board(board)

loop do
  player_places_pieces!(board)
  computer_places_piece!(board)
  display_board(board)
  break if someone_won?(board) || board_full?(board)
end

if someone_won?(board)
  prompt "#{detect_winner(board)} won!"
else
  prompt "It's a tie!"