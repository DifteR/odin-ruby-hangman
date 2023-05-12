class Hangman
    attr_reader :correctWord
    attr_accessor :guess
    def initialize
        @correctWord = File.readlines("lib/google-10000-english-no-swears.txt").sample
        @guess = Array.new(correctWord.length)
    end
end

game = Hangman.new()
