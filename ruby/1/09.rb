str = "I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind ."

map = str.split(/\s/).map do |word|
  word.size <= 4 ? word : word[0] + word[1...-1].chars.shuffle.join + word[-1]
end

puts map.join(" ")
