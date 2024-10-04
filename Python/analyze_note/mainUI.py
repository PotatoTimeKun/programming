import tkinter as tk
from tkinter import messagebox
from tkinter import filedialog
import requests
import json
import analizer
import subUI
import os
import pathlib
import random
import threading

TOKENFILE="./token.txt"
SETTINGFILE="./setting.json"

class Ui:
    """
    設計名:画面表示クラス
    _token : APIトークン str
    _noteFile : ノートファイル str
    _manualUi : 説明画面 subUI.ManualUi
    _resultUi : 分析結果画面 subUI.ResultUi
    _analizer : 分析 analizer.Analizer
    _window : 画面 tkinter.Tk
    _widget : ウィジェット dict
    _isAnalyzing : 分析中 bool
    """
    def __init__(self):
        print("program start")
        #ウィンドウ・ウィジェットの作成
        self._window = tk.Tk()
        self._window.title("Misskey Analizer for Mental Health")
        self._window.geometry("800x600")
        self._window.resizable(False,False)
        self._window.configure(bg="#ffffff")
        self._widget = {
            "manualButton" : tk.Button(text="使い方",command=self.manualButtonFunc,width=15,height=1,font=('Times New Roman',12)),
            "tokenLabel" : tk.Label(text="APIトークンの入力",bg="#ffffff",font=('Times New Roman',12)),
            "tokenEntry" : tk.Entry(show="*"),
            "tokenButton" : tk.Button(text="確定",command=self.tokenButtonFunc,width=15,height=1,font=('Times New Roman',12)),
            "fileButton" : tk.Button(text="ファイル入力",command=self.fileButtonFunc,width=15,height=1,font=('Times New Roman',12)),
            "rangeEntry" : tk.Entry(font=('Times New Roman',12)),
            "rangeLabel" : tk.Label(text="日間を分析",bg="#ffffff",font=('Times New Roman',12)),
            "analyzeButton" : tk.Button(text="分析開始",command=self.analyzeButtonFunc,width=15,height=1,font=('Times New Roman',12)),
            "resultButton" : tk.Button(text="分析結果",command=self.resultButtonFunc,width=15,height=1,font=('Times New Roman',12))
        }
        self._widget["rangeEntry"].insert(0, "42")
        #インスタンスの作成
        self._analizer = analizer.Analizer()
        self._manualUi = subUI.ManualUi(self._window,self)
        self._resultUi = subUI.ResultUi(self._window,self)
        #トークンの読み込み
        print("reading token now...")
        self._token = self._tokenRead()
        if(self._token!=""):
            print("token OK")
            self._widget["tokenEntry"].insert(0,self._token)
        else:
            print("no token")
        #フィールドの初期化
        self._isAnalyzing = False
        self._noteFile = ""
            
    def show(self) -> None:
        """
        設計名: 表示
        ウィジェットを配置する
        """
        self._widget["manualButton"].place(x=10,y=10)
        self._widget["tokenLabel"].place(x=10,y=70)
        self._widget["tokenEntry"].place(x=10,y=100,width=480)
        self._widget["tokenButton"].place(x=500,y=95)
        self._widget["fileButton"].place(x=10,y=160)
        self._widget["rangeEntry"].place(x=10,y=220,width=90)
        self._widget["rangeLabel"].place(x=110,y=220)
        self._widget["analyzeButton"].place(x=10,y=270)
        self._widget["resultButton"].place(x=10,y=310)
    
    def run(self) -> None:
        """
        設計名:実行
        """
        print("running GUI")
        self._window.mainloop()
    
    def _clearUi(self) -> None:
        """
        設計名: 表示削除
        ウィジェットの配置を消す(ウィジェット自体は消さない)
        """
        for k in self._widget.keys():
            self._widget[k].place_forget()

    def _tokenSave(self,token: str) -> None:
        """
        設計名:トークン保存
        トークンを外部ファイルに保存する
        """
        if(self._tokenCheck(token)):
            self._token = token
            tokenFile = open(TOKENFILE,"w")
            tokenFile.write(token)
            tokenFile.close()
        else:
            messagebox.showerror("エラー","APIトークンの認証に失敗しました\n以下を確認してください\n・トークンに誤字脱字がないか\n・トークンに権限を設定したか\n・設定されたサーバーURLが正しいか\n・ネットワーク接続がされているか")

    def _tokenRead(self) -> str:
        """
        設計名:トークン読み込み
        外部ファイルからトークンを読み込んで返す
        読み込めない場合は空の文字列を返す
        """
        #ファイル読み込み
        fileText = ""
        try:
            tokenFile = open(TOKENFILE,"r")
            fileText = tokenFile.read()
            tokenFile.close()
        except:
            return ""
        #トークン確認
        if(self._tokenCheck(fileText)):
            return fileText
        else:
            messagebox.showerror("エラー","保存されたAPIトークンの確認に失敗しました")
            return ""
    
    def _tokenCheck(self,token: str) -> bool:
        """
        設計名:トークン確認
        トークンの正当性を確認し、正しいかを返す
        """
        print("checking token...")
        #形式のチェック
        if(len(token)<1 or len(token)>100):
            return False
        for c in token:
            if( not (ord("a")<=ord(c)<=ord("z") or ord("A")<=ord(c)<=ord("Z") or ord("0")<=ord(c)<=ord("9"))):
                return False
        #設定の読み込み
        setting = {}
        try:
            settingFile = open(SETTINGFILE,"r",encoding="utf-8")
            setting = json.load(settingFile)
            settingFile.close()
        except:
            try:
                settingFile = open(SETTINGFILE,"r",encoding="cp932")
                setting = json.load(settingFile)
                settingFile.close()
            except:
                setting["server"] = "https://sushi.ski"
        if("server" not in setting.keys()):
            setting["server"] = "https://sushi.ski"
        print(f"set server as {setting['server']}")
        #接続の確認
        print("sending API(i)...")
        api_url = f"{setting['server']}/api/i"
        param = json.dumps({"i": token})
        try:
            response = requests.post(api_url,data=param,headers={"Content-Type": "application/json"})
            response.raise_for_status()
            print("API OK")
        except:
            return False
            print("API error")
        print("token check OK")
        return True
    
    def _fileCheck(self,filePath: str) -> bool:
        """
        設計名:ファイル確認
        ファイルが読み込めるか・形式が正しいか確認し、正しいかを返す
        """
        #存在・拡張子確認
        if(not os.path.isfile(filePath) or os.path.splitext(filePath)[1]!=".json"):
            messagebox.showerror("エラー","パスの指定が間違っています")
            return False
        notes = []
        #開けるか
        try:
            print("opening note file as utf-8...")
            noteFile = open(filePath,"r",encoding="utf-8")
            print("file open OK")
            notes = json.load(noteFile)
            print("file read OK")
            noteFile.close()
        except:
            try:
                print("open failure\nopening note file as cp932...")
                noteFile = open(filePath,"r",encoding="cp932")
                print("file open OK")
                notes = json.load(noteFile)
                print("file read OK")
                noteFile.close()
            except:
                print("file error")
                messagebox.showerror("エラー","ファイルが開けません\n以下を確認してください\n・選択したファイルが正しいか\n・UTF-8もしくはSHIFT-JISでエンコードされているか")
                return False
        #必要なデータがあるか
        if("text" not in notes[random.randint(0,len(notes)-1)].keys() or "createdAt" not in notes[random.randint(0,len(notes)-1)].keys()):
            messagebox.showerror("エラー","データの形式が異なります")
            return False
        return True

    def _analizeWait(self):
        """
        アナライザーが重すぎて固まるので、別スレッドで実行させるための関数
        """
        if(not self._analizer.analize()):
            self._isAnalyzing = False
            messagebox.showerror("エラー","分析中にエラーが起きました")
            self._widget["analyzeButton"]["text"]="分析開始"
            return False
        self._widget["analyzeButton"]["text"]="分析開始"
        self._isAnalyzing = False
        

    def _analyzeByAPI(self,token: str) -> bool:
        """
        設計名:読み込んで分析
        ノートをAPIで読んで分析させる
        """
        #フラグのセット(回収を忘れずに)
        self._isAnalyzing = True
        self._widget["analyzeButton"]["text"]="分析中..."
        #分析日数の取得・設定
        rangeText = self._widget["rangeEntry"].get()
        if(not all(map(lambda x:ord("0")<=ord(x)<=ord("9"),rangeText))):
            self._isAnalyzing = False
            messagebox.showerror("エラー","分析日数を整数にしてください")
            self._widget["analyzeButton"]["text"]="分析開始"
            return False
        rangeInt = int(rangeText)
        if(rangeInt<1):
            self._isAnalyzing = False
            messagebox.showerror("エラー","分析日数が0以下です")
            self._widget["analyzeButton"]["text"]="分析開始"
            return False
        self._analizer.rangeSet(rangeInt)
        #ノート呼び出し
        if(not self._analizer.callNote(token)):
            self._isAnalyzing = False
            messagebox.showerror("エラー","APIの呼び出し中にエラーが起きました")
            self._widget["analyzeButton"]["text"]="分析開始"
            return False
        #分析
        thread1 = threading.Thread(target=self._analizeWait)
        thread1.start()
        return True

    def _analyzeByFile(self,file: str) -> bool:
        """
        設計名:分析
        ノートをファイルから読んで分析させる
        """
        #フラグのセット(回収を忘れずに)
        self._isAnalyzing = True
        self._widget["analyzeButton"]["text"]="分析中..."
        #分析日数の取得・設定
        rangeText = self._widget["rangeEntry"].get() 
        if(not all(map(lambda x:ord("0")<=ord(x)<=ord("9"),rangeText))):
            self._isAnalyzing = False
            messagebox.showerror("エラー","分析日数を整数にしてください")
            self._widget["analyzeButton"]["text"]="分析開始"
            return False
        rangeInt = int(rangeText)
        if(rangeInt<1):
            self._isAnalyzing = False
            messagebox.showerror("エラー","分析日数が0以下です")
            self._widget["analyzeButton"]["text"]="分析開始"
            return False
        self._analizer.rangeSet(rangeInt)
        #ノート読み込み
        if(not self._analizer.readNote(file)):
            self._isAnalyzing = False
            messagebox.showerror("エラー","ノートファイルの読み込み中にエラーが起きました")
            self._widget["analyzeButton"]["text"]="分析開始"
            return False
        #分析
        thread1 = threading.Thread(target=self._analizeWait)
        thread1.start()
        return True
    
    def resultButtonFunc(self):
        """
        設計名:分析結果ボタン処理
        """
        #分析中・分析前・分析失敗は表示しない
        if(self._isAnalyzing):
            messagebox.showerror("エラー","分析中です")
            return
        if(self._analizer.result=={}):
            messagebox.showerror("エラー","先に分析をしてください")
            return
        if(self._analizer.result["status"]=="failure"):
            messagebox.showerror("エラー","直前の分析が失敗しています")
            return
        #初期化・表示
        self._resultUi.initialize()
        self._resultUi.resultSet(self._analizer.result)
        self._clearUi()
        self._resultUi.show()
    
    def tokenButtonFunc(self):
        """
        設計名:トークン入力確定ボタン処理
        """
        self._tokenSave(self._widget["tokenEntry"].get())

    def manualButtonFunc(self):
        """
        設計名:説明ボタン処理
        """
        self._manualUi.initialize()
        self._clearUi()
        self._manualUi.show()
    
    def analyzeButtonFunc(self):
        """
        設計名:分析ボタン処理
        """
        if(self._isAnalyzing):
            return
        if(self._token!=""):
            self._analyzeByAPI(self._token)
            return
        if(self._noteFile!=""):
            self._analyzeByFile(self._noteFile)
            return
        messagebox.showwarning("エラー","APIトークンかファイルを設定してください")
        return
        
    def fileButtonFunc(self):
        """
        設計名:ファイル入力ボタン処理
        """
        fileName = filedialog.askopenfilename(filetypes=[("","*.json")])
        if(len(fileName)<1):
            return
        if(not self._fileCheck(fileName)):
            return
        self._noteFile = fileName

main=Ui()
main.show()
main.run()