from email.mime import image
from math import cos, pi, sin
import tkinter as tk
from time import time
from random import choice
from random import randint as rnd
import os
import pathlib as pl
w=tk.Tk()
c=tk.Canvas(w,width=1100,height=700,bg="#FFE1F2")
c.pack()
pressed=[]
"""クリックしたマスを1,クリックして得点に加点済みのマスを2,何もないマスを0とする"""
table=[]
"""文字を並べたテーブル、2次元リストとする"""
nowPress=False
"""クリックしたかどうか(瞬時)"""
nowRelease=True
"""クリックしていないかどうか"""
mouseX=0
"""マウスのx座標"""
mouseY=0
"""マウスのy座標"""
key=0
"""押したキー"""
index=0
"""main関数のインデックス"""
point=0
"""現在のポイント"""
timer=0
"""約0.1秒ごとに約1足す"""
fontList=["New Times Roman","メイリオ","MS 明朝","Yu Gothic UI Semibold"]
"""フォントのリスト(現在のフォントは含まない)"""
font="Yu Gothic UI Semilight"
""""現在のフォント"""
def getHigh():
    """ハイスコアの取得"""
    if os.path.exists('C:\\findoolong\\high.txt'):
        with open('C:\\findoolong\\high.txt','r')as r:
            return int(r.read())
    else:
        pl.Path('C:\\findoolong').mkdir()
        with open('C:\\findoolong\\high.txt','x')as t:
            t.write('0')
        return 0
def setHigh(point):
    """渡したポイントをハイスコアかどうか確認して設定し、ハイスコアとして設定されたものを返す"""
    nowHigh=getHigh()
    if(nowHigh<point):
        with open('C:\\findoolong\\high.txt','w')as tx:
            tx.write(str(point))
        return point
    return nowHigh
def text(x,y,string,colors,size):
    """文字列の表示"""
    global c,font
    c.create_text(x,y,text=string,fill=colors,font=(font,size),tag="texts")
def shadowText(x,y,string,colorF,colorB,size):
    """影あり文字列の表示"""
    text(x+1,y+1,string,colorB,size)
    text(x,y,string,colorF,size)
def delText():
    """文字列の非表示"""
    global c
    c.delete("texts")
def putoo():
    """テーブルのランダムな位置にウーロンを置く"""
    global table
    if rnd(0,1)==0:
        x=rnd(0,8)
        y=rnd(0,11)
        i=0
        for c in "ウーロン":
            table[x+i][y]=c
            i+=1
    else:
        x=rnd(0,11)
        y=rnd(0,8)
        i=0
        for c in "ウーロン":
            table[x][y+i]=c
            i+=1
def makeTable():
    """テーブルの初期化"""
    global table,pressed
    table=[[],[],[],[],[],[],[],[],[],[],[],[]]
    pressed=[[],[],[],[],[],[],[],[],[],[],[],[]]
    for i in range(12):
        for j in range(12):
            table[i].append(choice(['ウ','ー','ロ','ン','ソ']))
            pressed[i].append(0)
    putoo()
    putoo()
def pointCheck():
    """ポイントを加算し、加算済みのpressedリストのマスを2と置き換える"""
    global table,pressed,point
    for i in range(12):
        for j in range(9):
            if pressed[i][j:j+4]==[1,1,1,1]:
                if table[i][j:j+4]==['ウ','ー','ロ','ン']:
                    point+=1
                    for k in range(0,4):
                        pressed[i][j+k]=2
            if [k[i] for k in pressed[j:j+4]]==[1,1,1,1]:
                if [k[i] for k in table[j:j+4]]==['ウ','ー','ロ','ン']:
                    point+=1
                    for k in range(0,4):
                        pressed[j+k][i]=2
def showTable():
    """テーブルの表示"""
    global table,pressed,c
    for x in range(12):
        for y in range(12):
            if pressed[x][y]==0:
                c.create_rectangle(50+50*x,50+50*y,100+50*x,100+50*y,fill="white",outline='#888',width=2,tag='table')
                text(75+50*x,75+50*y,str(table[x][y]),"black",30)
            else:
                c.create_rectangle(50+50*x,50+50*y,100+50*x,100+50*y,fill="red",outline='#888',width=2,tag='table')
                text(75+50*x,75+50*y,str(table[x][y]),"white",30)
