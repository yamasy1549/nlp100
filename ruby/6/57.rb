require 'gviz'
require './util'

filename = '../../output/nlp.txt.xml'
doc = REXML::Document.new(File.new(filename))

# 1文目
sentence = doc.elements['root/document/sentences/sentence']

Graph do
  sentence.elements.each('dependencies[@type="collapsed-dependencies"]/dep') do |dep|
    unless dep.attributes['type'] == 'punct'
      governor_id = dep.elements['governor'].attributes['idx'].to_id
      dependent_id = dep.elements['dependent'].attributes['idx'].to_id
      route governor_id => dependent_id
      node governor_id, label: dep.elements['governor'].text
      node dependent_id, label: dep.elements['dependent'].text
    end
  end

  save('../../output/57', :png)
end
