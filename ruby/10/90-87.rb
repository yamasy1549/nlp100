require './util'

include Word2Vec

vec_1 = vec("United_States")
vec_2 = vec("U.S")
puts cossim(vec_1, vec_2)
