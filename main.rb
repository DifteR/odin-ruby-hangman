class Hangman
    attr_reader :correctWord
    attr_accessor :guess
    def initialize
        @correctWord = File.readlines("lib/google-10000-english-no-swears.txt").sample
        @guess = Array.new(correctWord.length)
    end

    def checkMatchingLetters(a)
        i = 0
        while i < correctWord.length
            if correctWord[i] == a
                guess[i] = a
            end
            i += 1
        end
    end
end

game = Hangman.new()
