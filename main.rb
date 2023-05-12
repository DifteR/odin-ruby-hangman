class Hangman
  attr_reader :correctWord
  attr_accessor :guess
  
  def initialize
    @correctWord = File.readlines("lib/google-10000-english-no-swears.txt").sample
    @guess = Array.new(correctWord.length)
  end

  def checkMatchingLetters(a) #could rewrite using enumrables
    i = 0
    while i < correctWord.length
      if correctWord[i] == a
        guess[i] = a
      end
      i += 1
    end
  end

  def draw_hangman(guesses)
    case guesses
    when 0
      puts " _________"
      puts "|         |"
      puts "|         "
      puts "|          "
      puts "|           "
      puts "|          "
      puts "|"
    when 1
      puts " _________"
      puts "|         |"
      puts "|         O"
      puts "|          "
      puts "|           "
      puts "|          "
      puts "|"
    when 2
      puts " _________"
      puts "|         |"
      puts "|         O"
      puts "|         |"
      puts "|           "
      puts "|          "
      puts "|"
    when 3
      puts " _________"
      puts "|         |"
      puts "|         O"
      puts "|        /|"
      puts "|           "
      puts "|          "
      puts "|"
    when 4
      puts " _________"
      puts "|         |"
      puts "|         O"
      puts "|        /|\\"
      puts "|           "
      puts "|          "
      puts "|"
    when 5
      puts " _________"
      puts "|         |"
      puts "|         O"
      puts "|        /|\\"
      puts "|        /  "
      puts "|          "
      puts "|"
    else
      puts " _________"
      puts "|         |"
      puts "|         O"
      puts "|        /|\\"
      puts "|        / \\"
      puts "|          "
      puts "|"
    end
  end
end

game = Hangman.new()