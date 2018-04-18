from util import *
import pickle
from matplotlib import pyplot as plt
from sklearn.manifold import TSNE
from sklearn.cluster import KMeans

nations = fetch_nations()
vectors = fetch_vectors()

kmeans = KMeans(5)
categories = kmeans.fit_predict(vectors)

t_sne = TSNE().fit_transform(vectors)

fig, ax = plt.subplots()
cmap = plt.get_cmap('Set1')
for index, label in enumerate(nations.keys()):
    cval = cmap(categories[index] / 4)
    ax.scatter(t_sne[index, 0], t_sne[index, 1], marker='.', color=cval)
    ax.annotate(label, xy=(t_sne[index, 0], t_sne[index, 1]), color=cval)
plt.show()
