# brings in the nyan cat ascii art
require "./draw_cat.rb"

class GameBoard

# initallize the gameboard with nothing
  def initialize
  end

# prints the game board/cat pictures
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
  end
end
