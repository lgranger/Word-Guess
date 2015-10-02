def guess
  #asks user for a letter guess
  print "guess a letter: "
  user_input = gets
  if random_word.include?(user_input)
    #change the word_state to the new version with the updated letter
    word_state = random_word.to_a
    word_state.map do |l|
      if l == user_input
        l = user_input
      else
        l = "__"
      end
    end
    return word_state
    @user_input_array.push(user_input)
  else
    #decriment nyan cat -= 1
    if cat_state > 1
      cat_state -= 1
      @user_input_array.push(user_input)
    elsif cat_state == 1
      cat_state -= 1
      @game_status = "loss"
    end
  end
end
