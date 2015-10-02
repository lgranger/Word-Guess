require "./draw_cat.rb"

class GameBoard

def initialize
  #@word_state = "__ __ T" #@random_word.length
  #@cat_state = 5
end

def print_board(cat_state)
  picture = NyanCat.new
  case cat_state
    when 6
      picture.cat_six
    when 5
      picture.cat_five
    when 4
      picture.cat_four
    when 3
      picture.cat_three
    when 2
      picture.cat_two
    when 1
      picture.cat_one
    when 0
      picture.cat_dead
    when "win"
      picture.cat_win
  end

  #picture.cat_six
  #case @cat_state
  # when 6
  #   picture.cat_six
  # when 5
  #   picture.cat_five
  # when 4
  #   picture.cat_four
  # when 3
  #   picture.cat_three
  # when 2
  #   picture.cat_two
  # when 1
  #   picture.cat_one
  # when 0
  #   picture.cat_dead
  # end
end

end
