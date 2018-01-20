export LC_ALL=C
sed -e 's/^/+1 /' ../../data/rt-polaritydata/rt-polarity.pos > ../../data/sentiment.txt
sed -e 's/^/-1 /' ../../data/rt-polaritydata/rt-polarity.neg >> ../../data/sentiment.txt
sort -R ../../data/sentiment.txt -o ../../data/sentiment.txt

grep -c ^+ ../../data/sentiment.txt
grep -c ^- ../../data/sentiment.txt
