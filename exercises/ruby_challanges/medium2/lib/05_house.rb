class House
  def self.recite
    new.recite
  end

  def recite
    song = ''
    1.upto(12) do |num|
      song << generate_paragraph(num)
      song << "\n" unless num == 12
    end
    song
  end

  private

  def generate_paragraph(iteration)
    paragraph = ''
    iteration.downto(1) do |num|
      if num == iteration
        paragraph << ("This is #{pieces[-iteration][0]}")
      else
        paragraph << (pieces[-num - 1][1] + " " + pieces[-num][0])
      end
      paragraph << "\n" unless num == 1
    end
    paragraph << ".\n"
  end

  def pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end
