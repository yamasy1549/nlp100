require 'active_record'
require 'rexml/document'

def xml_elements(filename: '../../output/nlp.txt.xml')
  # ./corenlp.sh -annotators tokenize,ssplit,pos,lemma,parse,ner,dcoref, --file ~/Desktop/nlp100/data/nlp.txt

  doc = REXML::Document.new(File.new(filename))
  doc.elements
end

def sentence_tokens
  xml_elements.each('root/document/sentences/sentence') do |sentence|
    sentence.elements.each('tokens/token') do |token|
      block_given? ? yield(sentence, token) : token
    end
  end
end

class REXML::Element
  alias_method :to_text, :text
  remove_method :text

  %w(type idx).each do |attribute_name|
    define_method attribute_name do
      self.attributes[attribute_name]
    end
  end

  %w(id).each do |attribute_name|
    define_method attribute_name do
      self.attributes[attribute_name].to_i
    end
  end

  %w(sentence start end).each do |element_name|
    define_method element_name do
      self.elements[element_name].to_text.to_i
    end
  end

  %w(word lemma POS NER text governor dependent).each do |element_name|
    define_method element_name do
      self.elements[element_name].to_text
    end
  end
end

class Mention
  attr_accessor :start, :endd, :text, :representative_text

  def initialize(start, endd, text, representative_text)
    @start = start
    @endd = endd
    @text = text
    @representative_text = representative_text
  end
end

class Dependant
  attr_accessor :governor, :dependent, :governor_idx, :dependent_idx

  def initialize(governor, dependent, governor_idx, dependent_idx)
    @governor = governor
    @dependent = dependent
    @governor_idx = governor_idx
    @dependent_idx = dependent_idx
  end
end

class Object
  def is_pair?
    self.is_a?(Array) && self.first.is_a?(String) && self.last.is_a?(String)
  end
end
