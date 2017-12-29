require "csv"

filename = "../../data/hightemp.txt"
table = CSV.table(filename, col_sep: "\t", headers: %w(pref city temp day))
prefs = table[:pref].group_by(&:itself).map { |k, v| { "#{k}": v.count } }

prefs.sort_by{ |pref| pref.values }.reverse.each do |hash|
  puts "#{hash.keys.first} #{hash.values.first}"
end
