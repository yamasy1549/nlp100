str = "パタトクカシーー"

puts str.chars.select.with_index { |char, i| i.even? }.join

# String#chars -> Array
# 各文字を要素とした配列を返す
# str.chars => ["パ", "タ", "ト", "ク", "カ", "シ", "ー", "ー"]
#
# Array#select { |item| block } -> Array
# Array#select -> Enumerator
# ブロック内の条件に合うものだけ選んで、それを要素とした配列を返す
#
# Enumerator#with_index(offset) { |(*args), i| ... } -> object
# インデックス付きでブロック{}を繰り返す
# 開始番号offsetのデフォルトは0
# str.chars.select.with_index { |char, i| i.even? } => ["パ", "ト", "カ", "ー"]
#
# Array#join(sep) -> String
# 各要素を先頭から順に文字列sepを挟んだ文字列にして返す
# str.chars.select.with_index { |char, i| i.even? }.join => "パトカー"
