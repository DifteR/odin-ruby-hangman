class Hangman
    def initialize
        attr_reader :correctWord
        correctWord = File.readlines('lib/google-10000-english-no-swears.txt').sample
    end
end

game = Hangman.new()
puts game.correctWord
