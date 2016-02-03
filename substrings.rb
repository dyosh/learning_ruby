# Implement a method #substrings that takes a word as the first argument and then
# an array of valid substrings (your dictionary) as the second argument. It should
# return a hash listing each substring (case insensitive) that was found in the
# original string and how many times it was found.

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(word, dictionary)
  results = {}
  dictionary.each do |dict_word|
    current = word.downcase
    dict_word = dict_word.downcase
    while !current.index(dict_word).nil?
      index = current.index(dict_word)
      current = current[index+1..-1]
      results.has_key?(dict_word) ? results[dict_word] += 1 : results[dict_word] = 1
    end
  end
  return results
end

puts substrings("below", dictionary) # => {"below"=>1, "low"=>1}
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
