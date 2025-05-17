import requests
import json
import hashlib
import websocket
import random
import pathlib

class MisskeyAPI:
    def __init__(this,token = "",server = "sushi.ski"):
        """
        引数
        token: 直接トークンを指定
        server: Misskeyサーバのドメイン
        """
        this.token = token
        this.server = server
    def readToken(this,filename: str,key: str) -> None:
        """
        トークンを読み込む
        トークンファイルのパスと復号化のパスワードを指定する
        """
        if (filename!=""):
            this.token = Crypt.importFile(filename,key)
    def post(this,text: str,cw = "",visibility = "public",fileIds = [],replyId = None) -> None:
        """
        ノートを投稿する
        """
        if (this.token == ""):
            print("error: no token")
            return
        api_url = f"https://{this.server}/api/notes/create"
        param = {"i": this.token,"text": text,"visibility": visibility}
        if (cw!=""):
            param["cw"] = cw
        if (len(fileIds)!=0):
            param["fileIds"]=fileIds
        if replyId!=None:
            param["replyId"]=replyId
        try:
            response = requests.post(api_url,data=json.dumps(param),headers={"Content-Type": "application/json"})
            response.raise_for_status()
        except Exception as e:
            print(e)
    def uploadMedia(this,images: list,isSensitive = False) -> list:
        """
        ファイルを投稿し、そのファイルIDを返す
        """
        if (this.token == ""):
            print("error: no token")
            return []
        fileIds=[]
        try:
            api_url=f"https://{this.server}/api/drive/files/create"
            param={"i": this.token}
            for i in images:
                response = requests.post(api_url,data=param,files={pathlib.Path(i).name: open(i,"rb")})
                response.raise_for_status()
                fileIds.append(response.json()["id"])
        except Exception as e:
            print(e)
            raise e
        return fileIds
    def readLTL(this,limit,withRenotes = False,withReplies = False,withFiles = None,sinceDate = None,includeCW = True) -> list:
        """
        LTLを読み込む
        """
        api_url = f"https://{this.server}/api/notes/local-timeline"
        param = {"withRenotes": withRenotes,"withReplies": withReplies,"limit": limit}
        if (withFiles != None):
            param["withFiles"] = withFiles
        if (sinceDate != None):
            param["sinceDate"] = sinceDate
        try:
            response = requests.post(api_url,data=json.dumps(param),headers={"Content-Type": "application/json"})
            response.raise_for_status()
        except Exception as e:
            print(e)
            return []
        notes = response.json()
        if includeCW:
            return notes
        for i in range(len(notes)-1,-1,-1):
            if notes[i]["cw"]!=None:
                notes.pop(i)
        return notes
    def makeReaction(this,noteId: str,reaction: str) -> None:
        """
        リアクションを送る
        """
        if (this.token == ""):
            print("error: no token")
            return
        url = f"https://{this.server}/api/notes/reactions/create"
        param = json.dumps({"i": this.token,"noteId": noteId,"reaction": reaction})
        try:
            response = requests.post(url,data=param,headers={"Content-Type": "application/json"})
            response.raise_for_status()
        except Exception as e:
            print("error:MisskeyAPI.py")
            print(e)
    def readEmojis(this) -> list:
        """
        サーバの絵文字リストを返す
        """
        api_url = f"https://{this.server}/api/emojis"
        param = {}
        try:
            response = requests.post(api_url,data=json.dumps(param),headers={"Content-Type": "application/json"})
            response.raise_for_status()
        except Exception as e:
            print(e)
            return []
        emojis = response.json()["emojis"]
        return emojis
    def readAntenna(this,antennaId: str,limit = 10) -> list:
        """
        アンテナを読み込む
        """
        if (this.token == ""):
            print("error: no token")
            return
        url = f"https://{this.server}/api/antennas/notes"
        param = json.dumps({"i": this.token,"antennaId": antennaId,"limit": limit})
        try:
            response = requests.post(url,headers={"Content-Type": "application/json"},data=param)
            response.raise_for_status()
        except Exception as e:
            print("error:MisskeyAPI.py")
            print(e)
            return []
        return response.json()
    def readUserNote(this,userId: str,limit = 10,untilDate = None,sinceDate = None,withRenotes = None) -> list:
        """
        指定したユーザのノートを読み込む
        """
        url = f"https://{this.server}/api/users/notes"
        if this.token=="":
            param = {"userId": userId,"limit": limit}
        else:
            param = {"userId": userId,"limit": limit,"i": this.token}
        if untilDate!=None:
            param["untilDate"]=untilDate
        if sinceDate!=None:
            param["sinceDate"]=sinceDate
        if withRenotes!=None:
            param["withRenotes"]=withRenotes
        param = json.dumps(param)
        try:
            response = requests.post(url,headers={"Content-Type": "application/json"},data=param)
            response.raise_for_status()
        except Exception as e:
            print("error:MisskeyAPI.py")
            print(e)
            return []
        return response.json()
    def readMention(this,limit = 10) -> list:
        """
        メンションを読み込む
        """
        if (this.token == ""):
            print("error: no token")
            return
        url = f"https://{this.server}/api/notes/mentions"
        param = json.dumps({"i": this.token,"limit": limit})
        try:
            response = requests.post(url,headers={"Content-Type": "application/json"},data=param)
            response.raise_for_status()
        except Exception as e:
            print("error:MisskeyAPI.py")
            print(e)
            return []
        return response.json()
    def info(this) -> dict:
        """
        アカウント情報を得る(エンドポイント i )
        """
        if (this.token == ""):
            print("error: no token")
            return
        api_url = f"https://{this.server}/api/i"
        param = json.dumps({"i": this.token})
        try:
            response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
            response.raise_for_status()
        except Exception as e:
            print("error:MisskeyAPI.py")
            print(e)
            return {}
        return response.json()
    def clipOfNote(this,noteId : str) -> list:
        """
        指定したノートのクリップのリストを得る
        """
        api_url = f"https://{this.server}/api/notes/clips"
        if (this.token == ""):
            param = json.dumps({"noteId": noteId})
        else:
            param = json.dumps({"noteId": noteId,"i": this.token})
        try:
            response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
            response.raise_for_status()
        except Exception as e:
            print("error:MisskeyAPI.py")
            print(e)
            return []
        return response.json()
    def clipNote(this,noteId,clipId) -> None:
        """
        ノートをクリップする
        """
        if (this.token == ""):
            print("error: no token")
            return
        api_url = f"https://{this.server}/api/clips/add-note"
        param = json.dumps({"noteId": noteId,"clipId": clipId,"i": this.token})
        try:
            response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
            response.raise_for_status()
        except Exception as e:
            print("error:MisskeyAPI.py")
            print(e)
            raise e
    def clipList(this) -> list:
        """
        自分のクリップのリストを得る
        """
        if (this.token == ""):
            print("error: no token")
            return
        api_url = f"https://{this.server}/api/clips/list"
        param = json.dumps({"i": this.token})
        try:
            response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
            response.raise_for_status()
        except Exception as e:
            print("error:MisskeyAPI.py")
            print(e)
            return []
        return response.json()
    def makeClip(this,name,isPublic = False) -> dict:
        """
        クリップを作成し、クリップの情報を返す
        """
        if (this.token == ""):
            print("error: no token")
            return
        api_url = f"https://{this.server}/api/clips/create"
        param = json.dumps({"name": name,"isPublic": isPublic,"i": this.token})
        try:
            response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
            response.raise_for_status()
        except Exception as e:
            print("error:MisskeyAPI.py")
            print(e)
            return {}
        return response.json()
    def showReplies(this,noteId,limit=10) -> list:
        """
        リプライのリストを返す
        """
        api_url = f"https://{this.server}/api/notes/replies"
        if (this.token == ""):
            param = json.dumps({"noteId": noteId,"limit": limit})
        else:
            param = json.dumps({"noteId": noteId,"limit": limit,"i": this.token})
        try:
            response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
            response.raise_for_status()
        except Exception as e:
            print("error:MisskeyAPI.py")
            print(e)
            return []
        return response.json()

