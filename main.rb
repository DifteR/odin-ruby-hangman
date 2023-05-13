class Hangman
  attr_reader :correctWord
  attr_accessor :guess, :turn
  
  def initialize
    @alreadyGuessed = Array.new()
    @correctWord = self.generateRandomWord
    @guess = Array.new(correctWord.length)
    @turn = 0
  end

  def generateRandomWord
    words = File.readlines("lib/google-10000-english-no-swears.txt").map(&:chomp)
    return words.select { |word| word.length >= 5 && word.length <= 12 }.sample
  end

  def checkMatchingLetters(a) #could rewrite using enumrables
    i = 0
    while i < correctWord.length
      if correctWord[i] == a
        guess[i] = a
      else alreadyGuessed << a
      end
      i += 1
    end
  end

  def displayGuessed
    self.guess.each do |characher|
      if characher != nil
        print characher
      else print "_"
      end
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
puts game.correctWord
game.displayGuessed