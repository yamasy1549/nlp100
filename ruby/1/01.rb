str = "パタトクカシーー"

puts str.chars.select.with_index { |char, i| i.even? }.join
