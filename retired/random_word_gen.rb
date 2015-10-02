#built into master_loop

def random_word_gen
  random_words = ["kitten", "litter", "catnip", "mouse", "mice", "tuna", "birds"]
  random_word = random_words[rand(0...random_words.length)]
  return random_word
end
