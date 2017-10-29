def ngram(s, n):
    return [s[i:i+n] for i in range(len(s)-1)]

s = "I am an NLPer"
print(ngram(s.split(), 2))
print(ngram(s, 2))
