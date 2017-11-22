from functions3 import *

article = gzip2dic()["イギリス"]

for line in article.splitlines():
    if "Category" in line: print(line)
