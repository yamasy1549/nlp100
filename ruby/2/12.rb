require "csv"

filename = "../../data/hightemp.txt"
table = CSV.table(filename, col_sep: "\t", headers: %w(pref city temp day))

File.open("col1.txt", "w") do |file|
  file.puts table[:pref]
end

File.open("col2.txt", "w") do |file|
  file.puts table[:city]
end

# %w(hoge fuga) => ["hoge", "fuga"]
