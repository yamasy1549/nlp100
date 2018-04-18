from util import *
from scipy.cluster.hierarchy import ward, dendrogram
from matplotlib import pyplot as plt

nations = fetch_nations()
vectors = fetch_vectors()

ward = ward(vectors)

dendrogram(ward, labels=list(nations.keys()))
plt.show()
