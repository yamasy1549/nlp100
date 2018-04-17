require './util'

input_name = '../../data/enwiki-20150112-400-r100-10576.txt'
output_name = '../../output/80.txt'

read_write_with_progress(output_name, input_name) do |output_file, input_file, progressbar|
  output = input_file.map do |line|
    progressbar.increment
    line.split.map(&:delete_symbols)
  end

  output_file.write(output.flatten.delete_if(&:blank?).join(' '))
end
