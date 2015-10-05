# Required to create the game board
require './game_board.rb'

class Game
  attr_accessor :game_status, :cat_state

  def initialize
    @game_status = false
    @cat_state = 6
    @user_input_check = ""
    @random_word = ""
    @user_input = ""
    @letters_guessed =[]
    @word_state = []
    @shown_answer = ""
    @guessing = true
  end

  # Play method, initiates the game prompt and prompts the user to play again if they have already played
  def play
    play_game_prompt
    while @game_status == true
      play_again_prompt
    end
  end

  # Play game prompt to user
  # Calls method to check that the input is valid
  def play_game_prompt
    puts "\n\n"
    print "Would you like to play a game of Word Guess?  "
    check_input_to_prompt
  end

  # Play game again prompt to user - same as "play_game_prompt" but changes "a" to "another"
  # Calls method to check that the input is valid
  def play_again_prompt
    @cat_state = 6
    @letters_guessed =[]
    @word_state = []
    @shown_answer = ""
    @guessing = true
    puts "\n\n"
    print "Would you like to play another game of Word Guess? "
    check_input_to_prompt
  end

  # Check user's input to prompt
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
        # If user does not answer yes or no
        puts "Sorry I didn't understand what you said."
        print "Would you like to play a game of Word Guess?  "
        answer = gets.chomp.downcase
      end
    end
  end

  # @random_word_gen generates a random word for the game
  def random_word_gen
    # array of random words, sorted into difficulty levels (all cat related!!!)
    easy_words = ["kitten", "litter", "catnip", "mouse", "mice", "tuna", "birds", "catnap", "whiskers", "meows", "tabby"]
    medium_words = ["lion", "tiger", "leopard", "water", "catcall", "catwalk", "copycat", "hellcat", "tomcat", "string", "scratch", "companion"]
    hard_words = ["lynx", "cheetah", "feline", "purr", "liger", "purr",  "hairball", "furball", "calico", "frisky", "purring", "siamese"]

    # Sets the random word based on the chosen difficuly
      @easy_word = easy_words[rand(0...easy_words.length)]
      @medium_word = medium_words[rand(0...medium_words.length)]
      @hard_word = hard_words[rand(0...hard_words.length)]

  end

  def set_difficulty
    # Prompts the user for difficulty choice and determines random word based on choice
    puts "What difficulty would you like to play?"
    puts "1. Easy"
    puts "2. Medium"
    puts "3. Hard"
    difficulty = gets.chomp.downcase

    random_word_gen

    if difficulty == "1" || difficulty == "easy"
      @random_word = @easy_word
    elsif difficulty == "2" || difficulty == "medium"
      @random_word = @medium_word
    elsif difficulty == "3" || difficulty == "hard"
      @random_word = @hard_word
    else
      puts "That wasn't on the list. Try the medium level."
      # waits 3 seconds before clearing the screen
      sleep(3)
      @random_word = @medium_word
    end

    # @random_word.length.times do
    #   @word_state.push(" _ ")
    # end
  end

  # Sanitizing the user input for letters - only allows a single letter or
  # if the user wants to guess a whole word, they can type "word = GUESS"
  # Guessing an incorrect word will still decrement the number of guesses remaining
  def check_user_input
    while @user_input_check != "quit"
      if @user_input_check.downcase == "word = " + @random_word
        # if the user guesses the word correctly, runs the win game logic
        puts "You won the game!"
        @guessing = "false"
        a = GameBoard.new
        a.print_board("win")
        play_again_prompt
      elsif @user_input_check.to_s.downcase.include? "word ="
        @cat_state -= 1
        print %x{clear}
        puts "Your guess was wrong!"
        puts @shown_answer
        display_letters_guessed
        a = GameBoard.new
        a.print_board(@cat_state)
        puts "If you think you know the whole word, type \"word = GUESS\""
        puts "And replace GUESS with your guess."
        print "Guess a letter: "
        # Checks if they have lost and runs the lose game logic if necessary
        if @cat_state == 0
          puts "\n\n"
          puts "You lose! You are the worst!"
          puts "The word was #{@random_word}"
          a = GameBoard.new
          a.print_board(0)
          @guessing = "false"
          play_again_prompt
        end
        @user_input_check = gets.chomp
      elsif @user_input_check.length != 1
        puts "One letter only please!"
        @user_input_check = gets.chomp
      # Only accepts alphabet characters - not numbers or symbols
      elsif !('a'..'z').to_a.include? @user_input_check.downcase
        puts "Please guess a letter, numbers and symbols won't work!"
        @user_input_check = gets.chomp
      else
        @user_input = @user_input_check.downcase
        @user_input_check = "quit"
      end
    end
  end

  def display_letters_guessed
    if @letters_guessed == []
      puts "You have not guessed any letters yet"
    else
      print "So far you have guessed: "
      @letters_guessed.each do |i|
        print " #{i} "
      end
      print "\n"
    end
  end

  def check_letters_guessed
    while @letters_guessed.include? @user_input
      puts "You already guessed that letter!"
      puts "Guess a different letter"
      @user_input = gets.chomp
    end
    # Adds the guessed letter to the letters_guessed array
    @letters_guessed.push(@user_input)
  end

  def check_guess_correct
    if @random_word.include?(@user_input)
      @word_state.length.times do |letter|
        if @random_word[letter] == @user_input
          @word_state[letter] = " " + @user_input + " "
        end
      end
    else
      # Update cat state if a guess is incorrect
      if @cat_state > 1
        @cat_state -= 1
      # If you run out of guesses return the game lost logic
      elsif @cat_state == 1
        @cat_state -= 1
        @guessing = false
        @game_status = true
        puts "\n\n"
        puts "You lose! You are the worst!"
        puts "The word was #{@random_word}"
        a = GameBoard.new
        a.print_board(0)
        @guessing = "false"
        #@game_status = "loss"
      end
    end
    @shown_answer = @word_state.join(",").tr(",",'')
    #puts shown_answer
    if @shown_answer.tr(" ",'') == @random_word
      @game_status = true
      puts "\n\n"
      puts "You won the game!"
      @guessing = "false"
      a = GameBoard.new
      a.print_board("win")
    end
  end

  def create_display
    @random_word.length.times do
      @word_state.push(" _ ")
    end
    @shown_answer = @word_state.join(",").tr(",",'')
  end


  # This is the main gameplay loop
  def guess
    # Create a new GameBoard
    board = GameBoard.new
    # Calls the set difficulty method and takes the user input for difficulty
    set_difficulty
    # Creates an array of underscores for the number of letters in @random_word
    create_display
    # While the user still needs to make guesses (hasn't won or lost)
    while @guessing == true
      # clears the screen
      print %x{clear}
      # prints the blanks/letters
      puts @shown_answer
      display_letters_guessed
      # prints the board (with Nyan cat depending on # of guesses)
      board.print_board(@cat_state)
      puts "If you think you know the whole word, type \"word = GUESS\""
      puts "And replace GUESS with your guess."
      print "Guess a letter: "
      @user_input_check = gets.chomp
      # Call the check user input method
      check_user_input
      check_letters_guessed
      check_guess_correct
    end

  end

end

# Starts a game when you run master_loop.rb
a = Game.new
a.play
#a.guess
