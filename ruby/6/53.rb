require './util'

sentence_tokens do |_, token|
  puts token.elements['word'].text
end
