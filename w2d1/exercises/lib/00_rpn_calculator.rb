class RPNCalculator
  # TODO: your code goes here!
  attr_accessor :stack_arr, :value
  def initialize
      @stack_arr = Array.new
  end
  
  def push(n)
      @stack_arr.push(n)
  end
  
  def plus
      compute(:+)
  end
  
  def minus
      compute(:-)
  end
  
  def divide
      compute(:/)
  end
  
  def times
      compute(:*)
  end
  
  def compute(op_syl)
      raise ArgumentError.new("calculator is empty") if @stack_arr.length < 2
      b = @stack_arr.pop
      a = @stack_arr.pop
      case op_syl
      when :+
          @stack_arr.push(a + b)
      when :-
          @stack_arr.push(a - b)
      when :*
          @stack_arr.push(a.to_f * b.to_f)
      when :/
          @stack_arr.push(a.to_f / b.to_f)
      else
          raise ArgumentError.new("No operation #{op_syl}")
      end
      value
  end
  
  def tokens(str)
      newArr  = []
      str.split(" ").each {|c|
          if c.match(/\W/)
              newArr << c.to_sym
          else
              newArr << c.to_i
          end
      }
      newArr
  end
  
  def evaluate(str)
      tokens(str).each {|element|
          if element.to_s.match(/\d/)
              push(element)
          else
              compute(element)
          end
      }
      value
  end
  
  
  def value
    @stack_arr.last
  end
end
