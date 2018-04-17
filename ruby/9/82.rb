require './util'

input_name = '../../output/81.txt'
output_name = '../../output/82-test.txt'

read_write_with_progress(output_name, input_name) do |output_file, input_file, progressbar|
  input = input_file.read.split
  input_size = input.size
  progressbar.total = input_size

  input.each.with_index do |word, i|
    d = Random.rand(1..5)

    ([*-d..d] - [0]).each do |j|
      next unless 0 <= (i+j) && (i+j) < input_size

      t, c = input[i], input[i+j]
      output = "#{t}\t#{c}"

      output_file.puts(output)
    end

    progressbar.increment
  end
end
