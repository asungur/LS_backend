VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
SUITS = ['H', 'D', 'S', 'C']
# Name the game (twenty-one, fourty-one, etc.)
BLACKJACK = 21
VALID_EXIT_ANSWERS = %w(n no y yes)

def prompt(message)
  puts "=> #{message}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

# rubocop:disable Style/ConditionalAssignment
def total(cards)
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |val|
    if val == 'A'
      sum += 11
    elsif val.to_i == 0 # J, Q, K
      sum += 10
    else
      sum += val.to_i
    end
  end

  # correction for Aces

  values.select { |value| value == 'A' }.count.times do
    sum -= 10 if sum > BLACKJACK
  end
  sum
end
# rubocop:enable Style/ConditionalAssignment

def busted?(cards_total)
  cards_total > BLACKJACK
end

def detect_result(dlr_total, plyr_total)
  if plyr_total > BLACKJACK
    :player_busted
  elsif dlr_total > BLACKJACK
    :dealer_busted
  elsif dlr_total < plyr_total
    :player
  elsif dlr_total > plyr_total
    :dealer
  else
    :tie
  end
end

def update_score(dlr_total, plyr_total, dlr_score, plyr_score)
  result = detect_result(dlr_total, plyr_total)

  case result
  when :dealer
    dlr_score += 1
  when :player
    plyr_score += 1
  end
  [dlr_score, plyr_score]
end

def display_result(dlr_total, plyr_total)
  result = detect_result(dlr_total, plyr_total)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def display_cards(cards, single = true)
  display = ''
  if single
    display = cards[1] + cards[0].downcase
  else
    cards.each do |card|
      display += (' ' + card[1] + card[0].downcase)
    end
  end
  display
end

def compare_cards(dlr_cards,
                  plyr_cards,
                  dlr_total,
                  plyr_total)

  puts "=============="
  prompt "Dealer has #{display_cards(dlr_cards, false)}, for a total of: #{dlr_total}"
  prompt "Player has #{display_cards(plyr_cards, false)}, for a total of: #{plyr_total}"
  puts "=============="

  display_result(dlr_total, plyr_total)
end

def retrieve_exit_answer
  answer = ''
  puts "--------------"
  prompt "Do you want to play again? (y or n)"
  loop do
    answer = gets.chomp.downcase.to_s
    break if VALID_EXIT_ANSWERS.include?(answer)
    prompt "Please enter a valid answer"
  end
  answer
end

def play_again?(answer)
  VALID_EXIT_ANSWERS[2, 3].include?(answer)
end

def grand_winner?(plyr_score, dlr_score, rnd)
  winner = nil
  winner = "Player" if plyr_score >= 5
  winner = "Dealer" if dlr_score >= 5
  winner
end

def display_end_round(plyr_score, dlr_score, winner, rnd)
  puts "=============="
  prompt "Round #{rnd} is over!"
  prompt "Player:#{plyr_score} | Dealer:#{dlr_score}"
  puts "#{winner} is the grand winner!" if !winner.nil?
  puts "=============="
end

def welcome(rnd, plyr_score, dlr_score)
  if rnd == 0
    system 'clear'
    prompt "Welcome to #{BLACKJACK}!"
    prompt "Win 5 rounds before the dealer to win the game"
  elsif rnd >= 1
    prompt "New round starts in 5..."
    sleep(5)
    system 'clear'
    prompt "Player: #{plyr_score}, Dealer: #{dlr_score}"
    prompt "Round: #{rnd + 1}.."
  end
end

loop do
  round = 0
  player_score = 0
  dealer_score = 0
  winner = nil
  loop do
    welcome(round, player_score, dealer_score)

    # Initialize variables
    deck = initialize_deck
    player_cards = []
    dealer_cards = []

    # Initial deal
    2.times do
      player_cards << deck.pop
      dealer_cards << deck.pop
    end

    # End of distribution
    player_total = total(player_cards)
    dealer_total = total(dealer_cards)
    prompt "Dealer has #{display_cards(dealer_cards[0])} and ?"
    prompt "You have #{display_cards(player_cards[0])} and #{display_cards(player_cards[1])}, for a total of #{player_total}"

    # player turn
    loop do
      player_turn = nil
      break if player_total == BLACKJACK || dealer_total == BLACKJACK
      loop do
        prompt "Would you like to (h)it or (s)tay?"
        player_turn = gets.chomp.downcase
        break if ['h', 's'].include?(player_turn)
        prompt "Sorry, must enter 'h' or 's'."
      end

      if player_turn == 'h'
        player_cards << deck.pop
        player_total = total(player_cards)
        prompt "You chose to hit!"
        prompt "Your cards are now: #{display_cards(player_cards, false)}"
        prompt "Your total is now: #{player_total}"
      end

      break if player_turn == 's' || busted?(player_total)
    end

    # Player busted check
    if busted?(player_total)

      compare_cards(dealer_cards,
                    player_cards,
                    dealer_total,
                    player_total)

      dealer_score += 1
      round += 1

      grand_winner?(player_score, dealer_score, round) ? break : next
    else
      prompt "You stayed at #{player_total}"
    end

    # dealer turn
    prompt "Dealer turn..."

    # Dealer hit loop
    loop do
      # Dealer stops hitting if it reaches BLACKJACK - 4
      break if dealer_total >= BLACKJACK - 4
      # Break dealer loop if player or dealer already reached BLACKJACK
      break if player_total == BLACKJACK || dealer_total == BLACKJACK

      prompt "Dealer hits!"
      dealer_cards << deck.pop
      dealer_total = total(dealer_cards)
      sleep(1.5)
    end

    # Dealer busted check
    if busted?(dealer_total)

      compare_cards(dealer_cards,
                    player_cards,
                    dealer_total,
                    player_total)

      player_score += 1

      round += 1

      grand_winner?(player_score, dealer_score, round) ? break : next
      sleep(1.5)
    else
      prompt "Dealer stays at #{dealer_total}"
    end

    compare_cards(dealer_cards,
                  player_cards,
                  dealer_total,
                  player_total)

    dealer_score, player_score = update_score(dealer_total,
                                              player_total,
                                              dealer_score,
                                              player_score)

    round += 1
    sleep(1.5)
    winner = grand_winner?(player_score, dealer_score, round)
    break if winner
  end
  display_end_round(player_score, dealer_score, winner, round)
  break unless play_again?(retrieve_exit_answer)
end

prompt "Thank you for playing Twenty-One! Good bye!"
