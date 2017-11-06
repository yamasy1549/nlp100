import sys

filename = "hightemp.txt"

with open(filename) as f:
    lines = f.readlines()
    n = int(sys.argv[1])

    for line in lines[-n:]:
        print(line[:-1])
