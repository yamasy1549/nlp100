import pickle
from sklearn.cluster import KMeans

nations = fetch_nations()
vectors = fetch_vectors()

kmeans = KMeans(5)
categories = kmeans.fit_predict(vectors)

for nation, category in zip(nations.keys(), categories):
    print(nation, category)
