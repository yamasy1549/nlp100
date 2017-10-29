s = "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."
word_dic = {}

for i, word in enumerate(s.split(), start=1):
    if i in [1, 5, 6, 7, 8, 9, 15, 16, 19]:
        word_dic[word[:1]] = i
    else:
        word_dic[word[:2]] = i

# チェックのためvalueでsortして出力
print(sorted(word_dic.items(), key=lambda x:x[1]))
