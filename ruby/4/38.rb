require './util'
require 'pycall/import'
include PyCall::Import

# MacOSX backend is not usable through pycall...
pyimport 'matplotlib', as: :mp
pyimport 'numpy', as: :np
mp.rcParams[:backend] = 'TkAgg' if mp.rcParams[:backend] == 'MacOSX'

pyimport 'matplotlib.mlab', as: 'mlab'
pyimport 'matplotlib.pyplot', as: 'plt'


sorted_freqs = morphologies.word_freq.sort_by{ |word, count| [-count, word] }

counts = sorted_freqs.map{ |_, count| count }
plt.hist(counts, bins: 30)
plt.yscale("log")
plt.show()
