import re

filename = "hightemp.txt"
src = open(filename).read()
dest = re.sub(r"\t", " ", src)

print(dest, end='')
