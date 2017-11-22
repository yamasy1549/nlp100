import re
from functions3 import *

article = gzip2dic()["イギリス"]

categories = re.findall(r"\[{2}Category:(.*?)(?:\|.*)*\]{2}", article)
if categories:
    for category in categories: print(category)
