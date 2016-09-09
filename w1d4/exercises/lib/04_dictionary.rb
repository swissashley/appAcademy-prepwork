class Dictionary
  # TODO: your code goes here!
  attr_accessor :d
  
  def initialize
      @d = Hash.new
  end
  
  def entries 
     @d 
  end
  
  def add(arg)
      if arg.is_a?Hash
          arg.each {|k,v| @d[k]=v}
      else
          @d[arg] = nil
      end
  end
  
  def keywords
      @d.keys.sort
  end
  
  def include? (key)
     @d.key?(key) 
  end
  
  def find(key)
     {} if key.downcase.start_with?("nothing")
     (include?(key))?{key=>@d[key]}:{}
     @d.select {|k,v| k.start_with?(key)}
  end
  
  def printable
      #%Q{[apple] "fruit"\n[fish] "aquatic animal"\n[zebra] "African land animal with stripes"}
      @d.map {|k,v| %Q{[#{k}] "#{v}"}}.sort.join("\n")
  end
end
