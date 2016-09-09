# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.
def guessing_game
    answer = (1..100).to_a.shuffle[0]
    p "guess a number: "
    guess = gets.to_i
    p guess
    i = 1
    while guess != answer
        puts "too high" if guess > answer
        puts "too low" if guess < answer
        i += 1
        
        p "guess a number: "
        guess = gets.to_i
        p guess
    end
    puts "You tried #{i} guesses, and the answer is #{answer}"
end

# ARGV takes in the arguments from the command line.
if __FILE__ == $PROGRAM_NAME
    if ARGV.length != 1
        print "type in a file name: "
        ARGV[0] = gets.chomp
    end
    arr = []
    File.foreach(ARGV[0]) {|line|
        arr << line
    }
    arr.shuffle!
    File.open("#{ARGV[0]}-shuffled.txt", "w") {|f|
        f.puts(arr)
    }
end



