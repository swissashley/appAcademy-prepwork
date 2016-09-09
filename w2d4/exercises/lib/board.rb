class Board
    attr_accessor :grid
    
    def create_grid
        Array.new(3) {Array.new(3)}
    end
    
    def initialize(grid = create_grid)
        @grid = grid
    end
    
    def place_mark(pos, sym)
        # raise ArgumentError("Not empty!") if !empty?(pos)
        @grid[pos[0]][pos[1]] = sym
    end
    
    def grid
        @grid
    end
    
    def empty?(pos)
        if @grid[pos[0]][pos[1]].nil?
            true
        else
            false
        end
    end
    
    def winner
        
        # check cols
        (dia + cols + @grid).each {|row|
            return :X if row == [:X, :X, :X]
            return :O if row == [:O, :O, :O]
        }
        nil
        
    end
    
    def cols
        col_arr = [[],[],[]]
        @grid.each {|row|
            row.each_with_index {|mark, index|
                col_arr[index] << mark
            }
        }
        col_arr
    end
    
    def dia
        up_dia = [[0,0],[1,1],[2,2]]
        down_dia = [[2,0],[1,1], [0,2]]
        dia_arr = [[],[]]
        up_dia.each {|item|
            dia_arr[0] << @grid[item[0]][item[1]]
        }
        down_dia.each {|item|
            dia_arr[1] << @grid[item[0]][item[1]]
        }
        dia_arr
    end
    
    def over?
        if all_full? || winner != nil
            true
        else
            false
        end
    end
    
    def all_full?
        @grid.flatten.each {|e| return false if e == nil}
        true
    end
end
