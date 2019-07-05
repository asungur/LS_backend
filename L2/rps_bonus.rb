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

def grand_win?(p_sc, c_sc)
  if p_sc >= WIN_SCORE
    prompt("You are the grand winner!")
  elsif c_sc >= WIN_SCORE
    prompt("Computer is the grand winner!")
  else
    prompt("Next round...")
  end
end

loop do
  loop do
    choice = ''
    key = ''
    loop do
      prompt("Welcome to RPSSL game") if player_score == 0 && comp_score == 0
      welcome(VALID_CHOICES.join(' '))
      key = Kernel.gets().chomp()
      choice = convert_choice(key)
      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice!")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    result(choice, computer_choice)

    player_score += 1 if win?(choice, computer_choice)
    comp_score += 1 if win?(computer_choice, choice)

    prompt("Score: You=#{player_score} | Computer=#{comp_score}")

    grand_win?(player_score, comp_score)

    break if player_score == WIN_SCORE || comp_score == WIN_SCORE
  end

  player_score = 0
  comp_score = 0

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")
