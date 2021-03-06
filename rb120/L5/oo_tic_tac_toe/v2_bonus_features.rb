module ClearScreen
  def screen_clear
    system('clear') || system('clr')
  end
end

class Board
  attr_reader :board_size, :winning_lines
  # WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
  #                 [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
  #                 [[1, 5, 9], [3, 5, 7]].freeze

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
    return false if markers.size != 3
    markers.min == markers.max
  end

  def reset
    (1..(board_size**2)).each { |num| @squares[num] = Square.new }
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

  def corner_cell?(index)
    size = board_size
    [1, size, size**2, (size * (size - 1) + 1)].include?(index)
  end

  def first_last_row?(index)
    size = board_size
    (index % size != 0 || index % size != 1)
  end

  def first_last_col?(index)
    n = board_size
    (2...n).cover?(index) || ((n * (n - 1) + 2)...(n**2)).cover?(index)
  end

  def row_cells(index)
    [(index - 1), index, (index + 1)]
  end

  def column_cells(index)
    [(index - board_size), index, (index + board_size)]
  end

  def diagonal_cells_back(index) # diagonal \
    [(index - board_size - 1), index, (index + board_size + 1)]
  end

  def diagonal_cells_forward(index) # diagonal /
    [(index - board_size + 1), index, (index + board_size - 1)]
  end

  # rubocop:disable Metrics/AbcSize
  def set_winning_line
    winning_lines = []
    n = board_size
    (1..(n**2)).each do |i|
      if first_last_col?(i)
        winning_lines << row_cells(i)
      elsif first_last_row?(i) && !corner_cell?(i)
        winning_lines << column_cells(i)
      elsif !corner_cell?(i)
        winning_lines << diagonal_cells_back(i)
        winning_lines << diagonal_cells_forward(i)
        winning_lines << column_cells(i)
        winning_lines << row_cells(i)
      end
    end
    @winning_lines = winning_lines
  end
  # rubocop:enable Metrics/AbcSize

  EMPTY_ROW_LEFT = ("     ")
  EMPTY_ROW_RIGHT = ("|      ")
  EMPTY_ROW_MID = ("|     ")
  RULE_ROW_LEFT = ("-----")
  RULE_ROW_RIGHT = ("|-----")

  def set_board_size
    size = ''
    puts "Please set board size between 3 to 9: (N for NxN board)"
    loop do
      input = gets.chomp.to_s
      size = input.gsub(/[^0-9]/i, '')
      break unless size.empty?
      puts "Please enter a valid number between 3 to 9:"
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

  def move(board)
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
      board[board.unmarked_keys.sample] = marker
    end
  end

  def update_score
    @score += 1
  end

  def reset_score
    @score = 0
  end

  private

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
      human.move(board)
      @current_marker = COMPUTER_MARKER
    else
      computer.move(board)
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
