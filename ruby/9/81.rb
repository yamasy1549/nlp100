require './util'

nations = File.read("../../data/nations.txt").split("\n")
nation_patterns = Regexp.union(nations)

input_name = '../../output/80.txt'
output_name = '../../output/81.txt'

read_write_with_progress(output_name, input_name) do |output_file, input_file, _|
  input = input_file.read
  output = input.space_to_underscore(nation_patterns)

  output_file.puts(output)
end
