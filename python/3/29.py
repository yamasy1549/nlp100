import json
import requests
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

filename = templates["国旗画像"]
wikipedia_api = "http://ja.wikipedia.org/w/api.php?"
params = {
    "action":        "query",
    "titles":        "Image:" + filename,
    "prop":          "imageinfo",
    "iiprop":        "url",
    "format":        "json",
    "formatversion": "2"
}

try:
    res = requests.get(url=wikipedia_api, params=params)
    json_res = json.loads(res.text)
    file_url = json_res['query']['pages'][0]['imageinfo'][0]['url']
    print(file_url)
except requests.exceptions.RequestException as error:
    print(error)
