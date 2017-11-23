from functions3 import *

def function(text):
    processed_text = remove_emphasis(text)
    return processed_text

article = gzip2dic()["イギリス"]
raw_template = extract_raw_template(article)
templates = raw_template_to_dict(raw_template, function)

for key, val in sorted(templates.items(), key=lambda x:x[0]):
    print(key, val)
