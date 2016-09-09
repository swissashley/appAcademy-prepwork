def echo(str)
    str
end

def shout(str)
    str.upcase
end

def repeat (str, n = 2)
    Array.new(n,str).join(" ")
end

def start_of_word (s,n)
   s[0,n]
end

def first_word(s)
    s.split[0]
end

def titleize(s)
    sw=[]
    sw=['a', 'an', 'and', 'as', 'over', 'at', 'but', 'by', 'en', 'for', 'if', 'in', 'of', 'on', 'or', 'the', 'to']
    s.capitalize.split(" ").map {|word|
        sw.include?(word)?word:word.capitalize
    }.join(" ")
end
