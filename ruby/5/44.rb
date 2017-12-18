require 'gviz'
require './util'

# "どこで生れたかとんと見当がつかぬ"
sentence = dependencies[3]

Graph do
  sentence.each do |chunk|
    if chunk.depends?
      route chunk.surfaces.to_id => sentence[chunk.dst].surfaces.to_id
      node chunk.surfaces.to_id, label: chunk.surfaces
      node sentence[chunk.dst].surfaces.to_id, label: sentence[chunk.dst].surfaces
    end
  end

  save("../../output/44", :png)
end
