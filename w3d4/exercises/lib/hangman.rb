class Hangman
    attr_reader :guesser, :referee, :board
    
    def initialize(players)
        @guesser = players[:guesser]
        @referee = players[:referee]
    end
    
    def setup
        secret_length = @referee.pick_secret_word
        @guesser.register_secret_length(secret_length)
        @board = Array.new(secret_length)
        p "Board length is #{@board.length}"
    end
    
    def take_turn
        @guess = @guesser.guess(@board)
        match_index = @referee.check_guess(@guess)
        p "current board: #{update_board(match_index)}"
        @guesser.handle_response(@guess,match_index)
    end
    
    def play
        setup
        while @board.any? {|el| el.nil?}
            take_turn
        end
    end
    
    def update_board(match_index)
        match_index.each{|index|
            @board[index] = @guess
        }
        @board.map{|c| (c==nil)?"_":c}.join("")
    end
end

class HumanPlayer
    attr_reader :secret_word
    attr_accessor :guess
    
    def initialize
    end
    
    def pick_secret_word
        print "You are a referee! Type in  a secret word: "
        gets.chomp.length
    end
    
    def register_secret_length(length)
        @guess_length = length
        puts "secret length is #{length}"
    end
    
    def guess(board)
        print "(Type in a letter)> "
        @secret_word = gets.chomp.to_s
    end
    
    def check_guess(c)
        print "Player guess: #{c}, what's the match indexes? (Type \"na\" if not match, or indexes start with 1, separated by comma)"
        index = gets.chomp
        if index == "na"
            return []
        else
            index_arr = index.to_s.split(",")
            return index_arr.map {|c| c.to_i-1}
        end
    end
    
    def handle_response(c,index)
        index.each{|i|
            @guess[i] = c
        }
        p "Letter '#{c}' is at position #{index.join(", ")}"
    end

end

class ComputerPlayer
    attr_reader :dictionary ,:secret_word, :candidate_words
    attr_accessor :guess
  
    def initialize(dictionary)
        @dictionary = dictionary
        @candidate_words = []
    end
  
    def self.play_with_dictionary(file_path)
        arr = []
        File.foreach(file_path) {|line|
            arr << line.chomp
        }
        ComputerPlayer.new(arr)
    end
    
    def pick_secret_word
        @secret_word = @dictionary.sample
        @secret_word.length
    end
    
    def register_secret_length(length)
        @guess_length = length
        @guess = Array.new(length)
        @candidate_words = @dictionary.select {|word| 
            word.length == length
        }
        puts "secret length is #{length}"
    end
    
    def guess(board)
        char_hash = Hash.new(0)
        @candidate_words.each {|word| 
            if (word.length == board.length) && compare_word(word, board)
                word.split("").each {|c|
                char_hash[c] += 1 unless board.include?c
                }
            end
        }
        p "CW is #{@candidate_words}"
        guess = char_hash.key(char_hash.values.max)
        g = (guess == nil)?(('a'..'z').to_a.sample):guess
        p "computer is guessing.... #{g}"
        g
    end
    
    def compare_word(word, guess)
        word_chars = []
        word.split("").each_index {|i|
            return false if guess[i] != nil && guess[i] != word[i] 
            return false if guess[i] == nil && word_chars.any? {|c| c == word[i]} && guess.any? {|c| c == word[i]}
            word_chars << word[i]
        }
        true
    end
    
    def remove_word(word, c)
        word.split("").each {|char|
            return false if char == c
        }
        true
    end
    
    def check_guess(c) # return indexes of the match of current guess letter
        arr = []
        @secret_word.split("").each_index {|i|
            arr << i if c == @secret_word[i,1]
        }
        arr 
    end
    
    def handle_response(c,index)
        index.each{|i|
            @guess[i] = c
        }
        if @candidate_words.empty?
            curr_word = @dictionary
        else
            curr_word = @candidate_words
        end
            
        if index.empty?
            @candidate_words = curr_word.select {|word| 
                word.length == @guess_length && remove_word(word, c)
            }
        else
            @candidate_words = curr_word.select {|word| 
                word.length == @guess_length && compare_word(word, @guess)
            }
        end    
    end
      
end

if __FILE__ == $PROGRAM_NAME
    print "Computer guesser(y,n)? "
    if gets.downcase.chomp == "y"
        guesser = ComputerPlayer.play_with_dictionary("lib/dictionary.txt")
    else
        guesser = HumanPlayer.new
    end

    print "Computer referee(y/n)? "
    if gets.downcase.chomp == "y"
        referee = ComputerPlayer.play_with_dictionary("lib/dictionary.txt")
    else
        referee = HumanPlayer.new
    end
    players = {:guesser => guesser, :referee => referee}
    Hangman.new(players).play
end