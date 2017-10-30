import sys

filename = "hightemp.txt"
lines = open(filename).readlines()
n = int(sys.argv[1])

for line in lines[-n:]:
    print(line, end='')
