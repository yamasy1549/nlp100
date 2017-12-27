require './util'

standard_core_nlp do |token|
  puts token.elements['word'].text
end
