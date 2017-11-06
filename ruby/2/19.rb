require "csv"

filename = "hightemp.txt"
table = CSV.table(filename, col_sep: "\t", headers: %w(pref city temp day))

puts table[:pref].group_by(&:itself).map { |k, v| { "#{k}": v.count } }
