str = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."

puts str.split(/\W+/).map(&:count)

# String#split(sep) -> [String]
# sepで分割して文字列の配列を返す。sepには正規表現も書ける
# str.split(/\W+/) => ["Now", "I", "need", "a", "drink", "alcoholic", ...
#
# ここで使った正規表現（Ruby特有のものではない）
# \W : 非単語構成文字、つまり a-z, A-Z, 0-9, _ でないもの
# + : 直前の1文字の1回以上の繰り返し
#
# String#count -> Integer
# 文字列がいくつあるか数える
# length, size も使い方はだいたい一緒
