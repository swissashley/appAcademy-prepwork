require_relative 'board'
require_relative 'player'

class BattleshipGame
  attr_reader :board, :player
#   - A `BattleshipGame` class to enforce rules and run the game. The game
#   should keep a reference to the Player, as well as the Board. Some
#   (possibly) useful methods:
#   - `BattleshipGame#play`: runs the game by calling `play_turn` until
#     the game is over.
#   - `BattleshipGame#play_turn`: gets a guess from the player and makes
#     an attack.
#   - `BattleshipGame#attack(pos)`: Marks the board at `pos`, destroying
#     or replacing any ship that might be there.
#   - `BattleshipGame#display_status`: Prints information on the current
#     state of the game, including board state and the number of ships
#     remaining.
    def initialize(player, board)
        @player = player
        @board = board
    end
    
    def play_turn
        attack(@player.get_play)
    end
    
    def attack(pos)
        @board[pos] = :x
        p @board[pos]
    end
    
    def count
        @board.count
    end
    
    def game_over?
        @board.won?
    end
    
    def play
        while !game_over?
            @board.display
            play_turn
        end
        @board.display
        puts "You win!"
    end
    
end

if $PROGRAM_NAME == __FILE__
    player = HumanPlayer.new
    board = Board.new
    board.populate_grid
    game = BattleshipGame.new(player, board)
    game.play
end