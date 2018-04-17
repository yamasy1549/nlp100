require './util'

include WordVector

long_us_vec = vec('United_States')
short_us_vec = vec('U.S')

puts cossim(long_us_vec, short_us_vec)
