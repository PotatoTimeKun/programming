import re
import MeCab
from janome.tokenizer import Tokenizer

deletePattern = [
    re.compile(r'\[.*?\]\(.*?\)'), #名前付きのリンク
    re.compile(r'https?://[^\s]*'), #リンク
    re.compile(r'```.*?```',re.DOTALL), #複数行コード
    re.compile(r'#[^\s]*'), #ハッシュタグ
    re.compile(r'@[a-zA-Z0-9_\.]+'), #メンション
    re.compile(r'`.*?`',re.DOTALL) #コード
]
emojiPattern = re.compile(r':[a-zA-Z0-9_]+?:') #カスタム絵文字
surroundPattern = [
    re.compile(r'(\$\[[a-z\.,=0-9\-]+\s)([^\]]*?)(\])'), #MFM
    re.compile(r'(\()(.*)(\))',re.DOTALL), #()
    re.compile(r'(「)(.*?)(」)',re.DOTALL), #「」
    re.compile(r'(<[a-zA-Z0-9_]+>)(.*?)(</[a-zA-Z0-9_]+>)',re.DOTALL) #<center>などのタグ
]

def editText(text : str|list,emojiDelete = False) -> str|list:
    """
    投稿文から余計な部分を削除する
    """
    if type(text)==list:
        return list(map(lambda x:editText(x),text))
    if text==None or text=="":
        return ""
    for pattern in deletePattern:
        text = pattern.sub(" ",text)
    if emojiDelete:
        text = emojiPattern.sub(" ",text)
    for pattern in surroundPattern:
        searched = pattern.search(text)
        while searched!=None:
            text = text[:searched.span(1)[0]]+text[searched.span(2)[0]:searched.span(2)[1]]+text[searched.span(3)[1]:]
            searched = pattern.search(text)
    return text

def pickEmoji(text : str|list) -> list:
    """
    絵文字を取り出してリストで返す
    """
    if text==None or text=="":
        return ""
    if type(text)==list:
        sum(list(map(pickEmoji,text)),[])
    return emojiPattern.findall(text)

mecab = MeCab.Tagger("-Owakati")
blankPattern = re.compile(r"^\s*$")

def wakachi(text : str,pickLF = False) -> list:
    """
    分かち書きして返す
    絵文字は1つの単語とする
    """
    if text==None or text=="":
        return []
    splitted = []
    buffer = ""
    textList = list(text)
    isEmoji = False
    emojiCharPattern = re.compile(r'[a-zA-Z0-9_]')
    while textList!=[]:
        char = textList.pop(0)
        if char=="\n":
            if buffer!="":
                splitted+=mecab.parse(buffer).split()
            if buffer!="" and pickLF:
                splitted.append("\n")
        elif blankPattern.match(char)!=None:
            continue
        elif isEmoji and emojiCharPattern.match(char)==None:
            isEmoji = False
            buffer+=char
        elif char==":" and not isEmoji:
            if buffer!="":
                splitted+=mecab.parse(buffer).split()
            isEmoji = True
            buffer = char
        elif char==":" and isEmoji:
            isEmoji = False
            splitted.append(buffer+char)
            buffer = ""
        else:
            buffer+=char
    if buffer!="":
        splitted+=mecab.parse(buffer).split()
    return splitted

tokenizer = Tokenizer()

def pickNoun(text: str,exclude = ["非自立","形容動詞語幹","接尾","数"],chain = False) -> list:
    """
    名詞を取り出す
    chainをTrueにすると複合名詞は複合名詞として取り出す
    """
    if text==None or text=="":
        return []
    nouns = []
    beforeIsNoun = False
    signs="!\"#$%&'()=-^~\\|@[];:{}<>?_*+.,/"
    for word in tokenizer.tokenize(text):
        if(word.part_of_speech.split(',')[0]=="名詞" and (word.part_of_speech.split(',')[1] not in exclude) and (word.surface[0] not in signs)):
            if chain and not beforeIsNoun or not chain:
                nouns.append(word.surface)
            else:
                nouns[-1]+=word.surface
            beforeIsNoun = True
        else:
            beforeIsNoun = False
    return nouns

def pickChainNoun(text: str,exclude = ["非自立","形容動詞語幹","接尾","数"]) -> list:
    """
    複合名詞のみを取り出す
    """
    if text==None or text=="":
        return []
    nouns = []
    beforeIsNoun = False
    signs="!\"#$%&'()=-^~\\|@[];:{}<>?_*+.,/"
    for word in tokenizer.tokenize(text):
        if(word.part_of_speech.split(',')[0]=="名詞" and (word.part_of_speech.split(',')[1] not in exclude) and (word.surface[0] not in signs)):
            if not beforeIsNoun:
                if len(nouns)>0 and len(nouns[-1])<=1:
                    del nouns[-1]
                nouns.append([word.surface])
            else:
                nouns[-1].append(word.surface)
            beforeIsNoun = True
        else:
            beforeIsNoun = False
    return nouns

def pickVerb(text: str,exclude = ["非自立"]) -> list:
    """
    動詞を取り出す
    """
    if text==None or text=="":
        return []
    verbs = []
    before = ""
    for word in tokenizer.tokenize(text):
        if(word.part_of_speech.split(',')[0]=="動詞" and (word.part_of_speech.split(",")[1] not in exclude)):
            if word.base_form == "する":
                verbs.append(before+word.base_form)
            else:
                verbs.append(word.base_form)
        before = word.surface
    return verbs

def pickAdj(text: str,allPick = False) -> list:
    """
    形容詞を取り出す
    """
    if text==None or text=="":
        return []
    adjs = []
    for word in tokenizer.tokenize(text):
        if(word.part_of_speech.split(',')[0]=="形容詞" and (allPick or word.part_of_speech.split(',')[1]=="自立")):
            adjs.append(word.base_form)

def reading(text: str) -> str:
    """
    読みをひらがなで返す
    """
    if text==None or text=="":
        return []
    result = ""
    for word in tokenizer.tokenize(text):
        result+=word.reading
    return result