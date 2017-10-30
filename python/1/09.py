import random

def random_shuffle_word(word):
    if len(word) <= 4:
        return word
    else:
        inner = list(word[1:-1])
        random.shuffle(inner)
        return word[0] + ''.join(inner) + word[-1]

def random_shuffle(s):
    return ' '.join(map(random_shuffle_word, s.split()))

s = input()
print(random_shuffle(s))
