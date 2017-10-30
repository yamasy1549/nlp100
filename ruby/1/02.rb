str1 = "パトカー"
str2 = "タクシー"

puts [str1, str2].map(&:chars).transpose.join