def delTable():
    """テーブルの非表示"""
    global c
    c.delete("table")
def press(e): # クリックしたらnowPressをTrueに、nowReleaseをFalseに
    global nowPress,nowRelease
    nowRelease=False
    nowPress=True
def release(e): # マウスボタンを離したらnowReleaseをTrueに
    global nowRelease
    nowRelease=True
def mouseMove(e): # マウスを動かしたら座標をmouseX,mouseYに代入
    global mouseX,mouseY
    mouseX,mouseY=e.x,e.y
def keyDown(e): # キーを押したらkey変数に代入
    global key
    key=e.keysym
w.bind('<ButtonPress>',press)
w.bind('<Motion>',mouseMove)
w.bind("<ButtonRelease>",release)
w.bind('<Key>',keyDown)
w.geometry('1100x700')
w.resizable(False,False)
w.title("ウーロンを探せ")
tensin=tk.PhotoImage(file="tensin.png")
timer_oo=tk.PhotoImage(file="timer_oo.png")
def main():
    global index,mouseX,mouseY,nowPress,pressed,key,point,timer,c,timer_oo,tensin,font,fontList,nowRelease
    if index==0:
        # タイトル画面
        delText()
        delTable()
        timer%=60
        c.create_image(550+450*cos(timer/30*pi),350-250*sin(timer/30*pi),image=tensin,tag="table")
        c.create_image(550+450*cos((timer+30)/30*pi),350-250*sin((timer+30)/30*pi),image=tensin,tag="table")
        if(nowPress and (mouseX-60)**2+(mouseY-60)**2-50**2<0): # フォント切り替えボタンの表示・動作の設定
            # ボタンを押したとき
            fontList.insert(0,font)
            font=fontList.pop()
            c.create_oval(13,13,113,113,fill="white",tag="table")
            text(63,63,"font","black",20)
        elif(not nowRelease and (mouseX-60)**2+(mouseY-60)**2-50**2<0):
            # 動作が終わったがボタンを押し続けているとき
            c.create_oval(13,13,113,113,fill="white",tag="table")
            text(63,63,"font","black",20)
        else:
            # ボタンを押していないとき
            c.create_oval(10,10,113,113,fill="#AAAAAA",tag="table")
            c.create_oval(10,10,110,110,fill="white",tag="table")
            text(60,60,"font","black",20)
        shadowText(550,100,"ウーロンを探せ","red","#555555",60)
        shadowText(550,350,"1分以内にできるだけ多くのウーロンを見つけよ\n左から右または上から下に読んでウーロン\
になるものを見つけその各文字をクリック\nEnterでランダムに文字列を作り直す\nEscapeでタイトル画面に戻る\
間違えたものをクリックしていても正解があれば点数は貰える","#666666","#333333",19)
        text(550,600,"Enterでスタート","#777777",40)
        if key=='Return': # Enter
            makeTable()
            key,timer,point=0,0,0
            index=1
    elif index==1:
        # メインゲーム画面
        delText()
        delTable()
        c.create_oval(700,50,1050,150,fill="white",outline="black",width=3,tag="table")
        text(875,100,f'{point}ポイント!','black',30)
        if(50<mouseX<650 and 50<mouseY<650 and nowPress and pressed[(mouseX-50)//50][(mouseY-50)//50]!=2):
            pressed[(mouseX-50)//50][(mouseY-50)//50]=1
        c.create_image(900,500,image=timer_oo,tag="table")
        text(800,500,f'{int(61-timer/10)}','red',50)
        showTable()
        pointCheck()
        if key=='Return':
            makeTable()
            key=0
        if key=="Escape":
            key,index,timer=0,0,0
        if timer>=600: # 60秒経過
            index=2
    elif index==2:
        # リザルト画面
        delText()
        delTable()
        high=setHigh(point)
        text(550,150,'Time is up!','black',80)
        text(550,350,f'{point}ポイント','red',50)
        text(550,450,f'ハイスコア：{high}ポイント','red',40)
        text(550,600,'Enterで戻る','#777777',40)
        if key=='Return':
            key,index,timer=0,0,0
    nowPress=False
    timer+=0.14
    w.after(10,main)
main()
w.mainloop()
