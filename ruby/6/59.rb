require './util'

def parse(s_expr)
  read(tokenize(s_expr))
end

def tokenize(s_expr)
  s_expr.gsub(/[()]/, ' \0 ').split
end

def read(tokens)
  token = tokens.shift
  if token == '('
    l = []
    l << read(tokens) until tokens[0] == ')'
    tokens.shift
    l
  else
    token
  end
end

def output_words(expr)
  if expr.is_pair?
    expr.last
  else
    expr[1..-1].map { |e| output_words(e) }.join(' ')
  end
end

def evaluate(expr, pos: 'NP')
  if expr.first == pos
    puts output_words(expr)
  end
  expr[1..-1].each { |e| evaluate(e) } unless expr.is_pair?
end

xml_elements.each('root/document/sentences/sentence/parse') do |parse|
  parse.to_text
    .yield_self { |text| parse(text) }
    .yield_self { |text| evaluate(text) }
end
