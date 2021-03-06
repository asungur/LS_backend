## Version history:

v3_computer_smart_moves.rb - Ammended comments (31.08.19)
    
    1. Undetected winning lines fix
    
    2. Computer behaviour included
    
    3. Adaptive winning lines

v2_bonus_features.rb - Added bonus features (28.08.19)
    
    1. Custom user name
    
    2. Custom user marker
    
       > Please select a marker(A, X, Y, Z, M, Q, @, +, *, $)
        
    3. Round base game, ends if either user or computer wins defined amount of rounds
    
       > Defeat computer 3 times to win
       > USER: 0
       > Computer: 0
    
    4. Custom board size. (Implemented in Board class)
     

v1_improvements.rb - Improved version from the discussion chapter (26.08.19)

v0_assignment.rb - First walkthrough version (25.08.19)


## Steps of thinking:

1. Write a description of the problem and extract major nouns and verbs.
2. Make an initial guess at organizing the verbs into nouns and do a spike to explore the problem with temporary code.
3. Optional - when you have a better idea of the problem, model your thoughts into CRC cards.

## Execution

### **Short description of the game:**

```
Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns
marking a square. The first player to mark 3 squares in a row wins.
```
### **Nouns and verbs extracted:**
```
Nouns: board/grid, player, square
Verbs: play, mark
```
### **Basic hierarchy:**
```
Board
Square
Player
- mark
- play
```
### **Spike:**
```ruby
class Board
  def initialize
    # we need some way to model the 3x3 grid. Maybe "squares"?
    # what data structure should we use?
    # - array/hash of Square objects?
    # - array/hash of strings or integers?
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of this square's mark?
  end
end

class Player
  def initialize
    # maybe a "marker" to keep track of this player's symbol (ie, 'X' or 'O')
  end

  def mark

  end
end
```
### **Orchestration engine:**
```ruby
class TTTGame
  def play

  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
```
### **Expanded orchestration engine:**
```ruby
class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end
```

### **Custom board size:** (implemented in v2)

Assuming board `size(n x n) = 4` (4 x 4 grid)
for `n = 4` (algorithm written in isolation and for explanation only)

1. Winning lines could be appended as follows:

```ruby
winning_lines = []
(1..(n**2)).each do |i|
  if i > n && i < n*(n-1) && i%n != 0 && i%n !=1
    winning_lines << [(i-n-1), i, (i+n+1)]# diagonal \
    winning_lines << [(i-n+1), i, (i+n-1)]# diagonal /
    winning_lines << [(i-n), i, (i+n)]# column |
    winning_lines << [(i-1), i, (i+1)]# row -
  end
end
```
`winning_lines` will return `[[1, 5, 9], [3, 5, 7], [2, 5, 8], [4, 5, 6]]`

2. Board can be drawn as follows:

Constant string elements:

```ruby
EMPTY_ROW_LEFT = ("     ")
EMPTY_ROW_RIGHT = ("|      ")
EMPTY_ROW_MID = ("|     ")
RULE_ROW_LEFT = ("-----")
RULE_ROW_RIGHT = ("|-----")
```

Between the constants squares(cells) with values will be printed. Below code returns index values:

```ruby
(1..n).each do |i|
  puts EMPTY_ROW_LEFT + EMPTY_ROW_MID*(n-2) + EMPTY_ROW_RIGHT
  value_row = ''
  (1..n).each do |t|
    square_number = ((i-1)*n)+t
    if t == 1
      value_row << "  #{square_number}  "
    else t == n
      value_row << "|  #{square_number}  "
    end
  end
  puts value_row
  puts EMPTY_ROW_LEFT + EMPTY_ROW_MID*(n-2) + EMPTY_ROW_RIGHT
  puts RULE_ROW_LEFT + RULE_ROW_RIGHT*(n-2) + RULE_ROW_RIGHT if i != n
end
```
Above code will output:

```
     |     |      
  1  |  2  |  3  
     |     |      
-----|-----|-----
     |     |      
  4  |  5  |  6  
     |     |      
-----|-----|-----
     |     |      
  7  |  8  |  9  
     |     |      
```


