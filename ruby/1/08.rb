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

# Regexp#match(str) -> MatchData | nil
# ここではPOSIX文字クラスを使っている
# [:lower:] : 小文字
# [:upper:] : 大文字
# [:alnum:] : 英数字
#
# String#ord -> Integer
# 最初の文字の文字コードを整数で返す
# "A".ord => 65
#
# Integer#chr
# 与えられたIntegerを文字コードと見た時、それに対応する一文字からなる文字列を返す
# 65.chr => "A"
