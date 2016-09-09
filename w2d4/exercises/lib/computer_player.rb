class ComputerPlayer
    attr_accessor :board, :name, :mark
    
    def initialize(name)
        @mark = :O
        @name = name
    end
    
    def display(board)
        @board = board
    end
    
    def get_move
        all_moves = []
        (0...3).each {|x|
            (0...3).each {|y|
                all_moves << [x,y] if @board.grid[x][y].nil?
            }
        }
        all_moves.each {|move|
            @board.place_mark(move, :O)
            return move if @board.winner == :O
            @board.grid[move[0]][move[1]] = nil
        }
        all_moves.sample
    end
end
