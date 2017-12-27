require 'pry'
require 'active_record'
require 'rexml/document'

def standard_core_nlp(filename: '../../output/nlp.txt.xml')
  # ./corenlp.sh -annotators tokenize,ssplit,pos,lemma,parse,ner,dcoref, --file ~/Desktop/nlp100/data/nlp.txt

  doc = REXML::Document.new(File.new(filename))

  doc.elements.each('root/document/sentences/sentence') do |sentence|
    sentence.elements.each('tokens/token') do |token|
      block_given? ? yield(sentence, token) : token
    end
  end
end
