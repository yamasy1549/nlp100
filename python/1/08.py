def cipher_char(char):
    return chr(219 - ord(char)) if char.islower() else char

def cipher(s):
    return ''.join(map(cipher_char, s))

s = input()

print(cipher(s))
print(cipher(cipher(s)))

# tr A-Za-z N-ZA-Mn-za-m
