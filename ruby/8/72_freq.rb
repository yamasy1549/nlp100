require './util'
require './train'

# MacOSX backend is not usable through pycall...
pyimport 'matplotlib', as: :mp
pyimport 'numpy', as: :np
mp.rcParams[:backend] = 'TkAgg' if mp.rcParams[:backend] == 'MacOSX'

pyimport 'matplotlib.mlab', as: 'mlab'
pyimport 'matplotlib.pyplot', as: 'plt'

_, bows = bag_of_words(at_least: 0)

plt.hist(bows.sort_by{ |word, count| [-count, word] }.map{ |_, count| count }, bins: 30)
plt.show()
