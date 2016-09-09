class Book
  # TODO: your code goes here!
  attr_accessor :title
  def title=(title)
    sw=['a', 'an', 'and', 'as', 'over', 'at', 'but', 'by', 'en', 'for', 'if', 'in', 'of', 'on', 'or', 'the', 'to']
    @title = title.capitalize.split.map {|w| 
        (sw.include?(w))?w:w.capitalize
    }.join(" ")
  end
end
