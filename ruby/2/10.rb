filename = "hightemp.txt"

puts File.readlines(filename).count

# IO.readlines(path) -> [String]
# 指定されたファイルを全て読み込んで、その各行を要素としてもつ配列を返す
