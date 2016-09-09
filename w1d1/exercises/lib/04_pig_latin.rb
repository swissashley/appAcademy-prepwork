def translate(s)
    
    arr = s.split
    arr.map {|w|
    if  w.match(/^[aeiou]/)
        w+="ay"
    elsif w.start_with?("qu")
       w[2..-1] + "quay"    
    elsif w.match(/(.+)qu(.*)/)
       i = 0
        while i < w.length-1
          if w[i,2] == 'qu'
              break
          end
          i +=1
        end
        w[i+2..-1] + w[0...i+2] + "ay"
    else
        i = 0
        while i < w.length
          if w[i].match(/[aeiou]/)
              break
          end
          i +=1
        end
        w[i..-1] + w[0...i] + "ay"
    end
    }.join(" ").strip
end
