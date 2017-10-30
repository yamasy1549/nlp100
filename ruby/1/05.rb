module Util
  def ngram(n)
    self.each_cons(n).map(&:join)
  end
end

class Array
  include Util
end

str = "I am an NLPer"

p str.split(/\W+/).ngram(2)
p str.chars.ngram(2)

# Enumerable#each_cons(n) -> Enumerator
# Enumerable#each_cons(n) { |list| ... } -> nil
# 要素をn個ずつに区切って（重複あり）ブロックに渡して繰り返す
#
# 既存のクラスを再オープンし、メソッドの修正・追加などができる。
# ここではmoduleにngram(n)を定義し、Array classでmoduleを読み込むことでArray#ngram(n)を可能にしている
# もちろん次のように直接書いても動く
#
# class Array
#   def ngram(n)
#     self.each_cons(n).map(&:join)
#   end
# end
