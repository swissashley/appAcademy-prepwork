class Temperature
  # TODO: your code goes here!
  #Temperature.new(:f => 50).in_fahrenheit
  #Fahrenheit.new(50).in_celsius
  
  attr_accessor :f, :c
  
  def initialize(options = {})
      if options[:f] != nil
          @f = options[:f] 
          @c = (@f - 32) * 5 / 9.0
      else
          @c = options[:c]
          @f = @c * 9 / 5.0 + 32
      end
  end
  
  def in_fahrenheit
      @f
  end
  
  def in_celsius
      @c
  end
  
  def self.from_fahrenheit(f)
      return Temperature.new({:f => f})
  end
  
  def self.from_celsius(c)
      return Temperature.new({:c => c})
  end
end

class Celsius < Temperature
  def initialize(c)
      @c = c
      @f = @c * 9 / 5.0 + 32
  end
end

class Fahrenheit < Temperature
  def initialize(f)
      @f = f
      @c = (@f - 32) * 5 / 9.0
  end
end
