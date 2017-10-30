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
