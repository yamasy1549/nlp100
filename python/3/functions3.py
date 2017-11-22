import re
import json
import gzip

def gzip2dic(filename="jawiki-country.json.gz"):
    articles = {}
    with gzip.open(filename, "rt") as lines:
        for article in lines:
            json_article = json.loads(article)
            articles[json_article["title"]] = json_article["text"]
    return articles

def extract_raw_template(article):
    template = re.search(r"^\{{2}基礎情報.*?$\n([\s\S]+)^\}{2}$", article, flags=re.MULTILINE)
    return template.group(1)

def raw_template_to_dict(raw_template, function=lambda x:x):
    templates = {}
    content_pattern = re.compile(r"\|(?P<key>.+?)\s*=\s*(?P<val>.+?)(?:(?=\n$)|(?=\n\|))", flags=re.DOTALL+re.MULTILINE)
    contents = content_pattern.finditer(raw_template)
    if contents:
        for content in contents:
            templates[content.group("key")] = function(content.group("val"))
    return templates

def remove_emphasis(text):
    pattern = re.compile(r"(?P<emphasis>'{5}|'{3}|'{2})(?P<content>.*?)(?P=emphasis)")
    return pattern.sub("\g<content>", text)

def remove_fileinfo(text):
    pattern = re.compile(r"(?:ファイル|File):(?P<filename>.+?)\|")
    return pattern.sub("\g<filename>", text)

def remove_innerlink(text):
    pattern = re.compile(r"\[{2}(?:[^|]*?\|?)?(?P<link>[^|]*?)\]{2}")
    return pattern.sub("\g<link>", text)

def remove_link(text):
    pattern = re.compile(r"\[\S+\s(?P<title>[^\[\]]+)\]")
    return pattern.sub(r"\g<title>", text)

def remove_tag(text):
    pattern = re.compile(r"\<(?:[^\<\>])+\>")
    return pattern.sub('', text)

def remove_template(text):
    pattern = re.compile(r"\{{2}(?:.*)\|(?P<lang_text>.*)\}{2}")
    return pattern.sub("\g<lang_text>", text)
