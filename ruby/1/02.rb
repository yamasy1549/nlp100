str1 = "パトカー"
str2 = "タクシー"

puts [str1, str2].map(&:chars).transpose.join

# Array#map { |item| block } -> Array
# 各要素を順にブロック内で評価し、結果を要素として写像のように返す。
# ブロックに書く処理がひとつのメソッドなら &:method のように略して書ける
# （この説明は語弊があります、[Ruby Symbol & method]とかでググると良さそう）
# [str1, str2].map(&:chars) => [["パ", "ト", "カ", "ー"], ["タ", "ク", "シ", "ー"]]
#
# Array#transpose -> Array
# 配列を行列とみなして転置
# [str1, str2].map(&:chars).transpose => [["パ", "タ"], ["ト", "ク"], ["カ", "シ"], ["ー", "ー"]]
