import sys

filename = "../../data/hightemp.txt"
lines = open(filename).readlines()
l = len(lines)
n = int(sys.argv[1])

for i in range(n):
    chunk = lines[(l+1)*i//n : (l+1)*(i+1)//n]

    with open('../../output/hightemp16-{0}.txt'.format(i), "w") as f:
        f.write(''.join(chunk))
