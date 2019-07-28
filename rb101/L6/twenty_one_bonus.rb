=begin
1. Initialise deck
2. Deal cards to player and dealer
3. Player turn: hit or stay
  -Repeat until bust or stay
  -If both player and dealer stay go to #7
4. If player bust, dealer wins
5. Dealer turn: hit or stay (bot)
6. If dealer bust, player wins. Else go back to #4
7. Compare cards and declare winner
=end

VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
SUITS = ['H', 'D', 'S', 'C']

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
    sum -= 10 if sum > 21
  end
  sum
end
# rubocop:enable Style/ConditionalAssignment

def busted?(cards_total)
  cards_total > 21
end

def detect_result(dlr_total, plyr_total)

  if plyr_total > 21
    :player_busted
  elsif dlr_total > 21
    :dealer_busted
  elsif dlr_total < plyr_total
    :player
  elsif dlr_total > plyr_total
    :dealer
  else
    :tie
  end
end

def display_result(dealer_cards,
  player_cards,
  dlr_total,
  plyr_total,
  plyr_score,
  dlr_score)
  
  result = detect_result(dlr_total, plyr_total)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
    dlr_score += 1
  when :dealer_busted
    prompt "Dealer busted! You win!"
    plyr_score += 1
  when :player
    prompt "You win!"
    plyr_score += 1
  when :dealer
    prompt "Dealer wins!"
    dlr_score += 1
  when :tie
    prompt "It's a tie!"
  end
end

def compare_cards(dlr_cards,
  plyr_cards,
  dlr_total,
  plyr_total,
  plyr_score,
  dlr_score)
  
  puts "=============="
  prompt "Dealer has #{dlr_cards}, for a total of: #{dlr_total}"
  prompt "Player has #{plyr_cards}, for a total of: #{plyr_total}"
  puts "=============="
  
  display_result(dlr_cards,
  plyr_cards,
  dlr_total,
  plyr_total,
  plyr_score,
  dlr_score)
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
      res = true if valid_results[2,3].include?(answer)
      res = false if valid_results[0,1].include?(answer)
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
  winner = "Dealer" if dlr_score
  puts "=============="
  prompt "Round #{rnd} is over!"
  prompt "Player:#{plyr_score} | Dealer:#{dlr_score}"
  puts "#{winner} is the grand winner!" if winner != nil
  puts "=============="
  winner
end

loop do
  round = 1
  player_score = 0
  dealer_score = 0

  loop do
    prompt "Welcome to Twenty-One!" if round == 1
    prompt "Round: #{round}.." if round > 1

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
      player_total,
      player_score,
      dealer_score)
      
      grand_winner?(player_score, dealer_score, round) ? next : break
    else
      prompt "You stayed at #{player_total}"
    end

  # dealer turn
    prompt "Dealer turn..."

  # Dealer hit loop
    loop do
      break if dealer_total >= 17
  
      prompt "Dealer hits!"
      dealer_cards << deck.pop
      dealer_total = total(dealer_cards)
      prompt "Dealer's cards are now: #{dealer_cards}"
    end

  # Dealer busted check
    if busted?(dealer_total)

      compare_cards(dealer_cards,
      player_cards,
      dealer_total,
      player_total,
      player_score,
      dealer_score)
      
      grand_winner?(player_score, dealer_score, round) ? next : break
      
    else
      prompt "Dealer stays at #{dealer_total}"
    end

    compare_cards(dealer_cards,
      player_cards,
      dealer_total,
      player_total,
      player_score,
      dealer_score)

  round += 1
  break unless grand_winner?(player_score, dealer_score, round)
end


  break unless play_again?
end


prompt "Thank you for playing Twenty-One! Good bye!"
