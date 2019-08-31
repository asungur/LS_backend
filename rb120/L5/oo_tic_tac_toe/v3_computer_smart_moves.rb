require 'pry'
module ClearScreen
  def screen_clear
    system('clear') || system('clr')
  end
end

class Board
  attr_reader :board_size, :winning_lines, :squares
  EMPTY_ROW_LEFT = ("     ")
  EMPTY_ROW_RIGHT = ("|      ")
  EMPTY_ROW_MID = ("|     ")
  RULE_ROW_LEFT = ("-----")
  RULE_ROW_RIGHT = ("|-----")
  BOARD_SIZE_OPTIONS = [3, 5, 7, 9].freeze

  def initialize
    @squares = {}
    set_board_size
    reset
    set_winning_line
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  def winning_marker
    winning_lines.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != board_size
    markers.min == markers.max
  end

  def reset
    (1..(board_size**2)).each { |num| @squares[num] = Square.new }
  end

  def centre_index
    (board_size**2 + 1) / 2
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    (1..board_size).each do |i|
      puts EMPTY_ROW_LEFT + EMPTY_ROW_MID * (board_size - 2) + EMPTY_ROW_RIGHT
      row_with_value = ''
      (1..board_size).each do |t|
        square_index = ((i - 1) * board_size) + t
        row_with_value << if t == 1
                            "  #{@squares[square_index]}  "
                          else
                            "|  #{@squares[square_index]}  "
                          end
      end
      puts row_with_value
      puts EMPTY_ROW_LEFT + EMPTY_ROW_MID * (board_size - 2) + EMPTY_ROW_RIGHT
      puts RULE_ROW_LEFT + RULE_ROW_RIGHT * (board_size - 1) if i != board_size
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def first_row?(index)
    size = board_size
    (1..size).cover?(index)
  end

  def first_column?(index)
    n = board_size
    index % n == 1
  end

  def row_cells(index)
    cells = []
    (0...board_size).each do |n|
      cells << (index + n)
    end
    cells
  end

  def column_cells(index)
    cells = []
    (0...board_size).each do |n|
      cells << (index + (n * board_size))
    end
    cells
  end

  def diagonal_cells_back(index)
    cells = []
    (0...board_size).each do |n|
      cells << index + (board_size + 1) * n
    end
    cells
  end

  def diagonal_cells_forward(index)
    cells = []
    (0...board_size).each do |n|
      cells << index + (board_size - 1) * n
    end
    cells
  end

  # rubocop:disable Metrics/AbcSize
  def set_winning_line
    winning_lines = []
    n = board_size
    (1..(n**2)).each do |i|
      if first_column?(i)
        winning_lines << diagonal_cells_back(i) if i == 1
        winning_lines << column_cells(i) if i == 1
        winning_lines << row_cells(i)
      elsif first_row?(i)
        winning_lines << diagonal_cells_forward(i) if i == n
        winning_lines << column_cells(i)
      end
    end
    @winning_lines = winning_lines
  end
  # rubocop:enable Metrics/AbcSize

  def set_board_size
    size = ''
    puts "Please set board size: #{BOARD_SIZE_OPTIONS.join(', ')}"
    loop do
      input = gets.chomp.to_s
      size = input.gsub(/[^0-9]/i, '').to_i
      break if BOARD_SIZE_OPTIONS.include?(size)
      puts "Invalid selection"
    end
    @board_size = size.to_i
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :name, :score

  def initialize(player_type = :human)
    @player_type = player_type
    @name = set_name if human?
    @marker = if human?
                set_marker
              else
                TTTGame::COMPUTER_MARKER
              end
    @score = 0
  end

  def move(board, other_player)
    if human?
      puts "Choose a square between (#{board.unmarked_keys.join(', ')}): "
      square = nil
      loop do
        square = gets.chomp.to_i
        break if board.unmarked_keys.include?(square)
        puts "Sorry, that's not a valid choice."
      end
      board[square] = marker
    else
      computer_places_piece(board, other_player)
    end
  end

  def update_score
    @score += 1
  end

  def reset_score
    @score = 0
  end

  private

  def find_at_risk(ln, brd, marker)
    arr_search = brd.squares.values.map(&:marker)
    initial_marker = Square::INITIAL_MARKER
    hsh_squares = brd.squares.select do |k, v|
      ln.include?(k - 1) && v.marker == initial_marker
    end
    square_under_risk(arr_search, ln, marker) ? hsh_squares.keys.first : nil
  end

  def square_under_risk(array, line, marker)
    array.values_at(*line).count(marker) == (line.size - 1)
  end

  def strategy(brd, marker)
    sqr = nil
    brd.winning_lines.each do |line|
      search_lines = line.map { |val| val - 1 }
      sqr = find_at_risk(search_lines, brd, marker)
      break if sqr
    end
    sqr
  end

  def computer_places_piece(brd, other_player)
    centre_marker = brd.squares[brd.centre_index].marker

    sqr = strategy(brd, marker)
    sqr = strategy(brd, other_player.marker) if !sqr
    sqr = brd.centre_index if centre_marker == Square::INITIAL_MARKER
    sqr = brd.unmarked_keys.sample if !sqr
    brd[sqr] = marker
  end

  def set_marker
    marker = ''
    loop do
      puts "Please select a marker(#{TTTGame::HUMAN_MARKER.join(', ')})"
      marker = gets.chomp.to_s.upcase
      break if TTTGame::HUMAN_MARKER.include? marker
      puts "Sorry, must choose from the given markers"
    end
    marker
  end

  def set_name
    name = ''
    loop do
      puts "Please enter your name:"
      input = gets.chomp.to_s
      name = input.gsub(/[^0-9a-z-]/i, '')
      break unless name.empty?
      puts "Sorry, must enter a value"
    end
    name
  end

  def human?
    @player_type == :human
  end
