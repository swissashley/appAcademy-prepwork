class Code
  attr_reader :pegs
  PEGS = {:red => "r",:green => "g",:blue => "b",:yellow => "y",:orange => "o",:purple => "p"}
  
  def initialize(pegs)
    raise ArgumentError.new("No input colors!!") if pegs == nil
    @pegs = pegs
  end
  
  def [](index)
    @pegs[index]
  end
  
  def self.random
    Code.new(PEGS.values.shuffle[0...4])
  end
  
  def self.parse(str)
    if str.split("").all? {|c|PEGS.values.include?(c.downcase)}
      Code.new(str.downcase.split(""))
    else
      raise ArgumentError.new("Invalid color!")
    end
  end
  
  def exact_matches(code2)
    a = 0
    (0...4).each {|i|
      if @pegs[i] == code2.pegs[i]
        a += 1
      end
    }
    a
  end
  
  def near_matches(code2)
    b = 0
    arr1 = []
    arr2 = []
    (0...4).each {|i|
      if @pegs[i] != code2.pegs[i]
        arr1 << @pegs[i]
        arr2 << code2.pegs[i]
      end
    }
    bypass_index = []
    arr1.each {|c|
      (0...arr2.length).each {|i|
        if arr2[i] == c && !bypass_index.include?(i)
          bypass_index << i
          b += 1
          break
        end
      }
    }
    b
  end
  
  def ==(code2)
    return false unless code2.is_a?Code
    self.exact_matches(code2) == 4
  end
  
end

class Game
  attr_reader :secret_code
  
  def initialize(code = Code.random)
    @secret_code = code
  end
  
  def play
    Code.new(Code.random)
    i = 1
    puts "Turn (#{i}) Type in your guess: "
    guess = Code.new(gets.chomp)
    while secret_code.exact_matches(guess) != 4
      display_matches(guess)
      i+=1
      if (i > 10)
        break
      end
      
      puts "Turn (#{i}) Type in your guess: "
      guess = Code.new(gets.chomp)
    end
    
    if i > 10 || secret_code.exact_matches(guess) != 4
      puts "Game Over!! The answer is #{secret_code}"
    elsif secret_code.exact_matches(guess) == 4
      puts "You Win at turn#{i} !!"
    end

  end
  
  def get_guess
    Code.new($stdin.gets.chomp())
  end
  
  def display_matches(code)
    puts "#{@secret_code.exact_matches(code)} exact match(es) and #{@secret_code.near_matches(code)} near match(es)."
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
