def ngram(s, n):
    return [s[i:i+n] for i in range(len(s)-1)]

s1 = "paraparaparadise"
s2 = "paragraph"

X = ngram(s1, 2)
Y = ngram(s2, 2)

print(set(X) | set(Y))
print(set(X) & set(Y))
print(set(X) - set(Y))
print('se' in X)
print('se' in Y)
