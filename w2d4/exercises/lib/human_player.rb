class HumanPlayer
    attr_reader :mark
    attr_accessor :name
    
    def initialize(name)
        @name = name
        @mark = :X
    end
    
    def display(board)
        board.grid.each {|row|
            row.each {|col|
            if col.nil?
                print "   | "
            else
                print "#{col.inspect} | "
            end
            }
            puts "\n---------------"
        }
    end
    
    def get_move
        print "Your move(Type in x,y where x=0~2, y=0~2. i.e. 0,0): "
        gets.chomp.split(",").map {|item| item.to_i}
    end
end
