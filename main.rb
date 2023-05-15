class Hangman
  attr_reader :correctWord, :wrongGuesses
  attr_accessor :guess, :turn

  def initialize
    @alreadyGuessed = Array.new()
    @correctWord = self.generateRandomWord
    @guess = Array.new(correctWord.length)
    @turn = 0
    @wrongGuesses = 0
  end

  def generateRandomWord
    words = File.readlines("lib/google-10000-english-no-swears.txt").map(&:chomp)
    return words.select { |word| word.length >= 5 && word.length <= 12 }.sample
  end

  def checkMatchingLetters(a) #could rewrite using enumrables
    i = 0
    wasGuessed = false;
    while i < correctWord.length
      puts correctWord[i]
      puts a
      puts correctWord[i] == a
      if correctWord[i] == a
        guess[i] = a
        wasGuessed = true;
      end
      i += 1
    end
    if wasGuessed == false
      @wrongGuesses += 1
    end
    self.draw_hangman
  end

  def displayGuessed
    self.guess.each do |characher|
      if characher != nil
        print characher
      else print "_"
      end
    end
  end

  def saveToFile()
    serialisedObject = Marshal.dump(self)
    File.open("/lib/savegame.dat", "wb") do |file|
      file.write(serialisedObject)
    end
  end

  def draw_hangman()
    case wrongGuesses
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
i = 0
userInput = ""
while(game.wrongGuesses < 6)
  puts "Enter your guess(a single character) or 'save' to save the game"
  userInput = gets.chomp
  if userInput == "save"
    game.saveToFile
  elsif userInput.match?(/[a-z]/)
    game.checkMatchingLetters(userInput)
  else
    puts "Wrong input"
  end
end
