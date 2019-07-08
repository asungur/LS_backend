VALID_CHOICES = %w(rock paper scissors spock lizard)
WIN_SCORE = 5
WIN_LOGIC = {
  'rock' => %w(scissors lizard),
  'paper' => %w(rock spock),
  'scissors' => %w(lizard paper),
  'spock' => %w(scissors rock),
  'lizard' => %w(paper spock)
}
SHORTCUT = {
  'rock' => %w(rock r),
  'paper' => %w(paper p),
  'scissors' => %w(scissors sc),
  'spock' => %w(spock sp),
  'lizard' => %w(lizard l)
}

player_score = 0
comp_score = 0

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  WIN_LOGIC[first].include?(second)
end

def convert_choice(shortcut)
  result = ''
  SHORTCUT.each { |key, value| result = key if value.include?(shortcut) }
  result
end

def result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def welcome(choices)
  prompt("Choose one to start: #{choices}")
  prompt(<<-MSG

  Alternatively, you can use the following shortcuts:
  type r for rock
  type p for paper
  type sc for scissors
  type sp for spock
  type l for lizard
  MSG
        )
end

def display_grand_win(p_sc, c_sc)
  if p_sc >= WIN_SCORE
    prompt("You are the grand winner!")
  elsif c_sc >= WIN_SCORE
    prompt("Computer is the grand winner!")
  else
    prompt("Next round...")
  end
end

def get_replay?
  play_again = nil
  loop do
    prompt("Do you want to play again?")
    prompt("Y or Yes to continue; N or No to end")
    answer = Kernel.gets().chomp().to_s.downcase
    if %w(y yes).include?(answer)
      play_again = true
    elsif %w(n no).include?(answer)
      play_again = false
    else
      prompt("Invalid input, please type a valid answer.")
    end
    break if play_again == true || play_again == false
  end
  return play_again
end

def retrieve_move_input(score_pl, score_cmp)
  player_choice = ''
  loop do
    if score_pl == 0 && score_cmp == 0
      prompt("Welcome to RPSSL game")
      prompt("Win #{WIN_SCORE} rounds for the prize")
    end
    welcome(VALID_CHOICES.join(' '))
    key = Kernel.gets().chomp().to_s.downcase
    player_choice = convert_choice(key)
    break if VALID_CHOICES.include?(player_choice)
    prompt("That's not a valid choice")
  end
  return player_choice
end

def match_ended?(player_sc, computer_sc)
  player_sc == WIN_SCORE || computer_sc == WIN_SCORE
end

loop do
  loop do
    choice = ''
    key = ''
    choice = retrieve_move_input(player_score, comp_score)
    system('clear') || system('cls')

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    result(choice, computer_choice)

    player_score += 1 if win?(choice, computer_choice)
    comp_score += 1 if win?(computer_choice, choice)

    prompt("Score: You=#{player_score} | Computer=#{comp_score}")

    display_grand_win(player_score, comp_score)

    break if match_ended?(player_score, comp_score)
  end
  final_result = get_replay?
  if final_result
    prompt("Restarting the game...")
    system('clear') || system('cls')
    player_score = 0
    comp_score = 0
  else
    break
  end
end

system('clear') || system('cls')

prompt("Thank you for playing. Good bye!")
