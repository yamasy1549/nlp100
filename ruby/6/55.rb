require './util'

standard_core_nlp do |_, token|
  puts token.elements['word'].text if token.elements['NER'].text == 'PERSON'
end
