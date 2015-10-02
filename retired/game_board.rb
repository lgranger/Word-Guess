#RETIRED: updated to gaem_board_v2.rb

require "./draw_cat.rb"

class GameBoard

def initialize
end

def print_board
  picture = NyanCat.new
  case
  when picture.cat_state == 6
    print %x{clear}
    picture.cat_six
  when picture.cat_state == 5
    print %x{clear}
    picture.cat_five
  when picture.cat_state == 4
    print %x{clear}
    picture.cat_four
  when picture.cat_state == 3
    print %x{clear}
    picture.cat_three
  when picture.cat_state == 2
    print %x{clear}
    picture.cat_two
  when picture.cat_state == 1
    print %x{clear}
    picture.cat_one
  when picture.cat_state == 0
    print %x{clear}
    picture.cat_dead
  end
end

end
