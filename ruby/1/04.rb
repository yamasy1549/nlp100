str = "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."

map = {}

str.split(/\W+/).each.with_index(1) do |word, i|
  abbr = [1, 5, 6, 7, 8, 9, 15, 16, 19].include?(i) ? word[0] : word[0..1]
  map[abbr] = i
end

puts map

# Array#each { |item| ... } -> self
# Array#each -> Enumerator
# 各要素に対してブロックを評価
# 雰囲気はforみたいなもの
#
# Array#include?(val) -> bool
# 配列の中にvalと等しい（==）要素があればtrueを返す
# [1, 5, 6, 7, 8, 9, 15, 16, 19].include?(3) => false
#
# Rubyの範囲表現
# 0..5 => 0から5まで（5を含む）
# 0...5 => 0から5まで（5を含まない）
