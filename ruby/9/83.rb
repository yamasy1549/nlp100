require './util'

# f(t,c) : 共起表現のHash
# dict_tc = Hash.new { |h, k| h[k] = {} }
dict_tc = {}
# f(t,*) : 単語出現回数のHash
dict_t = {}
# f(*,c) : 文脈語出現回数のHash
dict_c = {}

# 読み込みファイルの指定
tc_dump_file, t_dump_file, c_dump_file = ARGV[0..2]

if tc_dump_file && t_dump_file && c_dump_file
  dict_tc = Marshal.load(File.open('dict_tc.dump'))
  dict_t = Marshal.load(File.open('dict_t.dump'))
  dict_c = Marshal.load(File.open('dict_c.dump'))
else
  input_file_name = '../../output/82.txt'
  output_file_name = '../../output/83.txt'

  read_write_with_progress(input_file_name) do |output_file, input_file, progressbar|
    # N : 単語と文脈語のペアの総出現回数
    n = progressbar.total
    output_file.puts(n)

    progressbar.title = 'f(t,c)'

    input_file.each_line do |line|
      # 高速化のためHashを開いてみた
      tc = line.strip
      dict_tc[tc] ||= 0
      dict_tc[tc] += 1

      t, c = tc.split("\t")
      dict_t[t] ||= 0
      dict_t[t] += 1
      dict_c[c] ||= 0
      dict_c[c] += 1

      progressbar.increment
    end
  end

  dict_tc = dict_tc.sort_by_value
  dict_t = dict_t.sort_by_value
  dict_c = dict_c.sort_by_value

  Marshal.dump(dict_tc, File.open('dict_tc.dump', 'w+'))
  Marshal.dump(dict_t, File.open('dict_t.dump', 'w+'))
  Marshal.dump(dict_c, File.open('dict_c.dump', 'w+'))
end

tc_output_file_name = '../../output/83-tc.txt'
tc10_output_file_name = '../../output/83-tc10.txt'
t_output_file_name = '../../output/83-t.txt'
c_output_file_name = '../../output/83-c.txt'

# f(t,c) 書き出し
write_with_progress(tc_output_file_name) do |tc_output_file, progressbar|
  write_with_progress(tc10_output_file_name) do |tc10_output_file, _|
    progressbar.title = 'f(t,c)'
    progressbar.total = dict_tc.size

    dict_tc.each do |words, count|
      tc_output_file.puts "#{count}\t#{words}"
      tc10_output_file.puts "#{count}\t#{words}" if count.to_i >= 10
      progressbar.increment
    end
  end
end

# f(t,*) 書き出し
write_with_progress(t_output_file_name) do |t_output_file, progressbar|
  progressbar.title = 'f(t,*)'
  progressbar.total = dict_t.size

  dict_t.each do |word, count|
    t_output_file.puts "#{count}\t#{word}"
    progressbar.increment
  end
end

# f(*,c) 書き出し
write_with_progress(c_output_file_name) do |c_output_file, progressbar|
  progressbar.title = 'f(*,c)'
  progressbar.total = dict_c.size

  dict_c.each do |word, count|
    c_output_file.puts "#{count}\t#{word}"
    progressbar.increment
  end
end
