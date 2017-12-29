filename = "../../data/hightemp.txt"
lines = File.readlines(filename)

n = [ARGV[0].to_i, lines.length].min
exit if n == 0

puts lines[-n..-1]
