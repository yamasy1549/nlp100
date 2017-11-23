from functions3 import *

article = gzip2dic()["イギリス"]
raw_template = extract_raw_template(article)
templates = raw_template_to_dict(raw_template)

for key, val in sorted(templates.items(), key=lambda x:x[0]):
    print(key, val)
