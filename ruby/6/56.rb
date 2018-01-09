require './util'
require 'rexml/document'

# 文ごとの参照表現
sentence_mentions = []

xml_elements.each('root/document/coreference/coreference') do |coreference|
  representative = coreference.elements['mention[@representative="true"]']
  representative_text = representative.elements['text'].text

  coreference.elements.each('mention[not(@representative)]') do |mention|
    sentence = mention.elements['sentence'].text.to_i
    start = mention.elements['start'].text.to_i
    endd = mention.elements['end'].text.to_i - 1
    text = mention.elements['text'].text
    sentence_mentions[sentence] ||= []
    sentence_mentions[sentence] << Mention.new(start, endd, text, representative_text)
  end
end

endds = []
outputs = []

standard_core_nlp do |sentence, token|
  mentions = sentence_mentions[sentence.id]
               &.select { |mention| mention.start == token.id }
               &.sort_by { |mention| -mention.endd }

  output = ''

  mentions&.each do |mention|
    endds << mention.endd
    output += "[#{mention.representative_text}("
  end

  output += token.word

  endds.count(token.id).times { output += ')]' }
  endds.delete(token.id)

  outputs << output
end

puts outputs.join(' ')
