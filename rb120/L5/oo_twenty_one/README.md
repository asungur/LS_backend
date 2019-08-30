### **Short description of the game:**

```
Twenty-One is a card game consisting of a dealer and a player, where the participants try to get as close to 21 as possible without going over.

Here is an overview of the game:
- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, he loses. If he stays, it's the dealer's turn.
- The dealer must hit until his cards add up to at least 17.
- If he busts, the player wins. If both player and dealer stays, then the highest total wins.
- If both totals are equal, then it's a tie, and nobody wins.
```

### **Nouns and verbs extracted:**
```
Nouns: card, player, dealer, participant, deck, game, calculate_total
Verbs: deal, hit, stay, busts(not an action)
```
### **Example hierarchy:**
```
Player
- hit
- stay
- busted?
- total
Dealer
- hit
- stay
- busted?
- total
- deal (should this be here, or in Deck?)
Participant
Deck
- deal (should this be here, or in Dealer?)
Card
Game
- start
```
Note the number of actions `Player` and `Dealer` share. (Possibly a superclass?)

### **Proposed hierarchy:**
```
Card
- value
- display_name
Deck
- shuffle
- distribute (this can be shared between deck and hand ex: deck sends, hand receives)
Hand (as a module, contains shared behaviour)
- hit
- calculate_hand
- busted?
- reset
Participant (super-class, contains hand, total of cards and score)
Player < Participant
- turn
- display cards
- choose name
Dealer < Participant
- turn
- display cards (not similar to Player.display_cards)
Game
-start
```
Note the number of actions `Player` and `Dealer` share. (Possibly a superclass?)

### **Spike:**
```ruby
module Utilities
  # Prompt, screen clear
end

class Card
 
  SUITS =
  FACES =

  def initialize
  end

  def calculate_value
    
  end
  
  def display_face
    
  end
end

class Deck
  def initialize
    shuffle_deck
  end

  def distribute
    deck.pop
  end

  private

  def shuffle_deck
    # sends two cards
  end
end


module Hand
  def hit(deck)

  end

  def calculate_hand

  end

  def busted?

  end 
  
  def reset
    # resets hand
  end
end

class Participant
  # contains shared states: hand, card_total, score
end

class Player < Participant
  def initialize
    super
    name?
  end

  def display_cards

  end

  def turn(deck)
    loop do
      # has to be intuitive unlike dealer version of turn(deck)
    end
  end


  private

  def name?

  end
  
  def choose_move
    # Hit or stay
  end
end

class Dealer < Participant
  def initialize
    super
  end

  def turn(deck)
    while cards_total < (Maximum score - Treshold)
    # automated version of Player.turn(deck)
  end

  def display_cards
  # One card is face-down always
  end
end

```
### **Orchestration engine:**
```ruby
class Game
  MAX_SCORE = 21
  ROUNDS_TO_WIN = 2
  DEALER_TRESHOLD = 5

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
  end


  def play # play loop
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
  end

  def game_loop
    loop do
      display_score
      deal_cards
      show_initial_cards
      player.turn
      dealer.turn
      update_score
      display_result unless (dealer.busted? || player.busted?)
      display_winner
      break if grand_winner?
      prepare_table
    end
  end

  def display_welcome_message
  end

  def display_goodbye_message
  end

  def deal_cards
    2.times do 
      player.hand << deck.distribute
      dealer.hand << deck.distribute
      player.calculate_hand
      dealer.calculate_hand
    end
  end

  def display_score

  end

  def display_cards
  
  end
  
  def winner

  end

  def display_winner

  end

  def update_score

  end

  def grand_winner
  end

end

game = Game.new.play


```
