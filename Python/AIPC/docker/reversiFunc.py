from copy import deepcopy
import threading
import random
import websocket
import requests
import json
import time
import datetime
import MisskeyAPI

DEBUG = False

class Reversi:
    def __init__(this):
        this.table = [[this.NOTHING]*8 for i in range(8)]
        this.turn = this.WHITE
        this.setMode = this.EASY # オセロの難易度
        this.depthMax = 6 # アルファベータ法の探索の深さ
    
    EASY = 1

    NORMAL = 2

    DIFFICULT = 3

    def setAll(this,table):
        """
        テーブルをすべてセットする(初期設定用)
        """
        this.table = table
    def setAt(this,i,j,value):
        """
        コマをセットする(初期設定用)
        """
        if(value not in [this.WHITE,this.NOTHING,this.BLACK]):
            print(f"table value error : {value}")
            return
        this.table[i][j] = value

    NOTHING = 0
    #何も置いてない

    WHITE = 1
    # 白

    BLACK = -1
    # 黒

    def getReverseTurn(this):
        """
        次のターンがどっちかを返す
        """
        if (this.turn == this.WHITE):
            return this.BLACK
        return this.WHITE
    def setTurn(this,turn):
        """
        ターンをセットする(初期設定用)
        """
        if(turn not in [this.WHITE,this.BLACK]):
            print(f"turn value error : {turn}")
            return
        this.turn = turn
    def getAvailable(this):
        """
        次に置ける場所を返す
        List<List>
        """
        result = []
        for i in range(8):
            for j in range(8):
                if(this.table[i][j]!=this.NOTHING):
                    continue
                doBreak = False
                for iAdd in range(-1,2):
                    for jAdd in range(-1,2):
                        if(iAdd==0 and jAdd==0):
                            continue
                        connecting = True
                        for add in range(1,8):
                            if (not(0<=i+iAdd*add<8 and 0<=j+jAdd*add<8)):
                                connecting = False
                                break
                            if (this.table[i+iAdd*add][j+jAdd*add]==this.turn and add>1):
                                break
                            if (this.table[i+iAdd*add][j+jAdd*add]==this.turn and add==1):
                                connecting = False
                                break
                            if (this.table[i+iAdd*add][j+jAdd*add]==this.NOTHING):
                                connecting = False
                                break
                            if ((not(0<=i+iAdd*(add+1)<8 and 0<=j+jAdd*(add+1)<8)) and this.table[i+iAdd*add][j+jAdd*add]!=this.turn):
                                connecting = False
                                break
                        if (connecting):
                            result.append([i,j])
                            doBreak = True
                            break
                    if (doBreak):
                        break
        return result
    def score(this):
        """
        評価用の点数
        白の視点での点数
        """
        base = sum([sum(i) for i in this.table])
        for i in range(8):
            base += this.table[0][i]*4
            base += this.table[7][i]*4
            base += this.table[i][0]*4
            base += this.table[i][7]*4
        return base
    def sum(this):
        """
        盤面上にある白(1点)と黒(-1点)の点数の合計
        """
        return sum([sum(i) for i in this.table])
    def isEnd(this):
        """
        ゲームが終了したか
        """
        skip = (len(this.getAvailable())==0)
        if (not skip):
            return False
        this.turn = this.getReverseTurn()
        nextSkip = (len(this.getAvailable())==0)
        this.turn = this.getReverseTurn()
        return skip and nextSkip
    def nextAt(this,i,j):
        """
        指定した場所にコマを置いてターンを進める
        """
        this.table[i][j] = this.turn
        directList = []
        for iAdd in range(-1,2):
            for jAdd in range(-1,2):
                if(iAdd==0 and jAdd==0):
                    continue
                connecting = True
                for add in range(1,8):
                    if (not(0<=i+iAdd*add<8 and 0<=j+jAdd*add<8)):
                        connecting = False
                        break
                    if (this.table[i+iAdd*add][j+jAdd*add]==this.turn and add>1):
                        break
                    if (this.table[i+iAdd*add][j+jAdd*add]==this.turn and add==1):
                        connecting = False
                        break
                    if (this.table[i+iAdd*add][j+jAdd*add]==this.NOTHING):
                        connecting = False
                        break
                    if ((not(0<=i+iAdd*(add+1)<8 and 0<=j+jAdd*(add+1)<8)) and this.table[i+iAdd*add][j+jAdd*add]!=this.turn):
                        connecting = False
                        break
                if (connecting):
                    doBreak = True
                    directList.append([iAdd,jAdd])
        for direct in directList:
            for add in range(1,8):
                if (this.table[i+direct[0]*add][j+direct[1]*add]==this.turn):
                    break
                this.table[i+direct[0]*add][j+direct[1]*add] = this.turn
        this.turn = this.getReverseTurn()
    def next(this):
        """
        次の最適解を実行
        置いた場所を返す
        """
        global timer
        place = this.getAvailable()
        if (len(place)==0):
            this.turn = this.getReverseTurn()
            return []
        if (len(place)==1):
            this.nextAt(place[0][0],place[0][1])
            return place[0]
        if (this.turn==1):
            this.sign = 1
        else:
            this.sign = -1
        if (this.setMode == this.EASY):
            result = place[this._getMax()]
            this.nextAt(result[0],result[1])
            return result
        if (this.setMode == this.NORMAL):
            this.depthMax = 2
        if (this.setMode == this.DIFFICULT):
            this.depthMax = 6
        timer = 0
        result = place[this._nextInner(this,10000,0)[1]]
        this.nextAt(result[0],result[1])
        return result
            
    TIMELIMIT = 20
    # アルファベータ法の最大実行時間

    def _getMax(this):
        place = this.getAvailable()
        score = []
        for i in range(len(place)):
            nextTable = Reversi()
            nextTable.setAll(deepcopy(this.table))
            nextTable.turn = this.turn
            nextTable.nextAt(place[i][0],place[i][1])
            score.append(this.sign*nextTable.score())
        return score.index(max(score))

    def _nextInner(this,table,cutting,depth):
        """
        アルファベータ法
        """
        if (timer>this.TIMELIMIT):
            return [0,random.randint(0,len(this.getAvailable())-1)]
        if (depth>=this.depthMax):
            return [-1*this.sign*table.score()]
        if (table.isEnd()):
            return [-1*this.sign*table.score()]
        miniMaxValue = -10000
        miniMax = -1
        place = table.getAvailable()
        if (len(place)==0):
            return [-1*this._nextInner(table,-1*cutting,depth+1)[0]]
        for i in range(len(place)):
            nextTable = Reversi()
            nextTable.setAll(deepcopy(table.table))
            nextTable.turn = table.turn
            nextTable.nextAt(place[i][0],place[i][1])
            score = this._nextInner(nextTable,-1*miniMaxValue,depth+1)[0]
            if (score>=cutting):
                return [-1*score]
            if (score>miniMaxValue):
                miniMaxValue = score
                miniMax = i
        if (timer>this.TIMELIMIT):
            print("time out")
            return [0,random.randint(0,len(this.getAvailable())-1)]
        return [-1*miniMaxValue,miniMax]

    def show(this):
        """
        盤面を表示
        """
        for i in range(8):
            for j in range(8):
                if (this.table[i][j]==this.NOTHING):
                    print("_",end="")
                elif (this.table[i][j]==this.WHITE):
                    print("O",end="")
                elif (this.table[i][j]==this.BLACK):
                    print("X",end="")
                else:
                    print("?",end="")
            print("")
    
    def showAt(this,array):
        """
        指定された場所を表示
        array : list<list>
                ex) [[1,2],[2,3]]
        """
        for i in range(8):
            for j in range(8):
                if ([i,j] in array):
                    print("*",end="")
                else:
                    print("_",end="")
            print("")

