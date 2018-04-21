require './util'

sentence_tokens do |_, token|
  puts [
    token.word,
    token.lemma,
    token.POS
  ].join("\t")
end
