import tkinter as tk
from time import time
from random import choice
from random import randint as rnd
import os
import pathlib as pl
w=tk.Tk()
c=tk.Canvas(w,width=700,height=700,bg='white')
c.pack()
pressed=[]
"""クリックしたマスを1,クリックして得点に加点済みのマスを2,何もないマスを0とする"""
table=[]
"""文字を並べたテーブル、2次元リストとする"""
nowPress=False
"""クリックしたかどうか"""
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
timer=1
"""0.1秒ごとに1足す"""
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
    global c
    c.create_text(x,y,text=string,fill=colors,font=("New Times Roman",size),tag="texts")
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
        for j in range(8):
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
                c.create_rectangle(50+50*x,80+50*y,100+50*x,130+50*y,fill="white",outline='#888',width=2,tag='table')
                text(75+50*x,105+50*y,str(table[x][y]),"black",30)
            else:
                c.create_rectangle(50+50*x,80+50*y,100+50*x,130+50*y,fill="red",outline='#888',width=2,tag='table')
                text(75+50*x,105+50*y,str(table[x][y]),"white",30)
def delTable():
    """テーブルの非表示"""
    global c
    c.delete("table")
def press(e): # クリックしたらnowPressにTrueを代入
    global nowPress
    nowPress=True
def mouseMove(e): # マウスを動かしたら座標をmouseX,mouseYに代入
    global mouseX,mouseY
    mouseX,mouseY=e.x,e.y
def keyDown(e): # キーを押したらkey変数に代入
    global key
    key=e.keysym
w.bind('<ButtonPress>',press)
w.bind('<Motion>',mouseMove)
w.bind('<Key>',keyDown)
w.geometry('700x700')
w.resizable(False,False)
w.title("ウーロンを探せ")
def main():
    global index,mouseX,mouseY,nowPress,pressed,key,point,timer
    if index==0:
        # タイトル画面
        delText()
        shadowText(351,101,"ウーロンを探せ","red","#555555",60)
        shadowText(350,350,"1分以内にできるだけ多くのウーロンを見つけよ\n左から右または上から下に読んでウーロン\
になるもの\nを見つけその各文字をクリック\nEnterでランダムに文字列を作り直す\n\
間違えたものをクリックしていても正解があれば点数は貰える","#666666","#333333",19)
        text(350,600,"Enterでスタート","#999999",40)
        if key=='Return': # Enter
            makeTable()
            key,timer,point=0,0,0
            index=1
    elif index==1:
        # メインゲーム画面
        delText()
        delTable()
        text(500,25,f'ポイント：{point}','red',30)
        text(100,25,f'残り{int(60-timer/10)}秒','red',30)
        if(50<mouseX<650 and 80<mouseY<680 and nowPress and pressed[(mouseX-50)//50][(mouseY-80)//50]!=2):
            pressed[(mouseX-50)//50][(mouseY-80)//50]=1
        showTable()
        pointCheck()
        if key=='Return':
            makeTable()
            key=0
        if timer==600: # 60秒経過
            index=2
    elif index==2:
        # リザルト画面
        delText()
        delTable()
        high=setHigh(point)
        text(350,150,'Time is up!','red',80)
        text(350,350,f'{point}ポイント','red',50)
        text(350,450,f'ハイスコア：{high}ポイント','red',40)
        text(350,600,'Enterで戻る','#999999',40)
        if key=='Return':
            key=0
            index=0
    nowPress=False
    timer+=1
    w.after(100,main)
main()
w.mainloop()
