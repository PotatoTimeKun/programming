import textAnalizer
import MisskeyAPI
import random
import json
import time

DEBUG = False

setting = {}

def readSetting():
    """
    AIPCsetting.jsonから設定を読み込む
    """
    global setting
    f = open("AIPCsetting.json","r",encoding="utf-8")
    setting = json.load(f)
    f.close()

def saveSetting():
    """
    AIPCsetting.jsonに設定を書き込む
    """
    f = open("AIPCsetting.json","w",encoding="utf-8")
    json.dump(setting,f,ensure_ascii=False, indent=4, separators=(',', ': '))
    f.close()

import markovify

def makeNote(misskey: MisskeyAPI.MisskeyAPI):
    """
    マルコフ連鎖によってノートを生成する
    """
    try:
        notes = misskey.readLTL(100)
        splitedList = list(map(lambda x:" ".join(textAnalizer.wakachi(textAnalizer.editText(x["text"]),pickLF=True)),notes))
        model = markovify.NewlineText("\n".join(splitedList).replace(" \n ","\n").replace("\n ","\n").replace(" \n","\n"))
        sentence = None
        count = 0
        while sentence==None:
            sentence=model.make_sentence()
            count+=1
            if(count>=100):
                raise Exception("error: 文章生成に失敗")
        if DEBUG:
            print(sentence.replace(" ",""))
        else:
            misskey.post(sentence.replace(" ",""))
    except Exception as e:
        print(e)

from pykakasi import kakasi
converter=kakasi()

def make575(misskey: MisskeyAPI.MisskeyAPI):
    """
    575のノートを生成する
    """
    countChar = [chr(ord("ぁ")+i) for i in range(10)]+[chr(ord("か")+i) for i in range(56)]+[chr(ord("や")+2*i) for i in range(3)]+[chr(ord("ら")+i) for i in range(5)]+['ゎ', 'わ', 'ゐ', 'ゑ', 'を', 'ん', 'ゔ', 'ゕ', 'ゖ']+["－","ー"]
    numberChar = [chr(ord("0")+i) for i in range(10)]
    try:
        notes = misskey.readLTL(100)
        splitedList = list(map(lambda x:textAnalizer.wakachi(textAnalizer.editText(x["text"],emojiDelete=True)),notes))
        five = []
        seven = []
        count = lambda x:len([i for i in list(x) if i in countChar])
        for note in splitedList:
            for i in range(len(note)):
                hiragana = ""
                sentence = ""
                for j in range(i,len(note)):
                    word = note[j]
                    hiragana+="".join(list(map(lambda x:x["hira"],converter.convert(word))))
                    sentence+=word
                    wordLen = count(hiragana)
                    if wordLen>7 or any([(n in word) for n in numberChar]):
                        break
                    elif wordLen==5:
                        five.append(sentence)
                    elif wordLen==7:
                        seven.append(sentence)
        if len(five)==0 or len(seven)==0:
            raise Exception("error: 575生成に必要な分の句を得られない")
        result = f"{random.choice(five)}\n{random.choice(seven)}\n{random.choice(five)}"
        if DEBUG:
            print(result)
        else:
            misskey.post(result)
    except Exception as e:
        print(e)

CLIPNAME = "人気ノート集"

def __clipSearch(misskey : MisskeyAPI.MisskeyAPI):
    clips=misskey.clipList()
    max_num = 0
    remain = 0
    clip_id = ""
    for clip in clips:
        if(not clip["name"].startswith(CLIPNAME)):
            continue
        clip_num = int(clip["name"][len(CLIPNAME):])
        if(clip_num<=max_num):
            continue
        max_num = clip_num
        clip_id = clip["id"]
        remain = 200-clip["notesCount"]
    if(remain>0):
        return (remain,clip_id)
    clip = misskey.makeClip(CLIPNAME+f"{max_num+1}",isPublic=True)
    clip_id = clip["id"]
    remain = 200
    return (remain,clip_id)

