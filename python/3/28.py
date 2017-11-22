from functions3 import *

def function(text):
    processed_text = remove_emphasis(text)
    processed_text = remove_fileinfo(processed_text)
    processed_text = remove_innerlink(processed_text)
    processed_text = remove_link(processed_text)
    processed_text = remove_tag(processed_text)
    processed_text = remove_template(processed_text)
    return processed_text

article = gzip2dic()["イギリス"]
raw_template = extract_raw_template(article)
templates = raw_template_to_dict(raw_template, function)

for item in sorted(templates.items(), key=lambda x:x[0]):
    print(item)