class ReversiRunner:
    def __init__(this,misskey : MisskeyAPI.MisskeyAPI):
        this.misskey = misskey
        this.myId = misskey.info()["id"]
        this.reversi = Reversi()

    def setDifficulty(this,difficulty):
        this.reversi.setMode = difficulty
    
    def run(this):
        uri = f"wss://{this.misskey.server}/streaming?i={this.misskey.token}"
        this.websocket = websocket.create_connection(uri)
        this.reversiChannelId = f"{random.randint(100000,999999)}"
        this.websocket.send(json.dumps({"type": "connect","body": {"channel": "reversi","id":this.reversiChannelId}}))
        time.sleep(1)
        while this.isContinue():
            try:
                this.wait()
                time.sleep(1)
                this.gameChannelId=f"{random.randint(100000,999999)}"
                this.websocket.send(json.dumps({"type": "connect","body": {"channel": "reversiGame","id":this.gameChannelId,"params": {"gameId": this.gameId}}}))
                time.sleep(1)
                this.ready()
                time.sleep(1)
                this.game()
                time.sleep(1)
                this.websocket.send(json.dumps({"type": "disconnect","body": {"id":this.gameChannelId}}))
            except websocket._exceptions.WebSocketConnectionClosedException as e:
                time.sleep(10)
                raise e
            except Exception as e:
                print(e)
                time.sleep(10)
        this.websocket.send(json.dumps({"type": "disconnect","body": {"id":this.reversiChannelId}}))
        this.websocket.close()

    def isContinue(this):
        if DEBUG:
            return True
        if datetime.datetime.now().hour<setting["reversiEnd"] and datetime.datetime.now().hour>=setting["reversiStart"]:
            return True
        return False
    
    def put(this):
        if this.reversi.isEnd():
            return
        if DEBUG:
            this.reversi.show()
        result = this.reversi.next()
        if DEBUG:
            print(result)
            this.reversi.show()
        if (len(result)==0):
            return
        this.websocket.send(json.dumps({"type": "channel","body": {"type": "putStone","body": {"pos": result[0]*8+result[1],"id": this.myId},"id": this.gameChannelId}}))
        if len(this.reversi.getAvailable())==0:
            this.reversi.turn = this.reversi.getReverseTurn()
            this.put()
    
    def wait(this):
        this.websocket.settimeout(40)
        while this.isContinue():
            try:
                apiurl = f"https://{this.misskey.server}/api/reversi/match"
                data = json.dumps({"i": this.misskey.token,"noIrregularRules": True})
                response = requests.post(apiurl,headers={"Content-Type": "application/json"},data=data)
                response.raise_for_status()
                if response.status_code==204:#マッチ待機ならwebsocketでマッチ情報を拾う
                    response = json.loads(this.websocket.recv())
                    if "body" in response.keys() and "type" in response["body"].keys() and response["body"]["type"]=="matched":
                        this.gameId = response["body"]["body"]["game"]["id"]
                        if (response["body"]["body"]["game"]["user1Id"]==this.myId):
                            this.user1 = True
                        else:
                            this.user1 = False
                        return
                elif response.status_code==200:#即時にマッチしたならそれを使う
                    response = response.json()
                    this.gameId = response["id"]
                    if (response["user1Id"]==this.myId):
                        this.user1 = True
                    else:
                        this.user1 = False
                    return 
            except websocket._exceptions.WebSocketConnectionClosedException as e:
                raise e
            except:
                pass

    def ready(this):
        this.websocket.settimeout(10)
        this.websocket.send(json.dumps({"type": "channel","body": {"type": "ready","body": True,"id": this.gameChannelId}}))
        while True:
            try:
                receipt = json.loads(this.websocket.recv())
            except websocket._exceptions.WebSocketConnectionClosedException as e:
                raise e
            except:
                this.websocket.send(json.dumps({"type": "channel","body": {"type": "ready","body": True,"id": this.gameChannelId}}))
                continue
            if("body" in receipt.keys() and "type" in receipt["body"].keys() and receipt["body"]["type"]=="canceled"):
                raise Exception("リバーシ : マッチがキャンセルされた")
            if("body" in receipt.keys() and "type" in receipt["body"].keys() and receipt["body"]["type"]=="changeReadyStates" and receipt["body"]["body"]["user1"] and receipt["body"]["body"]["user2"]):
                return

    def game(this):
        this.websocket.settimeout(500)
        while True:
            receipt = json.loads(this.websocket.recv())
            if("body" in receipt.keys() and "type" in receipt["body"].keys() and receipt["body"]["type"]=="started"):
                if(receipt["body"]["body"]["game"]["black"]==1 and this.user1 or receipt["body"]["body"]["game"]["black"]==2 and (not this.user1)):
                    this.first = True
                else:
                    this.first = False
                this.reversi.setAll(this.mapToData(receipt["body"]["body"]["game"]["map"]))
                if(this.first):
                    this.reversi.setTurn(Reversi.WHITE)
                    this.put()
                else:
                    this.reversi.setTurn(Reversi.BLACK)
                break
        while True:
            receipt = json.loads(this.websocket.recv())
            if("body" in receipt.keys() and "type" in receipt["body"].keys() and receipt["body"]["type"]=="log" and (receipt["body"]["body"]["player"]!=this.first)):
                this.reversi.nextAt(receipt["body"]["body"]["pos"]//8,receipt["body"]["body"]["pos"]%8)
                this.put()
            if("body" in receipt.keys() and "type" in receipt["body"].keys() and receipt["body"]["type"]=="ended"):
                break
    
    def mapToData(this,mapData):
        data = []
        for i in mapData:
            data.append([])
            for j in i:
                if (j=="-"):
                    data[-1].append(0)
                elif(j=="b"):
                    if (this.first):
                        data[-1].append(Reversi.WHITE)
                    else:
                        data[-1].append(Reversi.BLACK)
                elif(j=="w"):
                    if (this.first):
                        data[-1].append(Reversi.BLACK)
                    else:
                        data[-1].append(Reversi.WHITE)
        return data
            

setting = {}

def startReversi(misskey : MisskeyAPI.MisskeyAPI):
    readSetting()
    try:
        difficultyStr = ["簡単","普通","難しい"]
        difficulty = [Reversi.EASY,Reversi.NORMAL,Reversi.DIFFICULT]
        difficultyIndex = random.randint(0,2)
        if not DEBUG:
            misskey.post(f"リバーシしようぜ！({setting["reversiStart"]}～{setting["reversiEnd"]}時)\n今日の難易度:{difficultyStr[difficultyIndex]}\nリバーシ→フリーマッチ→変則なしでできるよ")
        runner = ReversiRunner(misskey)
        runner.setDifficulty(difficulty[difficultyIndex])
        runner.run()
    except Exception as e:
        print(e)

def readSetting():
    """
    AIPCsetting.jsonから設定を読み込む
    """
    global setting
    f = open("AIPCsetting.json","r",encoding="utf-8")
    setting = json.load(f)
    f.close()

if __name__=="__main__":
    misskey = MisskeyAPI.MisskeyAPI()
    misskey.readToken("./token",input())
    startReversi(misskey)