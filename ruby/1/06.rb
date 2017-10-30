module Util
  def ngram(n)
    self.each_cons(n).map(&:join)
  end
end

class Array
  include Util
end

str1 = "paraparaparadise"
str2 = "paragraph"

X = str1.chars.ngram(2)
Y = str2.chars.ngram(2)

p X | Y
p X & Y
p X - Y
puts X.include?("se")
puts Y.include?("se")
