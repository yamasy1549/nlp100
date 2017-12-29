class Array
  def in_groups_of(number)
    group_size = size / number
    leftovers = size % number

    groups = []
    start = 0
    number.times do |index|
      length = group_size + (leftovers > 0 && leftovers > index ? 1 : 0)
      groups << slice(start, length)
      start += length
    end

    groups
  end
end

filename = "hightemp.txt"
lines = File.readlines(filename)
l = lines.length

n = ARGV[0].to_i
exit if n == 0

lines.in_groups_of(n).each_with_index do |line, i|
  File.write("hightemp16-#{i}.txt", "w") { |file| file.puts(line) }
end

# ActiveRecord の in_groups_of をそのまま
