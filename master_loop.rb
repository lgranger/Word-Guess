require 'pry'
require './game_board_v2.rb'
#require "./game_board.rb"


class Game
  attr_accessor :game_status, :cat_state

  def initialize
    @game_status = false
    @cat_state = 6
  end

  def play
    play_game_prompt
    while @game_status == true
      play_again_prompt
    end
  #   play_game
  end

  def play_game_prompt
    puts "\n\n"
    print "Would you like to play a game of Word Guess?  "
    check_input_to_prompt
  end

  def play_again_prompt
    puts "\n\n"
    print "Would you like to play another game of Word Guess? "
    check_input_to_prompt
  end

  def check_input_to_prompt
    answer = gets.chomp.downcase
    answer_valid = false
    while answer_valid != true
      if answer == 'yes' || answer == 'y'
        answer_valid = true
        guess
      elsif answer == 'no' || answer == 'n'
        answer_valid = "valid"
        puts "Maybe next time!"
        exit
      else
        puts "Sorry I didn't understand what you said."
        print "Would you like to play a game of Word Guess?  "
        answer = gets.chomp.downcase
      end
    end
  end

  def random_word_gen
    random_words = ["kitten", "litter", "catnip", "mouse", "mice", "tuna", "birds", "lynx", "cheetah", "lion", "tiger", "leopard", "feline", "purr", "water", "foxes", "liger", "catcall", "catnap", "catwalk", "copycat", "hellcat", "tabby", "tomcat", "purr", "string", "scratch", "companion", "hairball", "furball", "calico", "frisky", "purring", "siamese", "whiskers", "meows"]
    random_word = random_words[rand(0...random_words.length)]
    return random_word
  end

  def guess
    #asks user for a letter guess

    board = GameBoard.new
    @cat_state = 6
    letters_guessed = []
    guessing = true
    word_state = []
    random_word = random_word_gen
    random_word.length.times do
      word_state.push(" _ ")
    end
    shown_answer = word_state.join(",").tr(",",'')


    while guessing == true
      print %x{clear}
      puts shown_answer
      if letters_guessed == []
        puts "You have not guessed any letters yet"
      else
        print "So far, you have guessed: "
        letters_guessed.each do |i|
          print " #{i} "
        end
        print "\n"
      end
      board.print_board(@cat_state)

      print "Guess a letter: "
      # Need to sanitize this

      user_input_check = gets.chomp

      while user_input_check != "quit"
        if user_input_check.length != 1
          puts "One letter only please!"
          user_input_check = gets.chomp
        elsif user_input_check.to_i.to_s != "0"
          puts "Please guess a letter, numbers aren't letters!"
          user_input_check = gets.chomp
        else
          user_input = user_input_check.downcase
          user_input_check = "quit"
        end
      end

      while letters_guessed.include? user_input
        puts "You already guessed that letter!"
        puts "Guess a different letter"
        user_input = gets.chomp
      end
      letters_guessed.push(user_input)

      if random_word.include?(user_input)
        #change the word_state to the new version with the updated letter
        word_state.length.times do |letter|
          if random_word[letter] == user_input
            word_state[letter] = " " + user_input + " "
          end
        end
      else
        #decriment nyan cat -= 1
        if @cat_state > 1
          @cat_state -= 1

        elsif @cat_state == 1
          @cat_state -= 1
          guessing = false
          @game_status = true
          puts "\n\n"
          puts "You lose! You are the worst!"
          puts "The word was #{random_word}"
          board.print_board(0)
          guessing = "false"
          #@game_status = "loss"
        end
      end
      shown_answer = word_state.join(",").tr(",",'')
      #puts shown_answer
      if shown_answer.tr(" ",'') == random_word

        @game_status = true
        puts "\n\n"
        puts "You won the game!"
        guessing = "false"
        board.print_board("win")
      end
      #puts shown_answer

    end
  end
end


a = Game.new
a.play
#a.guess
