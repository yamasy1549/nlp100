filename = "../../data/hightemp.txt"
lines = File.readlines(filename)

n = ARGV[0].to_i
puts lines[0...n]

# String#to_i
# 整数とみなせない文字が出てくるまで、文字列を整数に変換
# "".to_i => 0
