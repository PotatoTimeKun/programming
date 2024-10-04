import abc
import tkinter as tk
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg

class SubUi(metaclass=abc.ABCMeta):
    """
    設計名:サブ画面クラス
    """
    @abc.abstractmethod
    def __init__(self,window,referrer):
        raise NotImplementedError()
    @abc.abstractmethod
    def initialize(self):
        raise NotImplementedError()
    @abc.abstractmethod
    def show(self):
        raise NotImplementedError()
    @abc.abstractmethod
    def _returnMenu(self):
        raise NotImplementedError()
    @abc.abstractmethod
    def returnMenuButton(self):
        raise NotImplementedError()

class ManualUi(SubUi):
    """
    設計名:説明画面クラス
    _page : 現在ページ int
    _window : 画面 tkinter.Tk
    _referrer : 遷移元 Ui
    _widget : ウィジェット dict
    _title : タイトル list<str>
    _explane : 説明文 list<str>
    _image : 説明画像 list<tk.PhotoImage|None>
    """
    def __init__(self,window : tk.Tk,referrer):
        self._window = window
        self._referrer = referrer
        self._title = [
            "ようこそ",
            "サーバー設定",
            "分析の方法",
            "APIトークンの設定",
            "APIトークンの設定",
            "APIトークンの設定",
            "ノートファイルの設定",
            "ノートファイルの設定",
            "分析",
            "分析",
            "その他"
        ]
        self._explane = [
            "Misskey Analizer for Mental Health(MAMH)へようこそ\nこれは、ポテト(タイム)君(https://potatotimekun.github.io/web/)によって開発された、メンタルヘルスを目的としたMisskeyアカウントの分析ツールです",
            "まず分析したい自分のアカウントが存在するMisskeyサーバーをソフトがあるディレクトリ直下のsetting.jsonに書き込んでください\nデフォルトはすしすき－(https://sushi.ski)になっています\n例えば、misskey.ioを使っているのであればここをhttps://misskey.ioに置き換えます\n設定後はソフトを再起動してください(起動時に反映されるので)\nAPIを使わない場合でも、カスタム絵文字のエイリアス取得のためにサーバーと通信します",
            "分析には、MisskeyAPIを使う方法とノートファイルを持ってくる方法があります\nMisskeyAPIを使う場合、Misskeyアカウントと連携してリアルタイムにノートを取得します\nノートファイルを使う場合、自身のMisskeyアカウントから事前にノートをエクスポートして保存しておく必要があります\nどちらかお好きな方を選んでください\nAPIトークンを設定するとAPIが優先さえられるので、トークン設定後にファイルを使いたいときはこのソフトのディレクトリ直下のtoken.txtを消してソフトを再起動してください",
            "APIを使用する場合、トークンを生成して設定する必要があります\n分析したいアカウントでMisskeyサーバーのページを開き、設定→その他の設定の「API」という項目を開きます\n「アクセストークンの発行」を選びます\n「アカウントの情報を見る」をONにします\n表示された「確認コード」の中身をメモしておきます",
            "今メモした「確認コード」がいわゆるAPIトークンであり、アカウントにアクセスする許可証の役割を果たします\nこれが漏れると、アカウントを乗っ取られるなどの危険があります\n他人に教えたり、不特定多数の目に触れることのないよう管理してください\nまた、このソフトに設定したトークンはこのソフトのディレクトリ直下のtoken.txtに保存しています(このファイルを公開しないように注意してください)",
            "APIトークンは、このソフトのメインメニューにある「APIトークンの入力」欄に入れ、「確定」ボタンを押すことで使用できるようになります",
            "ノートファイルを使用する場合、事前に準備をします\n分析したいアカウントでMisskeyサーバーのページを開き、設定→その他の設定の「インポートとエクスポート」という項目を開きます\n「全てのノート」から「エクスポート」を選択します\nドライブを開きます\nnote-(日付).jsonと書かれたファイルが生成されるので、選択してダウンロードします(ファイルが生成されるまで時間がかかることもあります)",
            "ダウンロードしたノートファイルを、このソフトのメインメニューの「ファイル入力」ボタンで選択します",
            "トークンかファイルのどちらかが設定できたら、～日間を分析のところから分析したい日数を設定します(APIを使用する場合、あまりに長いとサーバーへの負荷になる可能性があります)\n現在の日付から指定した日数分だけ前の日付までを分析対象とします\nその後、分析開始を押します、分析には数分かかったりします\n分析中、長すぎるノートがあるとエラーメッセージが出ますが続行して構いません(該当ノートはニュートラルとしてカウントされます)\n分析が終わった後、分析結果からその内容が確認できます",
            "分析中は結果をいくつかサンプリングしてログを表示しています\nネガティブの判定について、精度が悪いと思った場合はsetting.jsonを開いてnegativeFilter>activateをいじることでフィルターを有効化することができます(細かくはsetting.jsonのコメントに書いてあります)\nそれ以上は分析モデルを自作するか諦めてください、開発者はネタノートをよくするので誤検知されまくります",
            "指定したサーバーのMisskeyAPIを使用する以外に、このソフトで収集した情報が外部に送信されることはありません\nこのソフトのコードはMITライセンスとして開発者のGitHubリポジトリ(https://github.com/PotatoTimeKun/programming)に公開します\nエラー報告などは開発者のすしすき－アカウント(https://sushi.ski/@potatokun)に連絡ください"
        ]
        self._image = [
            tk.PhotoImage(file="./asset/MAMH_logo.png"),
            tk.PhotoImage(file="./asset/server.png"),
            None,
            tk.PhotoImage(file="./asset/gen_token.png"),
            None,
            None,
            tk.PhotoImage(file="./asset/export_note.png"),
            None,
            None,
            None,
            None
        ]
        self._widget = {
            "titleLabel" : tk.Label(text="",bg="#ffffff",font=('Times New Roman',20)),
            "explaneLabel" : tk.Label(text="",bg="#ffffff",wraplength=780,anchor='e',justify='left',font=('Times New Roman',16)),
            "imageCanvas" : tk.Canvas(window,width=780,height=180,bg="#ffffff"),
            "backButton" : tk.Button(text="戻る",command=self.returnMenuButton,width=15,height=1,font=('Times New Roman',12)),
            "pageLabel" : tk.Label(text="",bg="#ffffff",font=('Times New Roman',16)),
            "previousButton" : tk.Button(text="前のページ",command=self.previousButtonFunc,width=15,height=1,font=('Times New Roman',12)),
            "nextButton" : tk.Button(text="次のページ",command=self.nextButtonFunc,width=15,height=1,font=('Times New Roman',12))
        }

    def initialize(self):
        """
        設計名:初期化
        ページを0に設定
        """
        self._page = 0

    def show(self):
        """
        設計名:表示
        画面の消去と指定したページ内容の表示
        """
        #画面をクリア
        self._widget["imageCanvas"].delete("image")
        for k in self._widget.keys():
            self._widget[k].place_forget()
        #ページ内容を設定
        self._widget["pageLabel"]["text"]=f"{self._page+1}/{len(self._title)}"
        self._widget["titleLabel"]["text"]=self._title[self._page]
        self._widget["explaneLabel"]["text"]=self._explane[self._page]
        self._widget["imageCanvas"].create_image(780/2,180/2,image=self._image[self._page],tag="image")
        #ウィジェットを配置
        self._widget["titleLabel"].place(x=10,y=10)
        self._widget["imageCanvas"].place(x=10,y=50)
        self._widget["explaneLabel"].place(x=10,y=260)
        self._widget["backButton"].place(x=10,y=560)
        self._widget["previousButton"].place(x=300,y=560)
        self._widget["nextButton"].place(x=600,y=560)
        self._widget["pageLabel"].place(x=500,y=565)

    def _returnMenu(self):
        """
        設計名:戻る
        画面の消去と遷移元の表示
        """
        self._widget["imageCanvas"].delete("image")
        for k in self._widget.keys():
            self._widget[k].place_forget()
        self._referrer.show()

    def returnMenuButton(self):
        """
        設計名:戻るボタン処理
        """
        self._returnMenu()

    def _previousPage(self):
        """
        設計名:前のページ
        """
        self._page-=1
        if(self._page<0):
            self._page = len(self._title)-1

    def _nextPage(self):
        """
        設計名:次のページ
        """
        self._page+=1
        if(self._page>len(self._title)-1):
            self._page = 0

    def previousButtonFunc(self):
        """
        設計名:前のページボタン処理
        """
        self._previousPage()
        self.show()

    def nextButtonFunc(self):
        """
        設計名:次のページボタン処理
        """
        self._nextPage()
        self.show()
        


