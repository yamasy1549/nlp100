sed -nE "s/^する	(.*)/\1/p" ../../output/45.txt | sort | uniq -c | sort -r
sed -nE "s/^見る	(.*)/\1/p" ../../output/45.txt | sort | uniq -c | sort -r
sed -nE "s/^与える	(.*)/\1/p" ../../output/45.txt | sort | uniq -c | sort -r
