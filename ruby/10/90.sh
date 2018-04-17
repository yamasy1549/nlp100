# git clone https://github.com/svn2github/word2vec.git
# cd word2vec
# <malloc.h> -> <stdlib.h>
# make

./word2vec -train output/81.txt -output output/90.txt -size 300 -window 5 -threads 20 -min-count 10

# 先頭行は次元の情報などの文字列なので削除
sed -ie '1,1d' output/90.txt
