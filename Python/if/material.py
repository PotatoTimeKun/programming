import tkinter as tk
from tkinter import filedialog
import json

titleTxt=["a==b","(a nand b)nand(a nand b)","a%3==b%3","a and b","not a and b or a and not b","a*a+b*b<9","by PotatoTime"]

trueStr=["True","true","T","t","1"]
falseStr=["False","false","F","f","0"]
def decB(a):
    if a in trueStr:
        return True
    if a in falseStr:
        return False
    return "error"

def f1_1(a,b):
    A=decB(a)
    B=decB(b)
    if(A=="error" or B=="error"):
        return "error"
    return A and B

def f1_2(a,b):
    A=decB(a)
    B=decB(b)
    if(A=="error" or B=="error"):
        return "error"
    return A != B

def f1_3(a,b):
    A=decB(a)
    B=decB(b)
    if(A=="error" or B=="error"):
        return "error"
    return not A

def f1_4(a,b):
    A=decB(a)
    B=decB(b)
    if(A=="error" or B=="error"):
        return "error"
    return A == B

def f1_5(a,b):
    A=decB(a)
    B=decB(b)
    if(A=="error" or B=="error"):
        return "error"
    return not(A != B)

def f1_6(a):
    A=decB(a)
    if(A=="error"):
        return "error"
    return not(A and A)

def f1_7(a):
    A=decB(a)
    if(A=="error"):
        return "error"
    return A != A

def f1_8(a,b,c):
    A=decB(a)
    B=decB(b)
    C=decB(c)
    if(A=="error" or B=="error" or C=="error"):
        return "error"
    return A != (B != C)

def f1_9(a,b):
    A=decB(a)
    B=decB(b)
    if(A=="error" or B=="error"):
        return "error"
    return A or B

def f1_10(a,b):
    A=decB(a)
    B=decB(b)
    if(A=="error" or B=="error"):
        return "error"
    return A or B

def f1_11(a):
    A=decB(a)
    if(A=="error"):
        return "error"
    return True

def f1_12(a,b,c):
    A=decB(a)
    B=decB(b)
    C=decB(c)
    if(A=="error" or B=="error" or C=="error"):
        return "error"
    return (A and B) or C

def f1_13(a,b):
    A=decB(a)
    B=decB(b)
    if(A=="error" or B=="error"):
        return "error"
    return (not B) and A

def f1_14(a,b,c):
    A=decB(a)
    B=decB(b)
    C=decB(c)
    if(A=="error" or B=="error" or C=="error"):
        return "error"
    return A==B and A!=C

def f1_15(a,b,c):
    A=decB(a)
    B=decB(b)
    C=decB(c)
    if(A=="error" or B=="error" or C=="error"):
        return "error"
    return (A==B)==C

def decI(a):
    A=0
    try:
        A=int(a)
    except:
        A="error"
    return A

def f2_1(a,b):
    A=decI(a)
    B=decI(b)
    if(A=="error" or B=="error"):
        return "error"
    return A<B

def f2_2(a,b):
    A=decI(a)
    B=decI(b)
    if(A=="error" or B=="error"):
        return "error"
    if(A<0 or B<0):
        return "error"
    return A%2==0

def f2_3(a,b):
    A=decI(a)
    B=decI(b)
    if(A=="error" or B=="error"):
        return "error"
    return A==B*B

