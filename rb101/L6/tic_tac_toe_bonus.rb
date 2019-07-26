FIRST_MOVE = 'player'
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals
ROUNDS_TO_WIN = 5
CHOOSE_MESSAGE = <<-MSG
Select the first player:
type p or player
OR
type c or computer
MSG

# rubocop:disable Metrics/CyclomaticComplexity
def selective_move
  player = nil
  input = nil
  valid_choices = %w(p player c computer)
  loop do
    puts CHOOSE_MESSAGE
    input = gets.chomp.to_s
    break if valid_choices.include?(input)
    prompt "Invalid choice"
  end
  player = "Computer" if input == 'c' || input == 'computer'
  player = "Player" if input == 'p' || input == 'player'
  return player if !!player
  nil
end
# rubocop:enable Metrics/CyclomaticComplexity

def joinor(arr, sep = ', ', last = 'or')
  arr[-1] = last + ' ' + arr[-1].to_s
  arr.join(sep)
end

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize, MethodLength, UnneededInterpolation
def display_board(brd, scr)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |"
  puts ""
  puts "#{scr.map { |k, v| "#{k}=#{v}" }.join(' & ')}"
end
# rubocop:enable Metrics/AbcSize, MethodLength, UnneededInterpolation

def initialize_board
  new_board = {}
  (1..9).each { |iter| new_board[iter] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def place_piece!(brd, initial_player)
  if initial_player == 'Player'
    player_places_pieces!(brd)
  elsif initial_player == 'Computer'
    computer_places_piece!(brd)
  end
end

def change_player(initial_player)
  initial_player == "Player" ? "Computer" : "Player"
end

def player_places_pieces!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp
    square = square.to_i if square.to_f % 1 == 0
    break if square.to_f % 1 == 0 && empty_squares(brd).include?(square)
    prompt "That's not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk(ln, brd, marker)
  if brd.values_at(*ln).count(marker) == 2
    brd.select { |k, v| ln.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def strategy(brd, marker)
  sqr = nil
  WINNING_LINES.each do |line|
    sqr = find_at_risk(line, brd, marker)
    break if sqr
  end
  sqr
end

def computer_places_piece!(brd)
  sqr = strategy(brd, COMPUTER_MARKER)
  sqr = strategy(brd, PLAYER_MARKER) if !sqr
  sqr = 5 if !sqr && brd[5] == INITIAL_MARKER
  sqr = empty_squares(brd).sample if !sqr

  brd[sqr] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def detect_grand_winner(scr)
  if scr.value?(ROUNDS_TO_WIN)
    return scr.key(ROUNDS_TO_WIN)
  end
  nil
end

def someone_won_the_game?(scr)
  !!detect_grand_winner(scr)
end

def valid_exit?(ans)
  ans == 'n' || ans == 'no'
end

def valid_replay?(ans)
  ans == 'y' || ans == 'yes'
end

loop do
  round = 1
  score = { "Player" => 0, "Computer" => 0 }
  current_player = nil
  answer = nil
  loop do
    board = initialize_board
    display_board(board, score)

    case FIRST_MOVE
    when 'choose' then current_player = selective_move
    when 'player' then current_player = 'Player'
    when 'computer' then current_player = 'Computer'
    end

    loop do
      display_board(board, score)
      place_piece!(board, current_player)
      current_player = change_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board, score)

    round += 1

    if someone_won?(board)
      score[detect_winner(board)] += 1
    else
      prompt "It's a tie!"
    end

    break if someone_won_the_game?(score)
  end

  prompt "#{detect_grand_winner(score)} won!"
  prompt "Play again? (y or n)"
  loop do
    answer = gets.chomp
    break if valid_exit?(answer) || valid_replay?(answer)
    prompt "Invalid answer.."
  end
  break if valid_exit?(answer)
end

prompt "Thank's for playing Tic Tac Toe! Good bye.."
