require './util'

sentence_tokens do |_, token|
  puts token.word if token.NER == 'PERSON'
end
