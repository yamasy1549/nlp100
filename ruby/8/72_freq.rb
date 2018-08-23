require './util'
require './train'

# MacOSX backend is not usable through pycall...
pyimport 'matplotlib', as: :mp
mp.rcParams[:backend] = 'TkAgg' if mp.rcParams[:backend] == 'MacOSX'

pyimport 'matplotlib.pyplot', as: 'plt'

_, bows = bag_of_words(at_least: 0)

plt.hist(bows.transpose.map(&:sum), range: PyCall::Tuple.([1,10]), bins: 9)
plt.show()
