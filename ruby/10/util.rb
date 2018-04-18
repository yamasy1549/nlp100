require 'numpy'
require 'pycall/import'

include PyCall::Import

pyimport 'numpy', as: :np

class Hash
  def sort_by_value
    Hash[self.sort_by { |_, value| -value }]
  end
end

module Word2Vec
  model_file_name = 'model.dump'
  @@model = {}

  if File.exist?(model_file_name)
    @@model = Marshal.load(File.open(model_file_name))
  else
    model = {}

    File.open('../../output/90.txt') do |file|
      file.each.with_index do |line|
        word, *vector = line.chomp.split
        model[word] = vector.map(&:to_f)
      end
    end

    Marshal.dump(model, File.open(model_file_name, "w+"))
    @@model = model
  end

  def vec(word)
    np.array(@@model[word])
  end

  def cossim(vec_1, vec_2)
    numerator = np.dot(vec_1, vec_2)
    denominator = (np.linalg.norm(vec_1) * np.linalg.norm(vec_2)).to_f
    denominator == 0 ? -1 : (numerator / denominator).to_f
  end

  def most_similar(base_vec, base_words, count)
    word_sims = {}

    @@model.each do |word, vector|
      next if base_words.include?(word)
      word_vec = vec(word)
      word_sims[word] = cossim(base_vec, word_vec)
    end

    word_sims.sort_by_value.take(count)
  end
end