class Crypt:
    @classmethod
    def exportFile(cls,data: str,filename: str,key: str):
        dataList = []
        encodedData = data.encode("utf-8")
        blockLength = (len(encodedData) + 31) // 32
        for i in range(blockLength):
            if i+1==blockLength:
                dataList.append(encodedData[i*32:])
                continue
            dataList.append(encodedData[i*32:(i+1)*32])
        hashList = [hashlib.sha256((key+str(i)).encode("utf-8")).digest() for i in range(blockLength)]
        hashList[-1] = hashList[-1][:len(dataList[-1])]
        code = b"".join(list(map(lambda x,y: b"".join(list(map(lambda a,b: (a^b).to_bytes(1,"big"),x,y))),dataList,hashList)))
        with open(filename,"wb") as f:
            f.write(code)
        return code
    @classmethod
    def importFile(cls,filename: str,key: str):
        with open(filename,"rb") as f:
            data = f.read()
        dataList = []
        blockLength = (len(data) + 31) // 32
        for i in range(blockLength):
            if i+1==blockLength:
                dataList.append(data[i*32:])
                continue
            dataList.append(data[i*32:(i+1)*32])
        hashList = [hashlib.sha256((key+str(i)).encode("utf-8")).digest() for i in range(blockLength)]
        hashList[-1] = hashList[-1][:len(dataList[-1])]
        code = b"".join(list(map(lambda x,y: b"".join(list(map(lambda a,b: (a^b).to_bytes(1,"big"),x,y))),dataList,hashList)))
        return code.decode("utf-8")
