class Timer
   attr_accessor :seconds
   def initialize(second = 0)
       @seconds = second
   end

   def padded(second)
      if second < 9
          "0" + second.to_s
      else
          second.to_s
      end
   end
   
   def time_string
      secStr = padded(@seconds % 60)
      @seconds /= 60
      minStr = padded(@seconds % 60)
      @seconds /= 60
      hrStr = padded(@seconds % 60)
      "#{hrStr}:#{minStr}:#{secStr}"
   end
end