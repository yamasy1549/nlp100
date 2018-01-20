require './util'
require 'test/unit'

class TestMethods < Test::Unit::TestCase
  def test_stopword?
    assert_equal false, "hoge".stopword?
    assert_equal true, "Don't".stopword?
    assert_equal true, "all".stopword?
  end
end
