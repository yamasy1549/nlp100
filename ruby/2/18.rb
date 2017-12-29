require "csv"

filename = "../../data/hightemp.txt"
table = CSV.table(filename, col_sep: "\t", headers: %w(pref city temp day))

sorted = table.sort_by { |row| -row[:temp] }
sorted.each do |row|
  puts row.to_s.gsub(/,/, "\t")
end
