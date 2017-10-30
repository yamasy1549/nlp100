def cipher(str)
  map = str.chars.map do |c|
    /[[:lower:]]/.match(c) ? (219 - c.ord).chr : c
  end
  map.join
end

str = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
ciphered_str = cipher(str)

puts ciphered_str
puts cipher(ciphered_str)
