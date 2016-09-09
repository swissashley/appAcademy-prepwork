class HumanPlayer
#     - A `HumanPlayer` class, responsible for translating user input into
#   positions of the form `[x, y]`
    attr_reader :position
    def initialize
        @position = Array.new(2)
    end
    
    def get_play
    p "where to attack?"
        gets.chomp.split(",").map {|item| item.to_i}
    end
end
