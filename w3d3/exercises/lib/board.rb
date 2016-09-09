class Board

attr_accessor :grid

def initialize(grid=Board.default_grid)
    @grid = grid
end

def self.default_grid
    Array.new(10){Array.new(10)}
end

def [](pos)
    @grid[pos[0]][pos[1]]
end

def []=(pos, val)
    @grid[pos[0]][pos[1]] = val
end

def count
    ship_count = 0
    @grid.each{|row|
        row.each{|coordinate|
            ship_count += 1 if !coordinate.nil?
        }
    }
    ship_count
end

def empty?(pos=nil)
    if pos == nil
        @grid.all? {|row|
            row.all? {|coordinate|
                coordinate.nil?
            }
        }
    else
        @grid[pos[0]][pos[1]].nil?
    end
end

def full?
    @grid.all?{|row|
        row.all? {|coordinate|
            !coordinate.nil?
        }
    }
end

def place_random_ship
    raise "The board is full already" if full?
    x = (0...@grid.length).to_a.sample
    y = (0...@grid[0].length).to_a.sample
    if !empty?([x,y])
        place_random_ship
    else
        @grid[x][y] = :s
    end
end

def won?
    @grid.all?{|row|
        row.all? {|coordinate|
            coordinate!=:s
        }
    }
end

def display
    puts "    0   1   2   3   4   5   6   7   8   9 "
    @grid.each_index  {|i|
        print "#{i}  "
        @grid[i].each {|coordinate|
            if coordinate == nil
                print "   |"
            else
                print " #{coordinate} |"
            end
        }
        puts "\n---------------------------------------------"
    }
end

def populate_grid
     5.times{place_random_ship}
end

#   - `Board#display`: prints the board, with marks on any spaces that
#     have been fired upon.
#   - `Board#count`: returns the number of valid targets (ships) remaining
#   - `Board#populate_grid` to randomly distribute ships across the board
#   - `Board#in_range?(pos)`
  
end
