require 'gviz'
require './util'

# 1文目
sentence = xml_elements['root/document/sentences/sentence']

Graph do
  sentence.elements.each('dependencies[@type="collapsed-dependencies"]/dep') do |dep|
    unless dep.type == 'punct'
      governor_id = dep.elements['governor'].idx.to_id
      dependent_id = dep.elements['dependent'].idx.to_id
      route governor_id => dependent_id
      node governor_id, label: dep.governor
      node dependent_id, label: dep.dependent
    end
  end

  save('../../output/57', :png)
end
