require './util'

sentence_tokens do |_, token|
  puts [
    token.elements['word'].text,
    token.elements['lemma'].text,
    token.elements['POS'].text
  ].join("\t")
end
