require './util'
require 'rexml/document'

class Mention
  attr_accessor :start, :endd, :text, :representative_text

  def initialize(start, endd, text, representative_text)
    @start = start
    @endd = endd
    @text = text
    @representative_text = representative_text
  end
end

mentions = []

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
    mentions[sentence] ||= []
    mentions[sentence] << Mention.new(start, endd, text, representative_text)
  end
end

endd = 0

standard_core_nlp do |sentence, token|
  sentence_mentions = mentions[sentence.attributes["id"].to_i]
  mention = sentence_mentions&.find { |mention| mention.start == token.attributes["id"].to_i }

  if mention
    endd = mention.endd
    print "[#{mention.representative_text} ("
    print token.elements['word'].text
  elsif token.attributes["id"].to_i == endd
    endd = 0
    print ")]"
  else
    print token.elements['word'].text
  end
  print ' '
end
