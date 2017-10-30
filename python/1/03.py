import re

s = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."
word_lens = [len(word) for word in re.split(r"\W+", s.strip("."))]

print(word_lens)
