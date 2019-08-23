class Move
  VALUES = { rock: %w(r rock),
             paper: %w(p paper),
             scissors: %w(s scissors),
             lizard: %w(l lizard),
             spock: %w(sp spock) }.freeze

  def initialize(val)
    @value = val.downcase.to_s
  end

  # IS? METHODS
  def rock?
    @value == 'rock' || @value == 'r'
  end

  def paper?
    @value == 'paper' || @value == 'p'
  end
  
  def scissors?
    @value == 'scissors' || @value == 's'
  end

  def lizard?
    @value == 'lizard' || @value == 'l'
  end
  
  def spock?
    @value == 'spock' || @value == 'sp'
  end
  
  # LOSE TO METHODS
  def lose_to_rock?
    lizard? || scissors?
  end
  
  def lose_to_paper?
    rock? || spock?
  end
  
  def lose_to_scissors?
    paper? || lizard?
  end
  
  def lose_to_lizard?
    spock? || paper?
  end
  
  def lose_to_spock?
    rock? || scissors?
  end
  
  # WIN TO METHODS
  def win_to_rock?
    spock? || paper?
  end
  
  def win_to_paper?
    lizard? || scissors?
  end
  
  def win_to_scissors?
    rock? || spock?
  end
  
  def win_to_lizard?
    rock? || scissors?
  end
  
  def win_to_spock?
    paper? || lizard?
  end

  def >(other_move)
    (rock? && other_move.lose_to_rock?) ||
      (paper? && other_move.lose_to_paper?) ||
      (scissors? && other_move.lose_to_scissors?) ||
      (lizard? && other_move.lose_to_lizard?) ||
      (spock? && other_move.lose_to_spock?)
  end

  def <(other_move)
    (rock? && other_move.win_to_rock?) ||
      (paper? && other_move.win_to_paper?) ||
      (scissors? && other_move.win_to_scissors?) ||
      (lizard? && other_move.win_to_lizard?) ||
      (spock? && other_move.win_to_spock?)
  end
  
  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :score, :name
  attr_reader :move_history

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
  
  private
  
  attr_writer :move_history
  
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
  
  def valid_choice?(val)
    Move::VALUES.values.flatten.include? val
  end
  
  def valid_choice(val)
    Move::VALUES.each_pair do |k, v|
      return k if v.include? val
    end
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp.downcase.to_s
      break if valid_choice?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(valid_choice(choice))
  end
end

class Computer < Player
  # COMPUTER BEHAVIOUR
  # Behaviour 1 AKA Counter => 
  #   1. Analyses player history
  #   2. Find the most common choice
  #   3. Find two counterpicks
  #   4. Put them in an array with another losing pick
  #   5. Choose a random pick from this list
  #   6. %66 percent counter pick to most common player choice
  
  # Behaviour 2 AKA Random
  #   Choose randomly
  
  # Behaviour 3 AKA Dumb
  #   Chooses rock only
  
  # Behaviour 4 AKA Old-man
  #   Chooses the 3 options from the prev. version of the game
  # -------------------------
  
  COMPUTER_SKILL_ASSG = { 'R2D2' => 1, 'Hal' =>1,
                          'Chappie' => 4, 'Sonny' => 2,
                          'Number 5' => 3}.freeze

  def set_computer
    i = rand(1..5)
    self.name = COMPUTER_SKILL_ASSG.keys[i]
    self.bhvr = COMPUTER_SKILL_ASSG.values[i]
  end

  def choose
    self.move = Move.new(Move::VALUES.keys.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer, :human_hist, :computer_hist
  def initialize(to_win)
    @human = Human.new
    @computer = Computer.new
    @target_rounds = to_win
    @human_hist = []
    @computer_hist = []
  end
  
  def new_screen(level)
    puts "New #{level} starts in 2..."
    sleep(2)
    system('clear') || system('cls')
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard and Spock!"
    puts ""
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
  
  def modify_score
    winner = select_winner
    case winner
    when 'player'
      human.update_score
    when 'computer'
      computer.update_score
    end
  end
  
  def modify_history(player)
    case player
    when human
      human_hist << human.move
    when computer
      computer_hist << computer.move
    end
  end
  
  # TEST
  def display_history(player)
    puts "#{player.name}'s previous moves are:"
    case player
    when human
      puts human_hist
    when computer
      puts computer_hist
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
  
  def reset_score
    human.reset_score
    computer.reset_score
  end
  
  # MAYBE OPTIONAL??
  def reset_hist
    @human_hist.clear
    @computer_hist.clear
  end

  def game_loop
    loop do
      human.choose
      modify_history(human)
      computer.choose
      modify_history(computer)
      display_moves
      display_winner
      modify_score
      show_score
      break if grand_winner?
      new_screen(:round)
      show_score
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
      # OPTIONAL TEST LINE BELOW
      #display_history(human)
      break unless play_again?
      reset_score
      reset_hist
      new_screen(:game)
    end
    display_goodbye_message
  end
end

RPSGame.new(3).play
