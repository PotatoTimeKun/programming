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
            draw.text((300+1000*(i//6),1000/6*(i%6)),month[i],"#000000",font=fontBig)
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