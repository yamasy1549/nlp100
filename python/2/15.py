import sys

filename = "../../data/hightemp.txt"

with open(filename) as f:
    n = int(sys.argv[1])

    for line in f.readlines()[-n:]:
        print(line[:-1])
