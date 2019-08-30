module Utilities
  def prompt(message)
    puts "=> #{ message }"
  end

  def screen_clear
    system('clear') || system('clr')
  end

  def press_to_continue
    prompt("Press any key to continue")
    gets
    screen_clear
  end

  def join(text_arr, connector = 'and')
    output_string = ''
    last_word = text_arr[-1]
    text_arr[0...-1].each do |word|
      output_string << word + ', ' 
    end
    output_string + connector + ' ' + last_word
  end
end

class Card
  attr_reader :value, :display_name
  SUITS = {
    'H' => 'Hearts',
    'S' => 'Spades',
    'C' => 'Clubs',
    'D' => 'Diamonds',
          }
  FACES = %w(2 3 4 5 6 7 8 9 J Q K A)

  def initialize(suit,face)
    @face = face
    @suit = suit
    @value = calculate_value
    @display_name = display_face + ' of ' + display_suit
  end

  def calculate_value
    case face
    when 'J', 'Q', 'K' then 10
    when 'A' then 11
    else @face.to_i
    end
  end
  
  def display_face
    case face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else face.to_s
    end
  end

  private

  attr_reader :face, :suit
  def display_suit
    SUITS[suit]
  end
end

class Deck
  attr_reader :deck

  def initialize
    shuffle_deck
  end

  def distribute
    deck.pop
  end

  private

  def shuffle_deck
    deck = []
    Card::SUITS.keys.each do |suit|
      Card::FACES.each do |face|
        deck << Card.new(suit,face)
      end
    end
    @deck = deck.shuffle
  end
end


module Hand
  def hit(deck)
    new_card = deck.distribute
    hand << deck.distribute
    @cards_total += new_card.value
  end

  def calculate_hand
    total = 0
    hand.each { |card| total += card.calculate_value }
    hand.each do |card|
      total -= 10 if (total > Game::MAX_SCORE && card.display_face == 'Ace')
    end
    @cards_total = total
  end

  def busted?
    cards_total > Game::MAX_SCORE
  end 
  
  def reset
    @hand = []
    @cards_total = 0
  end
end

class Participant
  attr_accessor :hand, :score, :cards_total
  include Hand, Utilities
  def initialize
    @hand = []
    @cards_total = 0
    @score = 0
  end
end

class Player < Participant
  attr_reader :name
  VALID_CHOICES = %w(hit h stay s).freeze

  def initialize
    super
    choose_name
  end

  def display_cards
    prompt("You have #{ join(hand.map { |card| card.display_name }) }")
  end

  def turn(deck)
    loop do
      break unless choose_move
      hit(deck)
      calculate_hand
      screen_clear
      prompt("You hit!")
      puts ""
      sleep(1)
      display_cards
      prompt("Current total: #{ cards_total }")
      break if busted? || cards_total == Game::MAX_SCORE
    end
  end

  def display_busted
    sleep(1)
    prompt("You are BUSTED!")
  end

  private

  def choose_name
    name = ''
    loop do
      prompt("Please enter you name:")
      name = gets.chomp.gsub(/[^a-z]/i, '')
      break unless name.empty?
      prompt("Please enter a valid name")
    end
    screen_clear
    @name = name
  end
  
  def choose_move
    choice = ''
    prompt("Choose hit or stay: (#{ join(VALID_CHOICES, 'or') })")
    loop do
      choice = gets.chomp.to_s.downcase
      break if VALID_CHOICES.include? choice
      prompt("Sorry, invalid choice")
    end
    VALID_CHOICES[0..1].include?(choice)
  end
end

class Dealer < Participant
  include Utilities
  def initialize
    super
  end

  def turn(deck)
    while cards_total < (Game::MAX_SCORE - Game::DEALER_TRESHOLD)
      screen_clear
      prompt("Dealer hits!")
      puts ""
      puts ""
      hit(deck)
      calculate_hand
      display_cards
      sleep(2)
      break if busted?
      press_to_continue
    end
  end

  def display_cards(visible = false)
    card_display = []
    hand.each_with_index do |card, i|
      card_display << if i == 0 && visible == false
                        "A face-down card"
                      else
                        card.display_name
                      end
    end
    prompt("Dealer has #{ join(card_display) }")
  end

  def display_busted
    prompt("Dealer is BUSTED!")
  end
end

class Game
  include Utilities
  MAX_SCORE = 21
  ROUNDS_TO_WIN = 2
  DEALER_TRESHOLD = 5
  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
  end


  def play
    display_welcome_message
    loop do
      game_loop
      display_grand_winner
      break unless play_again?
      restart_game
    end
    display_goodbye_message
  end

  private

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

  def game_loop
    loop do
      display_score
      deal_cards
      show_initial_cards
      player.turn(deck)
      player.display_busted if player.busted?
      unless player.busted? || player.cards_total == MAX_SCORE
        dealer.turn(deck)
        dealer.display_busted if dealer.busted?
      end
      update_score
      display_result unless (dealer.busted? || player.busted?)
      display_winner
      break if grand_winner?
      press_to_continue
      prepare_table
    end
  end

  def display_welcome_message
    prompt("Welcome to #{ MAX_SCORE }, #{player.name}!")
    prompt("Defeat Dealer #{ ROUNDS_TO_WIN } times to win!")
    press_to_continue
  end

  def display_goodbye_message
    prompt("Thanks for playing #{ MAX_SCORE }. Goodbye!")
  end

  def deal_cards
    #Potential message here
    2.times do 
      player.hand << deck.distribute
      dealer.hand << deck.distribute
      player.calculate_hand
      dealer.calculate_hand
    end
  end

  def display_score
    screen_clear
    puts "SCORE:"
    prompt("#{ player.name }: #{ player.score } | Dealer : #{ dealer.score }")
    puts " "
  end

  def show_initial_cards
    dealer.display_cards
    player.display_cards
  end

  def dealer_outscored?
    (player.cards_total < dealer.cards_total) && !dealer.busted?
  end

  def player_outscored?
    (player.cards_total > dealer.cards_total) && !player.busted?
  end

  def winner
    if player.busted? || dealer_outscored?
      'dealer'
    elsif dealer.busted? || player_outscored?
      'player'
    elsif (player.cards_total == dealer.cards_total)
    'tie'
    end
  end

  def display_winner
    case winner
    when 'player' then prompt("#{ player.name } won the round!")
    when 'dealer' then prompt("Dealer won the round!")
    else prompt("No winner this round! It's a tie.")
    end
  end

  def update_score
    case winner
    when 'player' then player.score += 1
    when 'dealer' then dealer.score += 1
    end
  end

  def prepare_table
    @deck = Deck.new
    player.reset
    dealer.reset
  end

  def restart_game
    prepare_table
    player.score = 0
    dealer.score = 0
  end

  def display_result
    screen_clear
    player.display_cards
    prompt("#{ player.name } has total : #{ player.cards_total }")
    puts ""
    sleep(1)
    unless player.cards_total == MAX_SCORE
      dealer.display_cards(true)
      prompt("Dealer has total : #{ dealer.cards_total }")
      puts ""
      sleep(1)
    end
  end

  def grand_winner?
    !!grand_winner
  end

  def grand_winner
    case ROUNDS_TO_WIN
    when player.score then player.name
    when dealer.score then 'Dealer'
    else nil
    end
  end

  def display_grand_winner
    press_to_continue
    prompt("The grand winner is #{ grand_winner }!")
  end
end

game = Game.new.play
