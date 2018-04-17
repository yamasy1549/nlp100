require './util'

pyfrom 'scipy', import: %i(sparse io)

n_file_name = '../../output/83.txt'
n = File.read(n_file_name).to_i

dict_t = Marshal.load(File.open('dict_t.dump'))
dict_c = Marshal.load(File.open('dict_c.dump'))
dict_t_keys = dict_t.keys
dict_c_keys = dict_c.keys

x = sparse.lil_matrix.(PyCall::Tuple.([dict_t_keys.size, dict_c_keys.size]))

output_file_name = '../../output/84.txt'
input_file_name = '../../output/83-tc10.txt'

read_write_with_progress(output_file_name, input_file_name) do |output_file, input_file, progressbar|
  input_file.each_line do |line|
    count, t, c = line.chomp.split("\t")
    ppmi = [Math.log(1.0 * (n * count.to_i) / (dict_t[t] * dict_c[c])), 0].max

    if ppmi > 0
      x[dict_t_keys.index(t), dict_c_keys.index(c)] = ppmi
      output_file.puts "#{ppmi}\t#{t}\t#{c}"
    end

    progressbar.increment
  end
end

# 保存
io.savemat('84.mat', PyCall::Dict.({ 'x': x }))
