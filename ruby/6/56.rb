require './util'
require 'rexml/document'

# 文ごとの参照表現
sentence_mentions = []

filename = '../../output/nlp.txt.xml'
doc = REXML::Document.new(File.new(filename))

doc.elements.each('root/document/coreference/coreference') do |coreference|
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

standard_core_nlp do |sentence, token|
  mentions = sentence_mentions[sentence.id]
               &.select { |mention| mention.start == token.id }
               &.sort_by { |mention| -mention.endd }

  mentions.present? && mentions.each do |mention|
    endds << mention.endd
    print "[#{mention.representative_text}("
  end

  print token.word

  if endds.include?(token.id)
    endds.delete(token.id)
    print ')]'
  end

  print ' '
end
