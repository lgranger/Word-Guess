#built into master_loop

require './user_input.rb'

def game_loop
  game = true
  while game == true
    guess
    if @game_status == "loss"
      game = false
      puts "Game over. You lose!"
    elsif @game_status == "win"
      game = false
      puts "You win! You are the best at Word Guess"
    end
  end
end