class ResultUi(SubUi):
    def __init__(self,window,referrer):
        self._window = window
        self._referrer = referrer
        self._title = [
            "ノート全体",
            "時間帯",
            "曜日",
            "時系列",
            "詳細",
            "その他"
        ]
        self._explane = [
            "読み込んだすべてのノートのポジティブ/ニュートラル/ネガティブの割合を示します",
            "",
            "",
            "時系列で日毎のノートのポジティブ/ニュートラル/ネガティブの割合を示します\n右に行くほど現在の日付に近くなります",
            "ネガティブなノートがoffensive(攻撃的)かdowner(ダウナー)かを示します",
            ""
        ]
        self._graph = plt.Figure(figsize=(8, 4))
        self._ax = self._graph.add_subplot()
        self._widget = {
            "titleLabel" : tk.Label(text="",bg="#ffffff",font=('Times New Roman',20)),
            "explaneLabel" : tk.Label(text="",bg="#ffffff",wraplength=780,anchor='e',justify='left',font=('Times New Roman',16)),
            "frame" : tk.Frame(width=780,height=380),
            "canvas" : None,
            "backButton" : tk.Button(text="戻る",command=self.returnMenuButton,width=15,height=1,font=('Times New Roman',12)),
            "pageLabel" : tk.Label(text="",bg="#ffffff",font=('Times New Roman',16)),
            "previousButton" : tk.Button(text="前のページ",command=self.previousButtonFunc,width=15,height=1,font=('Times New Roman',12)),
            "nextButton" : tk.Button(text="次のページ",command=self.nextButtonFunc,width=15,height=1,font=('Times New Roman',12))
        }
        self._widget["canvas"] = FigureCanvasTkAgg(self._graph, master=self._widget["frame"])
        self._widget["canvas"].get_tk_widget().pack()

        
    def initialize(self):
        """
        設計名:初期化
        ページを0に設定
        """
        self._page = 0
    
    def resultSet(self,result: dict):
        """
        設計名:分析結果セット
        """
        self._result = result

    def show(self):
        """
        設計名:表示
        画面の消去と指定したページ内容の表示
        """
        #画面をクリア
        if(self._widget["canvas"]!=None):
            self._ax.clear()
        for k in self._widget.keys():
            if(k=="canvas"):
                continue
            self._widget[k].place_forget()
        #ページ内容を設定
        self._widget["pageLabel"]["text"]=f"{self._page+1}/{len(self._title)}"
        self._widget["titleLabel"]["text"]=self._title[self._page]
        if(self._page==0):
            self._ax.pie([self._result["posiCount"],self._result["neutCount"],self._result["negaCount"]],labels=["positive","neutral","negative"])
        elif(self._page==1):
            self._ax.bar(list(range(0,24)),self._result["timeBase"]["posiPerNote"],label="positive")
            self._ax.bar(list(range(0,24)),self._result["timeBase"]["neutPerNote"],bottom=self._result["timeBase"]["posiPerNote"],label="neutral")
            self._ax.bar(list(range(0,24)),self._result["timeBase"]["negaPerNote"],bottom=[i+j for i, j in zip(self._result["timeBase"]["posiPerNote"], self._result["timeBase"]["neutPerNote"])],label="negative")
            self._ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.1), ncol=3,borderaxespad=4)
            self._explane[self._page] = f"時間帯毎のノートに対するポジティブ/ニュートラル/ネガティブの割合を示します\n{self._result['timeBase']['maxNega']}～{self._result['timeBase']['maxNega']+1}時にネガティブが多いです"
            self._ax.set_ylim([0, 1])
            self._ax.set_aspect(2*24/7)
        elif(self._page==2):
            weekday = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
            japaneaseWeekday = "月火水木金土日"
            self._ax.bar(weekday,self._result["weekBase"]["posiPerNote"],label="positive")
            self._ax.bar(weekday,self._result["weekBase"]["neutPerNote"],bottom=self._result["weekBase"]["posiPerNote"],label="neutral")
            self._ax.bar(weekday,self._result["weekBase"]["negaPerNote"],bottom=[i+j for i, j in zip(self._result["weekBase"]["posiPerNote"], self._result["weekBase"]["neutPerNote"])],label="negative")
            self._ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.1), ncol=3,borderaxespad=4)
            self._explane[self._page] = f"曜日毎のノートに対するポジティブ/ニュートラル/ネガティブの割合を示します\n{japaneaseWeekday[self._result['weekBase']['maxNega']]}曜日にネガティブが多いです"
            self._ax.set_ylim([0, 1])
            self._ax.set_aspect(2)
        elif(self._page==3):
            self._ax.plot(list(range(0,self._result["range"])),self._result["timeSeries"]["posiPerNote"],label="positive")
            self._ax.plot(list(range(0,self._result["range"])),self._result["timeSeries"]["neutPerNote"],label="neutral")
            self._ax.plot(list(range(0,self._result["range"])),self._result["timeSeries"]["negaPerNote"],label="negative")
            self._ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.1), ncol=3,borderaxespad=4)
            self._ax.set_ylim([0, 1])
            self._ax.set_aspect(2*self._result["range"]/7)
        elif(self._page==4):
            self._ax.pie([self._result["detail"]["offensive"],self._result["detail"]["downer"]],labels=["offensive","downer"])
        self._widget["explaneLabel"]["text"]=self._explane[self._page]
        #ウィジェットを配置
        self._widget["titleLabel"].place(x=10,y=10)
        if(self._page!=5):
            self._widget["frame"].place(x=10,y=50)
            self._widget["explaneLabel"].place(x=10,y=450)
            self._widget["canvas"].draw()
        else:
            minTime=self._result['timeBase']['negaPerNote'].index(min(self._result['timeBase']['negaPerNote']))
            minTimePer=round(100*self._result["timeBase"]["negaPerNote"][minTime])
            maxTime=self._result['timeBase']['maxNega']
            maxTimePer=round(100*self._result["timeBase"]["negaPerNote"][maxTime])
            minWeek=self._result['weekBase']['negaPerNote'].index(min(self._result['weekBase']['negaPerNote']))
            minWeekPer=round(100*self._result["weekBase"]["negaPerNote"][minWeek])
            maxWeek=self._result['weekBase']['maxNega']
            maxWeekPer=round(100*self._result["weekBase"]["negaPerNote"][maxWeek])
            japaneaseWeekday = "月火水木金土日"
            self._widget["explaneLabel"]["text"]=f"""分析したノート:{self._result['noteCount']}ノート\n一番ネガティブの少ない時間帯:{minTime}～{minTime+1}({minTimePer}%)\n一番ネガティブの多い時間帯:{maxTime}～{maxTime+1}({maxTimePer}%)\n一番ネガティブの少ない曜日:{japaneaseWeekday[minWeek]}({minWeekPer}%)\n一番ネガティブの多い時間帯:{japaneaseWeekday[maxWeek]}({maxWeekPer}%)"""
            self._widget["explaneLabel"].place(x=10,y=50)
        self._widget["backButton"].place(x=10,y=560)
        self._widget["previousButton"].place(x=300,y=560)
        self._widget["nextButton"].place(x=600,y=560)
        self._widget["pageLabel"].place(x=500,y=565)
        
    def _returnMenu(self):
        """
        設計名:戻る
        画面の消去と遷移元の表示
        """
        for k in self._widget.keys():
            if(k=="canvas"):
                continue
            self._widget[k].place_forget()
        self._referrer.show()

    def returnMenuButton(self):
        """
        設計名:戻るボタン処理
        """
        self._returnMenu()

    def _previousPage(self):
        """
        設計名:前のページ
        """
        self._page-=1
        if(self._page<0):
            self._page = len(self._title)-1

    def _nextPage(self):
        """
        設計名:次のページ
        """
        self._page+=1
        if(self._page>len(self._title)-1):
            self._page = 0

    def previousButtonFunc(self):
        """
        設計名:前のページボタン処理
        """
        self._previousPage()
        self.show()

    def nextButtonFunc(self):
        """
        設計名:次のページボタン処理
        """
        self._nextPage()
        self.show()