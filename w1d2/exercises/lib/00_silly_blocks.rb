def reverser(&prc)
    s=prc.call
    s.split.map {|w| w.reverse}.join(" ")
end

def adder(num=1,&prc)
    num2 = prc.call
    num + num2
end

def repeater(n=1, &prc)
    n.times{prc.call}
end