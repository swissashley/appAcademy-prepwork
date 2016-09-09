def add (a,b)
   a + b 
end

def subtract(a,b)
    a - b
end

def sum(numbers)
    numbers.inject(0) {|sum, num| sum + num}
end

def multiply(*numbers)
    numbers.inject(1) {|p, num| p * num}
end

def power (a,b)
    a ** b
end

def factorial(n)
    return 1 if n == 0
    n * factorial(n - 1)
end