

def random_word_gen
  random_words = ["kitten", "litter", "catnip", "mouse", "mice", "tuna", "birds"]
  random_word = random_words[rand(0...random_words.length)]
  puts "This is a random word: #{random_word}"
end
