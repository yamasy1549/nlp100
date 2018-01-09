require './util'

sentence_tokens do |_, token|
  puts token.elements['word'].text if token.elements['NER'].text == 'PERSON'
end
