require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
    attr_accessor :player_one, :player_two, :board
    attr_reader :current_player

    def initialize(player_one,player_two)
        @player_one = player_one
        @current_player = player_one
        @player_two = player_two
        @board = Board.new
    end
    
    def current_player
        @current_player
    end
    
    def play
        @current_player.display(@board)
        play_turn
        while @board.winner == nil
            play_turn
        end
        
        puts "#{@board.winner} wins!"
    end
    
    def switch_players!
        if @current_player == player_one
            @current_player = player_two 
        else
            @current_player = player_one
        end
    end
    
    def play_turn
        move = @current_player.get_move
        @board.place_mark(move, @current_player.mark)
        switch_players!
        @current_player.display(@board)
    end
    
    
end

if $PROGRAM_NAME == __FILE__
  human = HumanPlayer.new('human')
  com = ComputerPlayer.new('com')
  game = Game.new(human, com)
  game.play
end
