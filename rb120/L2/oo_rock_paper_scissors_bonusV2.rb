class Move
  VALUES = { 'rock' => %w(r rock),
             'paper' => %w(p paper),
             'scissors' => %w(s scissors),
             'lizard' => %w(l lizard),
             'spock' => %w(sp spock) }.freeze

  WINNING_MOVES = {
    'rock' => ['lizard', 'scissors'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'lizard' => ['paper', 'spock'],
    'spock' => ['rock', 'scissors']
  }

  def initialize(val)
    @value = val.to_s.downcase
  end

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
  
  def value
    @value
  end
  
  def >(other_move)
    WINNING_MOVES[self.value].include?(other_move.value)
  end

  # rubocop:disable Metrics/PerceivedComplexity , Metrics/CyclomaticComplexity
  # def >(other_move)
  #   (rock? && other_move.lose_to_rock?) ||
  #     (paper? && other_move.lose_to_paper?) ||
  #     (scissors? && other_move.lose_to_scissors?) ||
  #     (lizard? && other_move.lose_to_lizard?) ||
  #     (spock? && other_move.lose_to_spock?)
  # end
  # rubocop:enable Metrics/PerceivedComplexity , Metrics/CyclomaticComplexity

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
      puts "Hello! What's your name?"
      temp = gets.chomp.to_s
      n = temp.gsub(/[^0-9a-z]/i, '')
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
      puts "Please choose (r)ock, (p)aper, (s)cissors, (l)izard or (sp)ock:"
      choice = gets.chomp.downcase.to_s
      break if valid_choice?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(valid_choice(choice))
  end
end

class Computer < Player
  attr_accessor :bhvr
  # Behaviour 1 AKA Counter =>
  #   Finds the most common choice in history
  #   Finds two counterpicks of the most common choice
  #   %66 percent counter picks the most common choice

  # Behaviour 2 AKA Random => Randomly

  # Behaviour 3 AKA Dumb => Rock only

  # Behaviour 4 AKA Old-man  => RPS only

  COMPUTER_SKILL_ASSG = { 'R2D2' => 1, 'Hal' => 1,
                          'Chappie' => 4, 'Sonny' => 2,
                          'Number 5' => 3 }.freeze

  def set_name
    i = rand(1..5)
    self.name = COMPUTER_SKILL_ASSG.keys[i]
    self.bhvr = COMPUTER_SKILL_ASSG.values[i]
  end

  def find_dominant_move(history)
    return Move::VALUES.keys.sample if history == []
    freq = {}
    history.uniq.each do |key|
      freq[key] = history.count(key)
    end
    history.max_by { |v| freq[v] }
  end

  def counter_move(history)
    moves_to_pick = []
    dominant_move = find_dominant_move(history)
    Move::VALUES.keys.each do |k|
      moves_to_pick << k if Move.new(k) > Move.new(dominant_move)
    end
    moves_to_pick << Move::VALUES.keys.sample
  end

  def behaviour_1(history)
    counter_move(history).sample
  end

  def behaviour_2
    Move::VALUES.keys.sample
  end

  def behaviour_3
    :rock
  end

  def behaviour_4
    [:rock, :paper, :scissors].sample
  end

  def choose(history)
    # choose behavior of the computer according the name
    case bhvr
    when 1
      self.move = Move.new(behaviour_1(history))
    when 2
      self.move = Move.new(behaviour_2)
    when 3
      self.move = Move.new(behaviour_3)
    when 4
      self.move = Move.new(behaviour_4)
    end
  end
end

class RPSGame
  attr_reader :human, :computer
  
  def play
    display_welcome_message
    loop do
      game_loop
      display_grand_winner
      # OPTIONAL TEST LINE BELOW
      # display_history(human)
      break unless play_again?
      reset_score
      reset_hist
      new_screen(:game)
    end
    display_goodbye_message
  end

  private
  attr_accessor :human_hist, :computer_hist, :target_rounds
  attr_writer :human, :computer
  
  def initialize(to_win)
    @human = Human.new
    @computer = Computer.new
    @target_rounds = to_win
    @human_hist = []
    @computer_hist = []
  end

  def new_screen(level)
    puts "New #{level} starts in 3..."
    sleep(4)
    system('clear') || system('cls')
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard and Spock!"
    puts "#{human.name} VS. #{computer.name}"
    puts "Win #{target_rounds} rounds for the grand winner title!"
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
    elsif computer.move > human.move
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
      human.name
    elsif computer.score == @target_rounds
      computer.name
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
    answer.downcase == 'y'
  end

  def reset_score
    human.reset_score
    computer.reset_score
  end

  def reset_hist
    @human_hist.clear
    @computer_hist.clear
  end

  def game_loop
    loop do
      human.choose
      modify_history(human)
      computer.choose(human_hist)
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
end

RPSGame.new(2).play
