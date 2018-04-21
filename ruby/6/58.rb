require './util'

xml_elements.each('root/document/sentences/sentence') do |sentence|
  nsubj_list = []
  dobj_list = []

  sentence.elements.each('dependencies[@type="collapsed-dependencies"]/dep') do |dep|
    type = dep.type

    if type == 'nsubj' || type == 'dobj'
      governor = dep.governor
      dependent = dep.dependent
      governor_idx = dep.elements['governor'].idx.to_i
      dependent_idx = dep.elements['dependent'].idx.to_i
      eval("#{type}_list") << Dependant.new(governor, dependent, governor_idx, dependent_idx)
    end
  end

  governor_idx = nsubj_list.map(&:governor_idx) & dobj_list.map(&:governor_idx)
  governor_idx.each do |idx|
    nsubj = nsubj_list.select { |dep| dep.governor_idx == idx }
    dobj = dobj_list.select { |dep| dep.governor_idx == idx }

    subjects   = nsubj.map(&:dependent).uniq # 主語
    predicates = nsubj.map(&:governor).uniq  # 述語
    objects    = dobj.map(&:dependent).uniq  # 目的語
    puts subjects.product(predicates, objects).map{ |*word| word.join("\t")}
  end
end
