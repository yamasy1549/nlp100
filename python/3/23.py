import re
from functions3 import *

article = gzip2dic()["イギリス"]

sections = re.finditer(r"(?P<level>={2,})\s?(?P<name>.*?)\s?(?P=level)", article)
if sections:
    for section in sections:
        print(len(section.group("level"))-1, section.group("name"))
