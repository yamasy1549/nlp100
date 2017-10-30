str = "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."

map = {}

str.split(/\W+/).each.with_index(1) do |word, i|
  abbr = [1, 5, 6, 7, 8, 9, 15, 16, 19].include?(i) ? word[0] : word[0..1]
  map[abbr] = i
end

puts map
