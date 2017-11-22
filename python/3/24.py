import re
from functions3 import *

article = gzip2dic()["イギリス"]

mediafiles = re.findall(r"(?:ファイル|File):(.+?)\|", article)
if mediafiles:
    for mediafile in mediafiles: print(mediafile)
