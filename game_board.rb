require "./draw_cat.rb"

class GameBoard

def initialize
  @word_state = "__ __ T" #@random_word.length
end

def print_board
  puts "GUESS THE CAT WORD!"
  puts "\n#{@word_state}"
  picture = NyanCat.new
  case
  when picture.cat_state == 6
    picture.cat_six
  when picture.cat_state == 5
    picture.cat_five
  when picture.cat_state == 4
    picture.cat_four
  when picture.cat_state == 3
    picture.cat_three
  when picture.cat_state == 2
    picture.cat_two
  when picture.cat_state == 1
    picture.cat_one
  when picture.cat_state == 0
    picture.cat_dead
  end
end

end
