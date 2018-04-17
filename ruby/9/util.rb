require 'pry'
require 'ruby-progressbar'
require 'active_support'
require 'active_support/core_ext'
require 'pycall/import'

include PyCall::Import

pyimport 'numpy', as: :np

def read_write_with_progress(output_file_name, input_file_name)
  File.open(output_file_name, 'w') do |output_file|
    File.open(input_file_name) do |input_file|
      total = `wc -l #{input_file_name}`.to_i
      progressbar = ProgressBar.create(total: total)

      yield(output_file, input_file, progressbar)

      progressbar.finish
    end
  end
end

def read_with_progress(input_file_name)
  File.open(input_file_name) do |input_file|
    total = `wc -l #{input_file_name}`.to_i
    progressbar = ProgressBar.create(total: total)

    yield(input_file, progressbar)

    progressbar.finish
  end
end

def write_with_progress(output_file_name)
  File.open(output_file_name, 'w') do |output_file|
    total = `wc -l #{output_file_name}`.to_i
    progressbar = ProgressBar.create

    yield(output_file, progressbar)

    progressbar.finish
  end
end

class String
  DELETE_PATTERN = Regexp.union %w(. , ! ? ; : ( ) [ ] ' ")

  def delete_symbols
    self.chomp
      .sub(/^#{DELETE_PATTERN}*/, '')
      .sub(/#{DELETE_PATTERN}*$/, '')
  end

  def space_to_underscore(patterns)
    self.gsub(patterns) do |pattern|
      pattern.gsub("\s", "_")
    end
  end
end

class Hash
  def sort_by_value
    Hash[self.sort_by { |_, value| -value }]
  end
end

module WordVector
  pyfrom 'scipy', import: :io

  dict_t = Marshal.load(File.open('dict_t.dump'))
  @@dict_t_keys = dict_t.keys

  X = io.loadmat('85')['x_svd']

  def vec(word)
    X[@@dict_t_keys.index(word)]
  end

  def cossim(vec_1, vec_2)
    numerator = np.dot(vec_1, vec_2)
    denominator = (np.linalg.norm(vec_1) * np.linalg.norm(vec_2))
    denominator.to_f == 0 ? -1 : (numerator / denominator).to_f
  end
end
