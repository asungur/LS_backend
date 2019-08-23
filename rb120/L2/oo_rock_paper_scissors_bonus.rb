class Move
  VALUES = %w(rock paper scissors)

  def initialize(val)
    @value = val
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :score
  attr_reader :name
  
  def initialize
    set_name
    @score = 0
  end
  
  # SCORE RELATED METHODS
  def update_score
    self.score += 1
  end
  
  def reset_score
    self.score = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize(to_win)
    @human = Human.new
    @computer = Computer.new
    @target_rounds = to_win
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end
  
  def select_winner
    if human.move > computer.move
      'player'
    elsif human.move < computer.move
      'computer'
    else
      'tie'
    end
  end

  def display_winner
    winner = select_winner
    case winner
    when 'player'
      puts "#{human.name} won!"
    when 'computer'
      puts "#{computer.name} won!"
    when 'tie'
      puts "It's a tie"
    end
  end
  
  def modify_score(winner)
    case winner
    when 'player'
      human.update_score
    when 'computer'
      computer.update_score
    end
  end
  
  def show_score
    puts "Current score is:"
    puts "#{human.name}: #{human.score}"
    puts "#{computer.name}: #{computer.score}"
    puts ""
  end
  
  def grand_winner?
    human.score == @target_rounds || computer.score == @target_rounds
  end
  
  def grand_winner
    if human.score == @target_rounds
      return human.name
    elsif computer.score == @target_rounds
      return computer.name
    else
      #GUARD LINE
      puts "ERROR:Leak in grand_winner condition!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def game_loop
    loop do
      human.choose
      computer.choose
      select_winner
      display_winner
      update_score
      show_score
      break if grand_winner?
    end
  end
  
  def display_grand_winner
    champion = grand_winner
    puts ""
    puts "The grand winner is: #{champion.capitalize}"
    puts ""
  end

  def play
    display_welcome_message
    loop do
      game_loop
      display_grand_winner
      break unless play_again?
    end
    display_goodbye_message
  end
  

  
end
RPSGame.new.play(6)
