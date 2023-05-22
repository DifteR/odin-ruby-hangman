class Hangman
  attr_reader :correctWord, :wrongGuesses
  attr_accessor :guess, :turn

  def initialize
    @alreadyGuessed = Array.new()
    @correctWord = self.generateRandomWord
    @guess = Array.new(correctWord.length)
    @turn = 0
    @wrongGuesses = 0
    @listOfWrongGuesses = Array.new()
  end

  def generateRandomWord
    words = File.readlines("lib/google-10000-english-no-swears.txt").map(&:chomp)
    return words.select { |word| word.length >= 5 && word.length <= 12 }.sample
  end

  def checkMatchingLetters(a) #could rewrite using enumrables
    i = 0
    wasGuessed = false;
    puts correctWord
    while i < correctWord.length
      if correctWord[i] == a
        guess[i] = a
        wasGuessed = true;
      end
      i += 1
    end
    if wasGuessed == false
      @wrongGuesses += 1
    end
    puts guess
    self.draw_hangman
  end

  def displayGuessed
    self.guess.each do |characher|
      if characher != nil
        print characher
      else print "_"
      end
    end
    puts ""
  end

  def saveToFile()
    serialisedObject = Marshal.dump(self)
    File.open("/lib/savegame.dat", "wb") do |file|
      file.write(serialisedObject)
    end
  end

  def self.loadFromFile()
    File.open("lib/savegame.dat", "rb") do |file|
    savedGame = file.read
    return Marshal.load(savedGame)
    end
  end


  def checkWinner()
    return @correctWord == @guess.compact.join
  end

  def userAlreadyGuessed(a)
    if @listOfWrongGuesses.include?(a)
      return true
    else return false
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

i = 0
userInput = ""
puts "Type 'load' to load the previous game or anything else to start a new game"
userInput = gets.chomp
if userInput == "load"
    game = Hangman.loadFromFile()
    game.displayGuessed()
    puts ""
  else
    game = Hangman.new()
end
puts game.correctWord
while(game.wrongGuesses < 6 && !game.checkWinner)
  puts "Enter your guess(a single character) or 'save' to save the game"
  userInput = gets.chomp
  if userInput == "save"
    game.saveToFile
    exit!
  elsif userInput.match?(/[a-z]/)
    if game.userAlreadyGuessed(userInput)
      puts "You already guessed this character"
    else
      game.checkMatchingLetters(userInput)
      game.displayGuessed()
      puts ""
    end
  else
    puts "Wrong input"
  end
end

if game.checkWinner
  puts "You won!"
elsif game.wrongGuesses > 5
  "You lost, try again"
end

