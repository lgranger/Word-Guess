# RETIRED: built into master_loop

#require './random_word_gen.rb'
#require './draw_cat.rb'
require './game_loop.rb'
# THIS NEEDS TO BE SET BASED ON THE ACTUAL GAME STATUS
# Game Status should either be first_game, win, or loss
#random_word_gen

game_status = "UNKNOWN"

if game_status == "UNKNOWN" # This is the first game case
  game_grammar = "a"
else
  game_grammar = "another" # This is the case for all subsequent games
end

def new_game_prompt(game_grammar)
  # Gets user input - checks that it is either "Yes" or "No"
  puts "Would you like to play #{game_grammar} game of Word Guess?  "
  answer = gets.chomp.downcase
  answer_valid = false
  while answer_valid != true
    if answer == 'yes' || answer == 'y'
      answer_valid = true
      game_loop
      # NEED TO ADD PLAY GAME CALL HERE
    elsif answer == 'no' || answer == 'n'
      answer_valid = "valid"
      puts "Maybe next time!"
      exit
    else
      puts "Sorry I didn't understand what you said."
      puts "Would you like to play #{game_grammar} game of Word Guess?"
      answer = gets.chomp.downcase
    end
  end
end

new_game_prompt("a")
