require './util'

# 文ごとの参照表現
sentence_mentions = []

xml_elements.each('root/document/coreference/coreference') do |coreference|
  representative = coreference.elements['mention[@representative="true"]']
  representative_text = representative.text

  coreference.elements.each('mention[not(@representative)]') do |mention|
    sentence = mention.sentence
    start = mention.start
    endd = mention.end - 1
    text = mention.text
    sentence_mentions[sentence] ||= []
    sentence_mentions[sentence] << Mention.new(start, endd, text, representative_text)
  end
end

endds = []
outputs = []

sentence_tokens do |sentence, token|
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