def clipMake(misskey : MisskeyAPI.MisskeyAPI):
    """
    人気のあるノートをクリップする
    対象:自身の直近100ノート
    CLIPNAME(グローバル定数):クリップ名、クリップ上限に応じてクリップ名+数値として作成
    clipBorder(AIPCsetting.json):クリップし始めるリアクション数
    調整:先頭に【手動投稿】が付いたノートは無視する
    """
    try:
        remain,clipId = __clipSearch(misskey)
        userId = misskey.info()["id"]
        notes = misskey.readUserNote(userId,100)
        for note in notes:
            if(note["reactionCount"]<setting["clipBorder"]):
                continue
            clipList = misskey.clipOfNote(note["id"])
            if any([(CLIPNAME in clip["name"] and clip["user"]["id"]==userId) for clip in clipList]):
                continue
            if(note["text"].startswith("【手動投稿】")):
                continue
            misskey.clipNote(note["id"],clipId)
            remain-=1
            if remain<=0:
                remain,clipId = __clipSearch(misskey)
    except Exception as e:
        print(e)

from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw
import datetime

def makeUranai(misskey: MisskeyAPI.MisskeyAPI):
    """
    占いを画像で生成し投稿する
    素材やディレクトリの設定はAIPCsetting.json
    """
    try:
        notes = misskey.readLTL(100)
        texts = list(map(lambda x:textAnalizer.editText(x["text"],emojiDelete=True),notes))
        nouns = sum(list(map(lambda x:textAnalizer.pickNoun(x),texts)),[])
        verbs = sum(list(map(lambda x:textAnalizer.pickVerb(x),texts)),[])
        month=["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
        random.shuffle(month)
        advise=[]
        joint=["の","で","に"]
        for i in range(12):
            text="一言:"
            if(random.randint(0,2)==0):
                verb=verbs[random.randint(0,len(verbs)-1)]
                text+=verb
            if(random.randint(0,2)==0):
                text+=nouns[random.randint(0,len(nouns)-1)]+joint[random.randint(0,len(joint)-1)]
            if(random.randint(0,3)==0):
                text+=nouns[random.randint(0,len(nouns)-1)]+joint[random.randint(0,len(joint)-1)]
            if(random.randint(0,3)==0):
                text+=nouns[random.randint(0,len(nouns)-1)]
            verb=verbs[random.randint(0,len(verbs)-1)]
            text+=nouns[random.randint(0,len(nouns)-1)]+"が"+verb
            advise.append(text)
        item=[]
        for i in range(12):
            item.append("ラッキーアイテム\n "+nouns[random.randint(0,len(nouns)-1)])
        img=Image.open(setting["uranaiBase"]).copy()
        fontBig=ImageFont.truetype(setting["uranaiFont"],70)
        fontSmall=ImageFont.truetype(setting["uranaiFont"],30)
        draw=ImageDraw.Draw(img)
        for i in range(12):
            draw.text((300+1000*(i//6),10+1000/6*(i%6)),month[i],"#000000",font=fontBig)
            draw.text((510+1000*(i//6),10+1000/6*(i%6)),item[i],"#000000",font=fontSmall)
            draw.text((100+1000*(i//6),110+1000/6*(i%6)),advise[i],"#000000",font=fontSmall)
        nowTime=datetime.datetime.now()
        filename=f"uranai_{nowTime.year}_{nowTime.month}_{nowTime.day}.png"
        img.save(setting["uranaiSave"]+filename)
        if not DEBUG:
            fileIds = misskey.uploadMedia([setting["uranaiSave"]+filename])
            misskey.post("今日の占いを生成したよ",fileIds=fileIds)
    except Exception as e:
        print(e)

import requests

def weathercast(misskey: MisskeyAPI.MisskeyAPI):
    """
    天気予報を生成
    https://weather.tsukumijima.net/ を使用、情報の取得元は気象庁HP
    安定性が必要なら別の有料APIを使用するように変更した方がいい
    同じように書き換えれば別の県の予報も可能、APIのクールタイム設定は忘れずに
    """
    try:
        url="https://weather.tsukumijima.net/api/forecast/city/"
        tokyo="130010"
        osaka="270000"
        tokyoResponse=requests.get(url+tokyo).json()["forecasts"][0]
        time.sleep(1)
        osakaResponse=requests.get(url+osaka).json()["forecasts"][0]
        u3000="\u3000"
        text="今日の天気:blobcatprofit:\n\n"

        text+=f"$[tada.speed=0s 東京]\n"
        text+=f"天気:{tokyoResponse['telop']}\n"
        text+=f"最高気温:{tokyoResponse['temperature']['max']['celsius']}℃\n"
        text+=f"降水確率:{tokyoResponse['chanceOfRain']['T06_12']}(午前),{tokyoResponse['chanceOfRain']['T12_18']}(午後)\n"
        text+=f"詳細:{tokyoResponse['detail']['weather'].replace(u3000,'')}\n\n"

        text+=f"$[tada.speed=0s 大阪]\n"
        text+=f"天気:{osakaResponse['telop']}\n"
        text+=f"最高気温:{osakaResponse['temperature']['max']['celsius']}℃\n"
        text+=f"降水確率:{osakaResponse['chanceOfRain']['T06_12']}(午前),{osakaResponse['chanceOfRain']['T12_18']}(午後)\n"
        text+=f"詳細:{osakaResponse['detail']['weather'].replace(u3000,'')}"
        if DEBUG:
            print(text)
        else:
            misskey.post(text)
    except Exception as e:
        print(e)

import google.generativeai as genai

def makeTaigigo(misskey: MisskeyAPI.MisskeyAPI):
    """
    対義語を生成する
    使うにはAIPCsetting.jsonにGeminiのAPIキーを設定する必要
    """
    try:
        notes = misskey.readLTL(80)
        texts = list(map(lambda x:textAnalizer.editText(x["text"],emojiDelete=True),notes))
        nouns = [i for i in sum(list(map(lambda x:textAnalizer.pickChainNoun(x),texts)),[]) if len(i)<=5]
        if(len(nouns)==0):
            return
        origin=random.choice(nouns)
        inverse=""
        genai.configure(api_key=setting["geminiAPIToken"])
        gemini = genai.GenerativeModel("gemini-pro")
        for word in origin:
            prompt = f"{word}の対義語は何ですか"
            response = gemini.generate_content(prompt)
            inverse+=response.text
            time.sleep(10)
        if DEBUG:
            print(f"{''.join(origin)}\n↕\n{inverse}")
        else:
            misskey.post(f"{''.join(origin)}\n↕\n{inverse}")
    except Exception as e:
        print(e)

def _reactionSetting(misskey : MisskeyAPI.MisskeyAPI):
    """
    リアクションの有効・無効設定を更新
    """
    notes = misskey.readMention(limit=setting["mentionReadCount"])
    notes.reverse()
    for note in notes:
        if note["text"]==None or note["text"]=="":
            continue
        elif "センシティブリアクション有効" in note["text"]:
            if note["user"]["id"] not in setting["reactionUser"]:
                setting["reactionUser"].append(note["user"]["id"])
            if note["user"]["id"] not in setting["sensitiveReactionUser"]:
                setting["sensitiveReactionUser"].append(note["user"]["id"])
        elif "センシティブリアクション無効" in note["text"] and note["user"]["id"] in setting["sensitiveReactionUser"]:
            setting["sensitiveReactionUser"].remove(note["user"]["id"])
        elif "リアクション有効" in note["text"] and note["user"]["id"] not in setting["reactionUser"]:
            setting["reactionUser"].append(note["user"]["id"])
        elif "リアクション無効" in note["text"] and note["user"]["id"] in setting["reactionUser"]:
            setting["reactionUser"].remove(note["user"]["id"])
            if note["user"]["id"] in setting["sensitiveReactionUser"]:
                setting["sensitiveReactionUser"].remove(note["user"]["id"])
    saveSetting()

def sendReaction(misskey : MisskeyAPI.MisskeyAPI):
    """
    許可されたユーザにリアクションを送る
    """
    try:
        _reactionSetting(misskey)
        emojis = misskey.readEmojis()
        for user in setting["reactionUser"]:
            notes = misskey.readUserNote(user,limit=setting["reaction_notePerUser"],withRenotes=False)
            time.sleep(0.1)
            if len(notes)==0:
                continue
            choosenNotes = [notes.pop(random.randint(0,len(notes)-1)) for i in range(setting["reactionPerUser"])]
            for note in choosenNotes:
                if note["visibility"]!="public" and note["visibility"]!="home": #鍵投稿は無視
                    continue
                if 'myReaction' in note.keys() and note['myReaction']!=None: #リアクション済みの投稿は無視
                    continue
                noteEmoji = textAnalizer.pickEmoji(note["text"])
                text = textAnalizer.editText(note["text"],emojiDelete=True)
                words = textAnalizer.pickNoun(text) + textAnalizer.pickVerb(text)
                words += list(map(lambda x:textAnalizer.reading(x),words))
                reactionChoice = [random.choice(emojis)] #選択肢、ランダムに1個入れておく
                for reaction in noteEmoji: #ノート中のリアクションの情報を探して追加
                    for emoji in emojis:
                        if reaction[1:len(reaction)-1]==emoji["name"]:
                            reactionChoice.append(emoji)
                            break
                for emoji in emojis: #エイリアスと内容を比べてリアクション追加
                    for alias in emoji["aliases"]:
                        if alias=="":
                            continue
                        if alias in text:
                            reactionChoice.append(emoji)
                            break
                        if any([(alias in word or word in alias)for word in words]):
                            reactionChoice.append(emoji)
                            break
                for reaction in reactionChoice.copy(): #排除する必要のあるリアクションを消す
                    if reaction["category"] in setting["reaction_ignoreCategory"]:
                        reactionChoice.remove(reaction)
                        continue
                    if reaction["name"] in setting["ignoreReaction"]:
                        reactionChoice.remove(reaction)
                        continue
                    if ("isSensitive" in reaction.keys() and reaction["isSensitive"] or reaction["name"] in setting["sensitiveReaction"]) and user not in setting["sensitiveReactionUser"]:
                        reactionChoice.remove(reaction)
                        continue
                if len(reactionChoice)==0:
                    continue
                choosenReaction = ":"+random.choice(reactionChoice)["name"]+":"
                try:
                    misskey.makeReaction(note["id"],choosenReaction)
                    time.sleep(1)
                except:
                    pass
    except Exception as e:
        print(e)

from PIL import Image
import numpy as np
from wordcloud import WordCloud

_wordcloud_stopWords = [ #ワードクラウドのストップワード、追加した単語はワードクラウド上には現れない(完全一致のみ、それを含む複合語などは現れる)
    "あそこ", "あたり", "あちら", "あっち", "あと", "あな", "あれ", 
    "いくつ", "いつ", "いま", "いや", "いろいろ", "うち", "おおまか",
     "がい", "かく", "かたち", "かやの", "から", "がら", "きた", "くせ", 
    "ここ", "こっち", "こと", "ごと", "これ", "これら", "ごろ", "さまざま", 
    "さらい", "さん", "しかた", "しよう", "すべて", "その", "それ", "それぞれ", 
    "それなり", "たくさん", "たち", "ため", "だめ", "ちゃ", "ちゃん", "てん", 
    "とおり", "とき", "どこ", "どちら", "どっか", "どっち", "どれ", "なか", 
    "なかば", "なに", "など", "なん", "はじめ", "はず", "はるか", "ひと", 
    "ひとつ", "ふく", "ぶり", "べつ", "へん", "ぺん", "ほう", "ほか", "まさ", 
    "まし", "まとも", "まま", "みたい", "みつ", "みなさん", "もと", "もの", 
    "もん", "やつ", "よう", "よそ", "わけ", "ハイ", "上", "中", "下", 
    "字", "年", "月", "日", "時", "分", "秒", "週", "火", "水", "木", "金", "土", 
    "国", "都", "道", "府", "県", "市", "区", "町", "村", "各", "第", "方", "何", 
    "的", "度", "文", "者", "性", "体", "人", "他", "今", "部", "課", "係", "外", 
    "類", "達", "気", "室", "口", "誰", "用", "界", "会", "首", "男", "女", "別", 
    "話", "私", "屋", "店", "家", "場", "方", "見", "際", "観", "段", "略", "例", 
    "系", "論", "形", "間", "地", "員", "線", "点", "書", "品", "力", "感", "作", 
    "元", "手", "数", "彼", "彼女", "子", "内", "楽", "喜", "怒", "哀", "輪", "頃", 
    "化", "境", "俺", "奴", "高", "校", "婦", "伸", "紀", "誌", "レ", "行", "列", 
    "事", "士", "台", "集", "様", "所", "歴", "器", "名", "情", "連", "毎", "式", 
    "簿", "回", "匹", "個", "席", "束", "歳", "目", "通", "面", "円", "玉", "枚", 
    "前", "後", "左", "右", "次", "先", "春", "夏", "秋", "冬", "一", "二", "三", 
    "四", "五", "六", "七", "八", "九", "十", "百", "千", "万", "億", "兆", "下記", 
    "上記", "時間", "今回", "前回", "場合", "一つ", "年生", "自分", "ヶ所", "ヵ所", 
    "カ所", "箇所", "ヶ月", "ヵ月", "カ月", "箇月", "名前", "本当", "確か", "時点", 
    "全部", "関係", "近く", "方法", "我々", "違い", "多く", "扱い", "新た", "その後", 
    "半ば", "結局", "様々", "以前", "以後", "以降", "未満", "以上", "以下", "まあ",
    "てる", "てた", "じゃあ", "だった", "そこ", "あなた", "お前", "僕", "ぼく", "私",
    "わたし", "おまえ", "俺", "おれ", "ノート", "LTL", "HTL", "ローカル", "ホーム",
    "そう", "今日", "ところ", "みんな"
] + [chr(ord("あ")+i) for i in range(82)]

def makeWordcloud(misskey : MisskeyAPI.MisskeyAPI):
    """
    メンションのワードクラウド依頼に対してワードクラウドをリプライで返す
    """
    try:
        notes = misskey.readMention(limit=setting["mentionReadCount"])
        myId = misskey.info()["id"]
        for mention in notes:
            if mention["text"]==None:
                continue
            if "ワードクラウド" not in mention["text"]:
                continue
            isReplied = False
            for reply in misskey.showReplies(mention["id"]):
                if reply["user"]["id"]==myId:
                    isReplied = True
                    break
            if isReplied:
                continue
            postData=[]
            untilDate=None
            beforeCount=1
            while len(postData)<1000 and beforeCount>0:
                notes = misskey.readUserNote(mention["user"]["id"],limit=100,untilDate=untilDate)
                beforeCount = len(notes)
                for note in notes:
                    untilDate=datetime.datetime.fromisoformat(note["createdAt"].replace("Z","+00:00"))
                    untilDate=int(untilDate.timestamp())*1000
                    if note["visibility"]!="public":
                        continue
                    text=""
                    if note["cw"]!=None:
                        text=note["cw"]+" "
                    if note["text"]!=None:
                        text=note["text"]
                    if text!="":
                        postData.append(text)
                time.sleep(1)
            postData = list(map(lambda x:textAnalizer.editText(x,emojiDelete=True),postData))
            text = "\n".join([" ".join(textAnalizer.pickNoun(note,chain=True)) for note in postData])

            mask = np.array(Image.open(setting["wordcloudMask"]))
            # ワードクラウドの生成
            wordcloud = WordCloud(
                font_path=setting["wordcloudFont"],  # 日本語フォントを指定
                stopwords=_wordcloud_stopWords,
                background_color='white',
                width=int(600*5/4),
                height=600,
                mask=mask,
                contour_width=3,
                contour_color="red"
            ).generate(text)

            # 画像を保存
            wordcloud.to_file(setting["wordcloudSave"]+"wordcloud_"+mention["id"]+".png")
            fileIds = misskey.uploadMedia([setting["wordcloudSave"]+"wordcloud_"+mention["id"]+".png"])
            misskey.post("\u3164",cw=mention["user"]["name"]+"のワードクラウドを生成したよ",fileIds=fileIds,replyId=mention["id"]) #\u3164->一般的な半角空白や全角空白ではない空白文字
    except Exception as e:
        print(e)


#if DEBUG and __name__=="__main__":
#    readSetting()
#    test=MisskeyAPI.MisskeyAPI()
#    test.readToken("./token",input())
#    makeNote(test)