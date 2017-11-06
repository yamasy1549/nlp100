col1 = "col1.txt"
col2 = "col2.txt"

prefs = File.readlines(col1).map(&:chomp)
cities = File.readlines(col2).map(&:chomp)

output = [prefs, cities].transpose.map { |row| row.join("\t") }

File.open("hightemp13.txt", "w") do |file|
  file.puts output
end

# String#chomp -> String
# 末尾から改行コードを取り除く
