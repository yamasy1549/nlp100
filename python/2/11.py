import re

filename = "../../data/hightemp.txt"

with open(filename) as f:
    src = f.read()
    dest = re.sub(r"\t", " ", src)
    print(dest[:-1])