def f2_4(a):
    A=decI(a)
    if(A=="error"):
        return "error"
    if(A<0):
        return "error"
    return A==A*(A//2)

def f2_5(a):
    A=decI(a)
    if(A=="error"):
        return "error"
    return 0<A and A<10

def f2_6(a,b):
    A=decI(a)
    B=decI(b)
    if(A=="error" or B=="error"):
        return "error"
    if(A<=0 or B<=0):
        return "error"
    return A%B==0

def f2_7(a):
    A=decI(a)
    if(A=="error"):
        return "error"
    return -A==A

def f2_8(a,b):
    A=decI(a)
    B=decI(b)
    if(A=="error" or B=="error"):
        return "error"
    return A-1<B

def f2_9(a,b):
    A=decI(a)
    B=decI(b)
    if(A=="error" or B=="error"):
        return "error"
    return A-B>=-1 and A-B<=1

def f2_10(a,b):
    A=decI(a)
    B=decI(b)
    if(A=="error" or B=="error"):
        return "error"
    return (A-B)*(A-B)<=1

def f2_11(a,b,c):
    A=decI(a)
    B=decI(b)
    C=decI(c)
    if(A=="error" or B=="error" or C=="error"):
        return "error"
    return B*B-4*A*C>0

def f2_12(a,b,c,d):
    A=decI(a)
    B=decI(b)
    C=decI(c)
    D=decI(d)
    if(A=="error" or B=="error" or C=="error" or D=="error"):
        return "error"
    return A*D-B*C!=0

def f2_13(a,b,c):
    A=decI(a)
    B=decI(b)
    C=decI(c)
    if(A=="error" or B=="error" or C=="error"):
        return "error"
    return A*A+B*B<C*C

def f2_14(a,b):
    A=decI(a)
    B=decI(b)
    if(A=="error" or B=="error"):
        return "error"
    if(not(A in [0,1]) or not(B in [0,1])):
        return "error"
    return A+B==1

def f2_15(a,b):
    A=decI(a)
    B=decI(b)
    if(A=="error" or B=="error"):
        return "error"
    if(A<=0 or B<=0):
        return "error"
    return A//B==0

def f3_1(a):
    return len(a)==1

def f3_2(a,b):
    return a==b

def f3_3(a,b):
    try:
        return (a[0]!=b[0])!=(a[1]!=b[1])
    except:
        return "error"

def f3_4(a,b):
    try:
        return a[len(a)-1]==b[len(b)-1]
    except:
        return "error"

stage=[
    [
        {"que":"f(a,b)=?","inp":2,"ans":["aandb","banda"],"len":3,"sel":["a","b","and","or","xor"],"hint":"Escでステージ選択に戻ってゲーム説明を見てみよう","fun":f1_1,"txt":"こんな感じのゲームだよ"},
        {"que":"f(a,b)=?","inp":2,"ans":["axorb","bxora"],"len":3,"sel":["a","b","and","or","xor"],"hint":"Escでステージ選択に戻ってゲーム説明を見てみよう","fun":f1_2,"txt":"xor演算子はあまり実装されてないことも多い"},
        {"que":"f(a,b)=?","inp":2,"ans":["nota"],"len":2,"sel":["a","b","not","or","and"],"hint":"文字数からして演算子1つ、文字1つ","fun":f1_3,"txt":"bは要らないね"},
        {"que":"f(a,b)=?","inp":2,"ans":["a==b","b==a"],"len":3,"sel":["a","b","==","!=","xor","and"],"hint":"とりあえず全パターン見てみよう","fun":f1_4,"txt":"あんまbool型で==使わないけどね"},
        {"que":"f(a,b)=?","inp":2,"ans":["not(axorb)","not(bxora)"],"len":6,"sel":["a","b","(",")","not","==","xor","and","or"],"hint":"動きは前ステージと同じ","fun":f1_5,"txt":"xorを否定してるから結局はこれはxnor"},
        {"que":"f(a)=?","inp":1,"ans":["ananda"],"len":3,"sel":["a","==","!=","nand","xnor"],"hint":"a演算子aの形を取る","fun":f1_6,"txt":"nandでand,or,notのすべてを表現できる"},
        {"que":"f(a)=?","inp":1,"ans":["axora"],"len":3,"sel":["a","==","and","xor","nand","xnor"],"hint":"a演算子aの形を取る","fun":f1_7,"txt":"Pythonだとxorないから!=使ってる"},
        {"que":"f(a,b,c)=?","inp":3,"ans":["axorbxorc","axorcxorb","bxoraxorc","bxorcxora","cxoraxorb","cxorbxora"],"len":5,"sel":["a","b","c","and","xor","nand","xnor"],"hint":"文字3つ、演算子2つ","fun":f1_8,"txt":"記号の順番関係ないから全パターンの答えを登録しないといけないw"},
        {"que":"f(a,b)=?","inp":2,"ans":["(ananda)nand(bnandb)","(bnandb)nand(ananda)"],"len":11,"sel":["a","b","(",")","or","and","xor","nand","xnor"],"hint":"演算子は1種類しか使わない","fun":f1_9,"txt":"ド・モルガンの公式必須かもしれん"},
        {"que":"f(a,b)=?","inp":2,"ans":["(anorb)nor(anorb)","(anorb)nor(bnora)","(bnora)nor(anorb)","(bnora)nor(bonra)"],"len":11,"sel":["a","b","(",")","not","and","xor","nor","xnor"],"hint":"大体前ステージと同じ","fun":f1_10,"txt":"norでもnot,and,orを表現できる"},
        {"que":"f(a)=?","inp":1,"ans":["notaora","aornota"],"len":4,"sel":["a","not","and","or","nor","xnor"],"hint":"文字数的にnotは使わないといけない","fun":f1_11,"txt":"集合で考えると当たり前だなって感じるかも"},
        {"que":"f(a,b,c)=?","inp":3,"ans":["aandborc","bandaorc","coranandb","corbanda"],"len":5,"sel":["a","b","c","not","and","or","nor","nand","xnor"],"hint":"文字3つ、演算子2つ","fun":f1_12,"txt":"全8パターンになるから調べるのがめんどいかもな("},
        {"que":"f(a,b)=?","inp":2,"ans":["aandnotb","notbanda"],"len":4,"sel":["a","b","not","or","and","xor","nand","xnor"],"hint":"そのまんま","fun":f1_13,"txt":"そのまんまだね"},
        {"que":"f(a,b,c)=?","inp":3,"ans":["a==banda!=c","a!=canda==b","b==aanda!=c","c!=aanda==b","b==aandc!=a","c!=aandb==a","a==bandc!=a","a!=candb==a"],"len":7,"sel":["a","b","c","not","and","or","nand","!=","=="],"hint":"文字3つ、演算子2つ","fun":f1_14,"txt":"これ解きたくないね()"},
        {"que":"f(a,b,c)=?","inp":3,"ans":["axnorbxnorc","axnorcxnorb","bxnoraxnorc","bxnorcxnora","cxnoraxnorb","cxnorbxnora"],"len":5,"sel":["a","b","c","not","and","or","nor","nand","xnor"],"hint":"文字3つ、演算子2つ","fun":f1_15,"txt":"xorの問題のxnor版"}
    ],
    [
        {"que":"f(a,b)=?","inp":2,"ans":["a<b"],"len":3,"sel":["a","b","==","<","<="],"hint":"Escでステージ選択に戻ってゲーム説明を見てみよう","fun":f2_1,"txt":"int型になると全パターンの走査は難しい"},
        {"que":"f(a,b)=?\n ただしa>=0,b>=0","inp":2,"ans":["a%2==0","0==a%2"],"len":5,"sel":["a","b","+","*","%","==","0","1","2"],"hint":"bはほんとに関係ある?","fun":f2_2,"txt":"ここに書くことなくなってきた()"},
        {"que":"f(a,b)=?","inp":2,"ans":["a==b*b"],"len":5,"sel":["a","b","+","*","/","==","<","3"],"hint":"Trueの例:(a,b)=(1,1),(4,2),(9,3)","fun":f2_3,"txt":"ライスを...スライスw"},
        {"que":"f(a)=?\n ただしa>=0","inp":1,"ans":["a==a*(a/2)","a==(a/2)*a","a*(a/2)==a","(a/2)*a==a"],"len":9,"sel":["a","*","/","==","2","(",")"],"hint":"示した記号すべてを使う","fun":f2_4,"txt":"int型の割り算はほんと注意"},
        {"que":"f(a)=?","inp":1,"ans":["0<aanda<10","a<10anda<0"],"len":7,"sel":["a","+","==","<","0","10","and","or"],"hint":"一定の範囲でTrueになっている","fun":f2_5,"txt":"「A」だけで会話する、これがほんとの英会話ってかw"},
        {"que":"f(a,b)=?\n ただしa>=,b>0","inp":2,"ans":["a%b==0","0==a%b"],"len":5,"sel":["a","b","/","*","%","==","0","1","2"],"hint":"Trueの例:(a,b)=(2,2),(4,2),(6,2),(3,3),(6,3),(9,3)","fun":f2_6,"txt":"Pythonサイコ－！"},
        {"que":"f(a)=?","inp":1,"ans":["-a==a","a==-a"],"len":4,"sel":["a","-","+","*","%","=="],"hint":"Trueになるのはaが0のときのみ","fun":f2_7,"txt":"-1をかけても変わらない数は0、数学でたまに使う"},
        {"que":"f(a,b)=?","inp":2,"ans":["a-1<b"],"len":5,"sel":["a","b","-","*","==","<","1"],"hint":"動きとしてはa<=bと同じ","fun":f2_8,"txt":"int型だから、できたこと"},
        {"que":"f(a,b)=?","inp":2,"ans":["a-b<=1and-1<=a-b","-1<=a-banda-b<=1"],"len":11,"sel":["a","b","-","*","/","and","<=","1","-1"],"hint":"差が関係している","fun":f2_9,"txt":"普通はabs(a-b)<=1とかかも"},
        {"que":"f(a,b)=?","inp":2,"ans":["(a-b)*(a-b)<=1","(b-a)*(b-a)<=1"],"len":13,"sel":["a","b","-","*","(",")","<=","1"],"hint":"動きは前のステージと同じ","fun":f2_10,"txt":"2乗した整数は負でない"},
        {"que":"f(a,b,c)=?","inp":3,"ans":["b*b-4*a*c>0"],"len":11,"sel":["b","*","b","-","4","a","c",">",">=","0"],"hint":"2次方程式に関係する","fun":f2_11,"txt":"解の公式覚えたよね－"},
        {"que":"f(a,b,c,d)=?","inp":4,"ans":["a*d-b*c!=0"],"len":9,"sel":["a","b","c","d","+","*","-","!=","==","0"],"hint":"2次正方行列に関係する","fun":f2_12,"txt":"2次正方行列が正則である条件"},
        {"que":"f(x,y,r)=?","inp":3,"ans":["x*x+y*y<r*r"],"len":11,"sel":["x","y","r","+","-","*","<","<=","0"],"hint":"円に関係する","fun":f2_13,"txt":"円の内部にある条件"},
        {"que":"f(a,b)=?\n ただしa,bは0または1","inp":2,"ans":["a+b==1","1==a+b","b+a==1","1==b+a"],"len":5,"sel":["a","b","-","+","*","==","0","1","2"],"hint":"xorのような動きをする","fun":f2_14,"txt":"xorは⊕とも書く"},
        {"que":"f(a,b)=?\n ただしa>0,b>0","inp":2,"ans":["a/b==0","0==a/b"],"len":5,"sel":["a","b","-","+","*","/","==","0","1","2"],"hint":"a<bと動きは同じ","fun":f2_15,"txt":"int型だから、できたこと(2回目)"}
    ],
    [
        {"que":"f(a)=?","inp":1,"ans":["a.len==1"],"len":4,"sel":["a",".len","==","<","<=","0","1"],"hint":"Escでステージ選択に戻ってゲーム説明を見てみよう","fun":f3_1,"txt":"str型の問題あんま作れないなって気づいた"},
        {"que":"f(a,b)=?","inp":2,"ans":["a==b","b==a"],"len":3,"sel":["a","b","=="],"hint":"馬がヒントを言ってくれるらしい、ヒヒ～ンとw","fun":f3_2,"txt":"Twitter@potatotimekun"},
        {"que":"f(a,b)=?\n ただしa,bは2文字","inp":2,"ans":["a[0]!=b[0]xora[1]!=b[1]","a[1]!=b[1]xora[0]!=b[0]","b[0]!=a[0]xorb[1]!=a[1]","b[1]!=a[1]xorb[0]!=a[0]"],"len":11,"sel":["a","b","==","!=","or","xor","[0]","[1]"],"hint":"違う文字が1つだけあるとき","fun":f3_3,"txt":"ラーメン食いたい"},
        {"que":"f(a,b)=?","inp":2,"ans":["a[a.len-1]==b[b.len-1]","b[b.len-1]==a[a.len-1]"],"len":15,"sel":["a","b",".len","-","==","[","]","1"],"hint":"最後の文字が同じときTrue","fun":f3_4,"txt":"ここまでやってくれてありがと！おまけステージもよろしくね"}
    ],
    [
        {"que":"このゲームの作者は?","inp":0,"ans":["ポテト君"],"len":4,"sel":["君","ポ","ア","テ","ン","ト"],"hint":"分からない?どこからダウンロードしたの?()","txt":"正確にはポテトタイム君"},
        {"que":"∫[-∞→∞]exp(-x^2)dx=?","inp":0,"ans":["√π"],"len":2,"sel":["√","exp","π","2"],"hint":"ガウス積分でググってみよう","txt":"ガウスの髪が薄"},
        {"que":"梨が5つ並んだ料理","inp":0,"ans":["ナシゴレン"],"len":5,"sel":["ン","ナ","コ","シ","ゴ","タ","レ"],"hint":"いやこれはなぞなぞw","txt":"言っといてこの料理よく知らん"},
        {"que":"%を表す数学的な演算子","inp":0,"ans":["mod"],"len":3,"sel":["a","d","o","c","e","m","s"],"hint":"まあ...知ってるかどうか","txt":"ゲームのMODも好き"},
        {"que":"鳥を止める使命がある日用品","inp":0,"ans":["トリ－トメント"],"len":7,"sel":["メ","ン","リ","テ","－","ト"],"hint":"トが3回出てくる","txt":"上手いと思う()"},
        {"que":"有理数で1,無理数で0になる関数を何関数というか","inp":0,"ans":["ディリクレ"],"len":5,"sel":["ィ","デ","サ","テ","リ","レ","オ","ク"],"hint":"くれ～","txt":"グラフ描くと直線が2個に見える"},
        {"que":"震えている犬","inp":0,"ans":["ブルドッグ"],"len":5,"sel":["ッ","ブ","ア","グ","ド","二","プ","ル","イ"],"hint":"ブルブル...","txt":"いやそれ、ブルブルドッグやんw"},
        {"que":"複数サイトにまたがって、罠のあるリンクを\nしかけた脆弱性のあるサイトでスクリプトを\n実行させる攻撃","inp":0,"ans":["クロスサイトスクリプティング"],"len":14,"sel":["グ","ア","テ","ィ","ロ","ク","サ","イ","ス","ン","リ","プ","ト"],"hint":"サイトをクロスするスクリプト","txt":"クロスサイトリクエストフォージェリとかもある"},
        {"que":"微分積分","inp":0,"ans":["いい気分"],"len":4,"sel":["い","い","気","分"],"hint":"最高","txt":"いい気分やろ?"},
        {"que":"チャンネル登録した?","inp":0,"ans":["はい"],"len":2,"sel":["は","い"],"hint":"ホームページ見たよね?","txt":"しろ！()"}
    ]
]

stageTitle=["bool型","int型","str型","おまけ"]

helpTxt="""演算子は優先度が高い順に左から適用する
演算子の優先度
↑高い
not,(,),[,],.len
and,nand
xor,xnor
or,nor
==,!=
<,>,<=,>=
-(負値を表す)
*,/
%
+,-(二項演算子として)
↓低い

正しいことをTrue、間違えていることをFalseという(この二つを合わせてbool型のデータという)
bool型を扱う演算子
・not 否定を表す(not TrueはFalse、not FalseはTrue)
・and どちらも正しいときのみ正しい(True and True=True)
・or 少なくとも一方が正しければ正しい(True or False=True)
・xor どちらか片方のみが正しい(True xor False=True,True xor True=False)
・nand,nor,xnor それぞれand,or,xorを否定したもの(a nand b=not (a and b))

int型(=整数)を扱う演算子
・<,> 小なり、大なり→bool値を返す
・<=,>= 小なりイコール、大なりイコール→bool値を返す
・+,-,*,/ 四則演算
・% 剰余(割った余り)

str型(=文字列)を扱う演算子
・.len 文字数→int値を返す
・[n] n(int型)文字目(0から数える)の文字→str値を返す

型に関わらず使える演算子
・== 同値
・!= 同値でない"""

achieveTitle=["ありがとう！","boolマスタ－","intマスター","strマスター","おまけマスター","王者","気まぐれ"]
achieveTxt=["初めてこのゲームをプレイする","bool型の問題をすべてクリアする","int型の問題をすべてクリアする","str型の問題をすべてクリアする","おまけ問題をすべてクリアする","すべての問題をクリアする","なんとなく実績あげちゃう"]

def text(canvas, x, y, string, colors, size,tag="show"):
    """文字列の表示"""
    canvas.create_text(x, y, text=string, fill=colors, font=(
        "Yu Gothic UI Semilight", size), tag=tag)

def scrText( x, y,width ,height ,string):
    """文字列の表示"""
    scr=tk.Scrollbar(orient="vertical")
    txt=tk.Text(background="white",yscrollcommand=scr.set)
    txt.place(x=x,y=y,width=width,height=height)
    scr["command"]=txt.yview
    scr.place(x=x+width+5,y=y,height=height)
    txt.insert(tk.END,string)
    txt.config(state="disabled")
    return [txt,scr]

def jsonSave(data):
    file = filedialog.asksaveasfilename(
        filetypes=[("jsonファイル", "*.json")], initialdir=".\\")
    try:
        file.index(".json")
    except:
        file += ".json"
    opened = open(file, "w")
    json.dump(data, opened)
    opened.close()


def jsonGet(filename=""):
    if(filename == ""):
        filename = filedialog.askopenfilename(
            filetypes=[("jsonファイル", "*.json")], initialdir=".\\")
    opened = open(filename, "r")
    return json.load(opened)