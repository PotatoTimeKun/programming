import json
import requests
import re
import datetime
import pytz
import time
from transformers import AutoModelForSequenceClassification, AutoTokenizer
import numpy as np
import torch
import gensim
from janome.tokenizer import Tokenizer
import copy
import random

BERTMODELPATH = "./model/bert"
WORD2VECMODELPATH = "./model/word2vec/model.vec"
SETTINGFILE="./setting.json"

class Analizer:
    """
    設計名:分析クラス
    _note : ノート list<dict>
    result : 分析結果 dict
    _emoji : 絵文字 dict
    _removePattern : 削除パターン list<re.Pattern>
    _dayRange : 日数 int
    """
    def __init__(self):
        self.result = {}
        self._dayRange = 42
        self._note = []
        self._removePattern = [
            re.compile(r"https?://[\w!\?/\+\-_~=;\.,\*&@#\$%\(\)'\[\]]+"),
            re.compile(r"\*\*"),
            re.compile(r"<[/\w]+>"),
            re.compile(r"\$\[\S+(\s.*?)\]"),
            re.compile(r"@[\w\.]+")
        ]
        #設定の読み込み
        self._setting = {}
        try:
            settingFile = open(SETTINGFILE,"r",encoding="utf-8")
            self._setting = json.load(settingFile)
            settingFile.close()
        except:
            try:
                settingFile = open(SETTINGFILE,"r",encoding="cp932")
                self._setting = json.load(settingFile)
                settingFile.close()
            except:
                print("setting file open Failure")
                self._setting["server"] = "https://sushi.ski"
                self._setting["negativeFilter"] = {"activate":False}
                self._setting["sampleSize"] = 10
        if("server" not in self._setting.keys()):
            self._setting["server"] = "https://sushi.ski"
        if("negativeFilter" not in self._setting.keys()):
            self._setting["negativeFilter"] = {"activate":False}
        if("sampleSize" not in self._setting.keys()):
            self._setting["sampleSize"] = 10
        print(f"set server as {self._setting['server']}")
        print(f"negative filter : {self._setting['negativeFilter']['activate']}")
        #絵文字の取得
        api_url = f"{self._setting['server']}/api/emojis"
        param = json.dumps({})
        response = []
        try:
            print("sending API(emojis)...")
            response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
            response.raise_for_status()
            print("API OK")
            response = response.json()["emojis"]
        except:
            try:
                print("sending API(emojis)...")
                response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
                response.raise_for_status()
                print("API OK")
                response = response.json()["emojis"]
            except:
                print("reading emojis Failure")
                response = []
        #絵文字のデータ形式を整形
        self._emoji = {}
        for i in response:
            if(len(i["aliases"])<=0):
                continue
            self._emoji[i["name"]] = i["aliases"][0]
        if(self._setting["server"] in ["https://sushi.ski","https://misskey.io"]):
            self._emoji["blank"] = ""
        #感情分析用
        print("reading model now...(please wait)")
        self._device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self._tokenizer = AutoTokenizer.from_pretrained(BERTMODELPATH)
        self._model = (AutoModelForSequenceClassification.from_pretrained(BERTMODELPATH).to(self._device))
        self._w2vModel = gensim.models.word2vec.KeyedVectors.load_word2vec_format(WORD2VECMODELPATH)
        self._janomeTokenizer = Tokenizer()
        print("read model OK")
        
    def rangeSet(self,day: int):
        """
        設計名:分析範囲セット
        """
        if(type(day)!=int):
            return
        if(day<=0):
            return
        self._dayRange = day

    def callNote(self,token: str) -> bool:
        """
        設計名:ノート呼び出し
        APIでノートを呼んで保存する
        成功したかどうかを返す
        """
        self._note = []
        #ユーザーIDの取得
        api_url = f"{self._setting['server']}/api/i"
        param = json.dumps({"i": token})
        user_id = ""
        try:
            print("sending API(i)...")
            response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
            response.raise_for_status()
            print("API OK")
            user_id = response.json()["id"]
        except:
            try:
                print("sending API(i)...")
                response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
                response.raise_for_status()
                print("API OK")
                user_id = response.json()["id"]
            except:
                print("API error(i)")
                False
        #ノートの取得
        api_url="https://sushi.ski/api/users/notes"
        nowDate = datetime.datetime.now(pytz.timezone("Asia/Tokyo"))
        untilDate = datetime.datetime(nowDate.year,nowDate.month,nowDate.day,0,0,0,tzinfo=pytz.timezone("Asia/Tokyo"))
        sinceDate = datetime.datetime(nowDate.year,nowDate.month,nowDate.day,0,0,0,tzinfo=pytz.timezone("Asia/Tokyo")) - datetime.timedelta(days=self._dayRange)
        while True:
            param = json.dumps({"i": token,"userId" : user_id,"withRenotes" : False,"limit" : 100 , "untilDate" : int(untilDate.timestamp())*1000 , "sinceDate" : int(sinceDate.timestamp())*1000})
            response = {}
            print(f"reading note from {int(sinceDate.timestamp())*1000} to {int(untilDate.timestamp())*1000}")
            try:
                print("sending API(users/notes)...")
                response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
                response.raise_for_status()
                print("API OK")
                response = response.json()
            except:
                try:
                    print("sending API(users/notes)...")
                    response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
                    response.raise_for_status()
                    print("API OK")
                    response = response.json()
                except:
                    print("reading note Failure")
                    return False
            noteCount = len(response)
            print(f"read {noteCount}note")
            if noteCount<=0:
                break
            self._note+=response
            untilDate = datetime.datetime.fromisoformat(response[-1]["createdAt"].replace("Z","+00:00")) - datetime.timedelta(milliseconds=1)
            if untilDate<sinceDate:
                break
            time.sleep(1)
        #ノートの整形
        for i in range(len(self._note)-1,-1,-1):
            if(self._note[i]["text"]==None or self._note[i]["text"]==""):
                del self._note[i]
                continue
            if(self._note[i]["cw"]!=None):
                self._note[i]["text"]=self._note[i]["cw"]+"\n"+self._note[i]["text"]
            self._note[i]["text"] = self._noteFormatter(self._note[i]["text"])
            if(self._note[i]["text"]==None or self._note[i]["text"]==""):
                del self._note[i]
        return True

    def readNote(self,filename: str) -> bool:
        """
        設計名:ノート読み込み
        ファイルからノートを読み込んで保存する
        成功したかどうかを返す
        """
        self._note = []
        #ファイルを開ける
        file = None
        notes = []
        try:
            print("opening file as utf-8...")
            file = open(filename,"r",encoding="utf-8")
            print("open OK")
            notes = json.load(file)
            print("read OK")
            file.close()
        except:
            try:
                print("opening file as cp932...")
                file = open(filename,"r",encoding="cp932")
                print("open OK")
                notes = json.load(file)
                print("read OK")
                file.close()
            except:
                print("file Error")
                return False
        #分析範囲内だけ取り出して保存
        nowDate = datetime.datetime.now(pytz.timezone("Asia/Tokyo"))
        untilDate = datetime.datetime(nowDate.year,nowDate.month,nowDate.day,0,0,0,tzinfo=pytz.timezone("Asia/Tokyo"))
        sinceDate = datetime.datetime(nowDate.year,nowDate.month,nowDate.day,0,0,0,tzinfo=pytz.timezone("Asia/Tokyo")) - datetime.timedelta(days=self._dayRange)
        print(f"read {len(notes)}note")
        for i in notes:
            createdDate = datetime.datetime.fromisoformat(i["createdAt"].replace("Z","+00:00"))
            if(not (untilDate>=createdDate>=sinceDate)):
                continue
            i["text"]=self._noteFormatter(i["text"])
            if(i["cw"]!=None):
                i["text"]=i["cw"]+"\n"+i["text"]
            if(i["text"]==""):
                continue
            self._note.append(i)
        print(f"found {len(self._note)}note in analizing range")
        return True

    def _noteFormatter(self,note: str) -> str:
        """
        設計名:ノート整形
        """
        if(note==None or note==""):
            return ""
        #削除パターンを削除
        for pattern in self._removePattern:
            searched = pattern.search(note)
            while(searched!=None):
                inner = ""
                try:
                    inner = searched.group(1)
                except:
                    inner = ""
                note = note[:searched.span(0)[0]]+inner+note[searched.span(0)[1]:]
                searched = pattern.search(note)
        #絵文字とそれ以外をカウント
        emojiPattern = re.compile(r":(\w+?):")
        noEmoji = note
        searched = emojiPattern.search(noEmoji)
        while(searched!=None):
            noEmoji = noEmoji[:searched.span(0)[0]]+noEmoji[searched.span(0)[1]:]
            searched = emojiPattern.search(noEmoji)
        noEmoji = noEmoji.replace(" ","")
        noEmoji = noEmoji.replace("\n","")
        emojiCount = len(emojiPattern.findall(note))
        mojiCount = len(noEmoji)
        if(mojiCount<=10 and emojiCount>=10 or mojiCount==0 and emojiCount>=4):
            return ""
        #絵文字をエイリアスに置き換え
        searched = emojiPattern.search(note)
        while(searched!=None):
            alias = ""
            if(searched.group(1) in self._emoji.keys() and self._emoji[searched.group(1)]!=""):
                alias = "["+self._emoji[searched.group(1)]+"]"
            note = note[:searched.span(0)[0]]+alias+note[searched.span(0)[1]:]
            searched = emojiPattern.search(note)
        #空白文字のみなら弾く
        blankPattern = re.compile(r"^\s\s*$")
        if(blankPattern.match(note)!=None):
            return ""
        return note

    def analize(self):
        """
        設計名:分析
        """
        if(len(self._note)<=0):
            self.result={
                "status":"failure",
                "reason":"分析できるノートがない"
            }
            return False
        print("analize start")
        # 全体にネガポジ判定
        note = {
            "negative":[],
            "neutral":[],
            "positive":[]
        }
        print("phase 1...")
        for i in self._note:
            i["negaposi"] = self._negaposi(i["text"],i["visibility"])
            note[i["negaposi"]].append(i)
        self.result["range"] = self._dayRange
        self.result["noteCount"] = len(self._note)
        self.result["posiCount"] = len(note["positive"])
        self.result["neutCount"] = len(note["neutral"])
        self.result["negaCount"] = len(note["negative"])
        print("phase 1 OK")
        print("positive note sample")
        for i in random.sample(note["positive"],min(self._setting["sampleSize"],len(note["positive"]))):
            print(i["text"])
        print("\nneutral note sample")
        for i in random.sample(note["neutral"],min(self._setting["sampleSize"],len(note["neutral"]))):
            print(i["text"])
        print("\nnegative note sample")
        for i in random.sample(note["negative"],min(self._setting["sampleSize"],len(note["negative"]))):
            print(i["text"])
        #各時間帯でネガポジの割合を出す
        print("\nphase 2...")
        self.result["timeBase"] = {
            "posiCount":[0]*24,
            "neutCount":[0]*24,
            "negaCount":[0]*24,
            "noteCount":[0]*24,
            "posiPerNote":[0]*24,
            "neutPerNote":[0]*24,
            "negaPerNote":[0]*24,
            "maxNega":None
        }
        for i in note["negative"]:
            createdDate = datetime.datetime.fromisoformat(i["createdAt"].replace("Z","+00:00")).astimezone(pytz.timezone("Asia/Tokyo"))
            self.result["timeBase"]["negaCount"][createdDate.hour]+=1
            self.result["timeBase"]["noteCount"][createdDate.hour]+=1
        for i in note["neutral"]:
            createdDate = datetime.datetime.fromisoformat(i["createdAt"].replace("Z","+00:00")).astimezone(pytz.timezone("Asia/Tokyo"))
            self.result["timeBase"]["neutCount"][createdDate.hour]+=1
            self.result["timeBase"]["noteCount"][createdDate.hour]+=1
        for i in note["positive"]:
            createdDate = datetime.datetime.fromisoformat(i["createdAt"].replace("Z","+00:00")).astimezone(pytz.timezone("Asia/Tokyo"))
            self.result["timeBase"]["posiCount"][createdDate.hour]+=1
            self.result["timeBase"]["noteCount"][createdDate.hour]+=1
        for i in range(24):
            if(self.result["timeBase"]["noteCount"][i]<=0 and i==0):
                self.result["timeBase"]["negaPerNote"][i] = 0
                self.result["timeBase"]["neutPerNote"][i] = 0
                self.result["timeBase"]["posiPerNote"][i] = 0
                continue
            elif(self.result["timeBase"]["noteCount"][i]<=0):
                self.result["timeBase"]["negaPerNote"][i] = self.result["timeBase"]["negaPerNote"][i-1]
                self.result["timeBase"]["neutPerNote"][i] = self.result["timeBase"]["negaPerNote"][i-1]
                self.result["timeBase"]["posiPerNote"][i] = self.result["timeBase"]["negaPerNote"][i-1]
                continue
            self.result["timeBase"]["negaPerNote"][i] = self.result["timeBase"]["negaCount"][i]/self.result["timeBase"]["noteCount"][i]
            self.result["timeBase"]["neutPerNote"][i] = self.result["timeBase"]["neutCount"][i]/self.result["timeBase"]["noteCount"][i]
            self.result["timeBase"]["posiPerNote"][i] = self.result["timeBase"]["posiCount"][i]/self.result["timeBase"]["noteCount"][i]
        self.result["timeBase"]["maxNega"] = self.result["timeBase"]["negaPerNote"].index(max(self.result["timeBase"]["negaPerNote"]))
        print("phase 2 OK")
        #各曜日でネガポジの割合を出す
        print("phase 3...")
        self.result["weekBase"] = {
            "posiCount":[0]*7,
            "neutCount":[0]*7,
            "negaCount":[0]*7,
            "noteCount":[0]*7,
            "posiPerNote":[0]*7,
            "neutPerNote":[0]*7,
            "negaPerNote":[0]*7,
            "maxNega":None
        }
        for i in note["negative"]:
            createdDate = datetime.datetime.fromisoformat(i["createdAt"].replace("Z","+00:00")).astimezone(pytz.timezone("Asia/Tokyo"))
            self.result["weekBase"]["negaCount"][createdDate.weekday()]+=1
            self.result["weekBase"]["noteCount"][createdDate.weekday()]+=1
        for i in note["neutral"]:
            createdDate = datetime.datetime.fromisoformat(i["createdAt"].replace("Z","+00:00")).astimezone(pytz.timezone("Asia/Tokyo"))
            self.result["weekBase"]["neutCount"][createdDate.weekday()]+=1
            self.result["weekBase"]["noteCount"][createdDate.weekday()]+=1
        for i in note["positive"]:
            createdDate = datetime.datetime.fromisoformat(i["createdAt"].replace("Z","+00:00")).astimezone(pytz.timezone("Asia/Tokyo"))
            self.result["weekBase"]["posiCount"][createdDate.weekday()]+=1
            self.result["weekBase"]["noteCount"][createdDate.weekday()]+=1
        for i in range(7):
            if(self.result["weekBase"]["noteCount"][i]<=0 and i==0):
                self.result["weekBase"]["negaPerNote"][i] = 0
                self.result["weekBase"]["neutPerNote"][i] = 0
                self.result["weekBase"]["posiPerNote"][i] = 0
                continue
            elif(self.result["weekBase"]["noteCount"][i]<=0):
                self.result["weekBase"]["negaPerNote"][i] = self.result["weekBase"]["negaPerNote"][i-1]
                self.result["weekBase"]["neutPerNote"][i] = self.result["weekBase"]["negaPerNote"][i-1]
                self.result["weekBase"]["posiPerNote"][i] = self.result["weekBase"]["negaPerNote"][i-1]
                continue
            self.result["weekBase"]["negaPerNote"][i] = self.result["weekBase"]["negaCount"][i]/self.result["weekBase"]["noteCount"][i]
            self.result["weekBase"]["neutPerNote"][i] = self.result["weekBase"]["neutCount"][i]/self.result["weekBase"]["noteCount"][i]
            self.result["weekBase"]["posiPerNote"][i] = self.result["weekBase"]["posiCount"][i]/self.result["weekBase"]["noteCount"][i]
        self.result["weekBase"]["maxNega"] = self.result["weekBase"]["negaPerNote"].index(max(self.result["weekBase"]["negaPerNote"]))
        print("phase 3 OK")
        #時系列で日毎のネガポジの割合を出す
        print("phase 4...")
        nowDate = datetime.datetime.now(pytz.timezone("Asia/Tokyo"))
        startDate = datetime.datetime(nowDate.year,nowDate.month,nowDate.day,0,0,0,tzinfo=pytz.timezone("Asia/Tokyo"))
        self.result["timeSeries"] = {
            "posiCount":[0]*self._dayRange,
            "neutCount":[0]*self._dayRange,
            "negaCount":[0]*self._dayRange,
            "noteCount":[0]*self._dayRange,
            "posiPerNote":[0]*self._dayRange,
            "neutPerNote":[0]*self._dayRange,
            "negaPerNote":[0]*self._dayRange,
            "maxNega":None
        }
        for i in note["negative"]:
            createdDate = datetime.datetime.fromisoformat(i["createdAt"].replace("Z","+00:00")).astimezone(pytz.timezone("Asia/Tokyo"))
            self.result["timeSeries"]["negaCount"][self._dayRange-1-((startDate-createdDate).days)]+=1
            self.result["timeSeries"]["noteCount"][self._dayRange-1-((startDate-createdDate).days)]+=1
        for i in note["neutral"]:
            createdDate = datetime.datetime.fromisoformat(i["createdAt"].replace("Z","+00:00")).astimezone(pytz.timezone("Asia/Tokyo"))
            self.result["timeSeries"]["neutCount"][self._dayRange-1-((startDate-createdDate).days)]+=1
            self.result["timeSeries"]["noteCount"][self._dayRange-1-((startDate-createdDate).days)]+=1
        for i in note["positive"]:
            createdDate = datetime.datetime.fromisoformat(i["createdAt"].replace("Z","+00:00")).astimezone(pytz.timezone("Asia/Tokyo"))
            self.result["timeSeries"]["posiCount"][self._dayRange-1-((startDate-createdDate).days)]+=1
            self.result["timeSeries"]["noteCount"][self._dayRange-1-((startDate-createdDate).days)]+=1
        for i in range(self._dayRange):
            if(self.result["timeSeries"]["noteCount"][i]<=0 and i==0):
                self.result["timeSeries"]["negaPerNote"][i] = 0
                self.result["timeSeries"]["neutPerNote"][i] = 0
                self.result["timeSeries"]["posiPerNote"][i] = 0
                continue
            elif(self.result["timeSeries"]["noteCount"][i]<=0):
                self.result["timeSeries"]["negaPerNote"][i] = self.result["timeSeries"]["negaPerNote"][i-1]
                self.result["timeSeries"]["neutPerNote"][i] = self.result["timeSeries"]["negaPerNote"][i-1]
                self.result["timeSeries"]["posiPerNote"][i] = self.result["timeSeries"]["negaPerNote"][i-1]
                continue
            self.result["timeSeries"]["negaPerNote"][i] = self.result["timeSeries"]["negaCount"][i]/self.result["timeSeries"]["noteCount"][i]
            self.result["timeSeries"]["neutPerNote"][i] = self.result["timeSeries"]["neutCount"][i]/self.result["timeSeries"]["noteCount"][i]
            self.result["timeSeries"]["posiPerNote"][i] = self.result["timeSeries"]["posiCount"][i]/self.result["timeSeries"]["noteCount"][i]
        print("phase 4 OK")
        #ネガティブノートの詳細な感情を見る
        print("phase 5...")
        offensiveCount = 0
        downerCount = 0
        for i in note["negative"]:
            detail = self._detailAnalize(i["text"])
            if(detail=="offensive"):
                offensiveCount+=1
            else:
                downerCount+=1
        if(len(note["negative"])<=0):
            self.result["detail"] = {
                "offensive" : 0,
                "downer" : 0
            }
        else:
            self.result["detail"] = {
                "offensive" : offensiveCount/len(note["negative"]),
                "downer" : downerCount/len(note["negative"])
            }
        print("phase 5 OK")
        self.result["status"] = "success"
        return True
    
    def _negaposi(self,note: str,visibility: str) -> str:
        """
        設計名:感情分析
        negative or neutral or positiveを返す
        """
        inputs = self._tokenizer(note, return_tensors="pt")
        try:
            with torch.no_grad():
                outputs = self._model(
                    inputs["input_ids"].to(self._device),
                    inputs["attention_mask"].to(self._device)
                )
        except:
            return "neutral"
        strength = outputs.logits.to('cpu').detach().numpy().copy()
        if(self._setting["negativeFilter"]["activate"] and visibility in self._setting["negativeFilter"]["value"].keys()):
            if(self._setting["negativeFilter"]["value"][visibility]>=strength[0][2]):
                strength[0][2]-=5
        y_preds = np.argmax(strength, axis=1)
        return [self._model.config.id2label[x] for x in y_preds][0]
    
    def _detailAnalize(self,note: str) -> str:
        """
        設計名:詳細分析
        offensive or downerを返す
        """
        #形態素分析
        words = []
        for word in self._janomeTokenizer.tokenize(note):
            if(word.part_of_speech.split(',')[0]=="名詞" and (word.part_of_speech.split(',')[1] not in ["非自立","接尾","数"]) and (word.surface[0] not in ["…","."])):
                words.append(word.surface)
            if(word.part_of_speech.split(',')[0]=="動詞" and (word.part_of_speech.split(",")[1] not in ["非自立"]) and word.base_form!="する"):
                words.append(word.surface)
            if(word.part_of_speech.split(',')[0] in ["形容詞","副詞"] and word.part_of_speech.split(',')[1]=="自立"):
                words.append(word.surface)
        #スコア化
        score = [0,0]
        offensiveEmotion = ["怒り","嫌悪","苛立ち","憤り","軽蔑"]
        downerEmotion = ["悲しい","鬱","寂しい","絶望","憂鬱"]
        for word in words:
            before = copy.deepcopy(score)
            try:
                for emotion in offensiveEmotion:
                    score[0] += self._w2vModel.similarity(word,emotion)
                for emotion in downerEmotion:
                    score[1] += self._w2vModel.similarity(word,emotion)
            except:
                score = before
        if "!" in note or "！" in note:
            score[0]*=1.1
        if "..." in note or "..." in note:
            score[0]*=1.1
        return ["offensive","downer"][score.index(max(score))]