end

class TTTGame
  HUMAN_MARKER = %w(A X Y Z M Q @ + * $).freeze
  COMPUTER_MARKER = 'O'

  def play
    display_welcome_message
    screen_clear
    loop do
      game_loop
      display_result
      break unless play_again?
      reset_game
      display_new_game_message
    end
    display_goodbye_message
  end

  private

  FIRST_TO_MOVE = 'human' # 'human' or 'computer'
  attr_reader :board, :human, :computer
  attr_accessor :score_to_win

  include ClearScreen

  def game_loop
    loop do
      display_score_new_round
      display_board
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        display_board_on_clean_screen if human_turn?
      end
      display_and_update_score
      grand_winner? ? break : next_round
    end
  end

  def next_round
    puts "Next round starts in 5..."
    sleep(5)
    reset_round
  end

  def grand_winner?
    score_to_win == human.score || score_to_win == computer.score
  end

  def display_and_update_score
    display_board_on_clean_screen
    case board.winning_marker
    when human.marker
      human.update_score
      puts "You won!"
    when computer.marker
      computer.update_score
      puts "Computer won!"
    else
      puts "The board is full!" + "It's a tie!"
    end
    display_score
  end

  def display_score_new_round
    puts "Defeat computer #{score_to_win} times to win"
    display_score
  end

  def display_score
    puts "#{human.name}: #{human.score}"
    puts "Computer: #{computer.score}"
  end

  def initialize(score = 5)
    @human = Player.new
    @computer = Player.new(:computer)
    @board = Board.new
    reset_marker
    @score_to_win = score
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "#{human.name} is #{human.marker}, Computer is #{computer.marker}"
    puts ""
    puts ""
    board.draw
    puts ""
  end

  def display_board_on_clean_screen
    screen_clear
    display_board
  end

  def human_turn?
    @current_marker == human.marker
  end

  def current_player_moves
    if human_turn?
      human.move(board, computer)
      @current_marker = COMPUTER_MARKER
    else
      computer.move(board, human)
      @current_marker = human.marker
    end
  end

  def display_result
    display_board_on_clean_screen
    case score_to_win
    when human.score
      puts "You won!"
    when computer.score
      puts "Computer won!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def display_new_game_message
    puts "Started a new game:"
    puts ""
  end

  def reset_game
    reset_round
    human.reset_score
    computer.reset_score
  end

  def reset_marker
    @current_marker = if FIRST_TO_MOVE == 'human'
                        human.marker
                      else
                        computer.marker
                      end
  end

  def reset_round
    board.reset
    reset_marker
    screen_clear
  end
end

game = TTTGame.new(3)
game.play
