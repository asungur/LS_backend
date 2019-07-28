VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
SUITS = ['H', 'D', 'S', 'C']
# Name the game (twenty-one, fourty-one, etc.)
WHATEVER = 21

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
    sum -= 10 if sum > WHATEVER
  end
  sum
end
# rubocop:enable Style/ConditionalAssignment

def busted?(cards_total)
  cards_total > WHATEVER
end

def detect_result(dlr_total, plyr_total)
  if plyr_total > WHATEVER
    :player_busted
  elsif dlr_total > WHATEVER
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

def compare_cards(dlr_cards,
                  plyr_cards,
                  dlr_total,
                  plyr_total)

  puts "=============="
  prompt "Dealer has #{dlr_cards}, for a total of: #{dlr_total}"
  prompt "Player has #{plyr_cards}, for a total of: #{plyr_total}"
  puts "=============="

  display_result(dlr_total, plyr_total)
end

def exit?
  res = nil
  valid_results = %w(n no y yes)
  loop do
    answer = gets.chomp.downcase.to_s
    if !valid_results.include?(answer)
      prompt "Please enter a valid answer"
      next
    else
      res = true if valid_results[2, 3].include?(answer)
      res = false if valid_results[0, 1].include?(answer)
      break
    end
  end
  res
end

def play_again?
  puts "---------------"
  prompt "Do you want to play again? (y or n)"
  exit?
end

def grand_winner?(plyr_score, dlr_score, rnd)
  winner = nil
  winner = "Player" if plyr_score >= 5
  winner = "Dealer" if dlr_score >= 5
  puts "=============="
  prompt "Round #{rnd} is over!"
  prompt "Player:#{plyr_score} | Dealer:#{dlr_score}"
  puts "#{winner} is the grand winner!" if !winner.nil?
  puts "=============="
  winner
end

def welcome(rnd, plyr_score, dlr_score)
  prompt "Welcome to #{WHATEVER}!" if rnd == 0
  if rnd >= 1
    prompt "Press any key to continue"
    gets
    system 'clear'
    prompt "Player: #{plyr_score}, Dealer: #{dlr_score}"
    prompt "Round: #{rnd + 1}.."
  end
end

loop do
  round = 0
  player_score = 0
  dealer_score = 0

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
    prompt "Dealer has #{dealer_cards[0]} and ?"
    prompt "You have #{player_cards[0]} and #{player_cards[1]},
    for a total of #{player_total}"

    # player turn
    loop do
      player_turn = nil
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
        prompt "Your cards are now: #{player_cards}"
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
      break if dealer_total >= WHATEVER - 4

      prompt "Dealer hits!"
      dealer_cards << deck.pop
      dealer_total = total(dealer_cards)
      # prompt "Dealer's cards are now: #{dealer_cards}"
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

    break if grand_winner?(player_score, dealer_score, round)
  end

  break unless play_again?
end

prompt "Thank you for playing Twenty-One! Good bye!"
