require './util'
require 'pycall/import'
include PyCall::Import

# MacOSX backend is not usable through pycall...
pyimport 'matplotlib', as: :mp
mp.rcParams[:backend] = 'TkAgg' if mp.rcParams[:backend] == 'MacOSX'

pyimport 'matplotlib.mlab', as: 'mlab'
pyimport 'matplotlib.pyplot', as: 'plt'


sorted_freqs = morphologies.word_freq.sort_by{ |word, count| [-count, word] }

x = (0...10).to_a
y = sorted_freqs[0...10].map{ |_, count| count }
labels = sorted_freqs[0...10].map{ |word, _| word }

plt.bar(x, y, tick_label: labels)
plt.show()
