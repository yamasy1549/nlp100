require './util'
require 'pycall/import'
include PyCall::Import

# MacOSX backend is not usable through pycall...
pyimport 'matplotlib', as: :mp
pyimport 'numpy', as: :np
mp.rcParams[:backend] = 'TkAgg' if mp.rcParams[:backend] == 'MacOSX'

pyimport 'matplotlib.mlab', as: 'mlab'
pyimport 'matplotlib.pyplot', as: 'plt'

freqs = word_freqs
words = freqs.map(&:keys).flatten.uniq
bow = [words, Array.new(words.count, 0)].transpose.to_h

freqs.each do |freq|
  bow.merge!(freq) { |_, v0, v1| v0 + v1 }
end

plt.hist(bow.sort_by{ |word, count| [-count, word] }.map{ |_, count| count }, bins: 30)
plt.yscale("log")
plt.show()
