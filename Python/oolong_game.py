import tkinter as tk
from time import time
from random import choice as ch
from random import randint as ri
import os
import pathlib as pl
w=tk.Tk()
c=tk.Canvas(w,width=700,height=700,bg='white')
c.pack()
prs=[]
data=[]
pr=0
mx=0
my=0
keyy=0
ind='s'
pi=0
co=1
if os.path.exists('C:\\findoolong\\high.txt'):
    with open('C:\\findoolong\\high.txt','r')as r:
        hi=r.read()
else:
    hi='0'
    pl.Path('C:\\findoolong').mkdir()
    with open('C:\\findoolong\\high.txt','x')as t:
        t.write('0')
def putoo():
    wh=ch([0,1])
    if wh==0:
        ox=ri(0,8)
        oy=ri(0,11)
        data[ox][oy]='ウ'
        data[ox+1][oy]='ー'
        data[ox+2][oy]='ロ'
        data[ox+3][oy]='ン'
    if wh==1:
        ox=ri(0,11)
        oy=ri(0,8)
        data[ox][oy]='ウ'
        data[ox][oy+1]='ー'
        data[ox][oy+2]='ロ'
        data[ox][oy+3]='ン'
def prs(e):
    global pr
    pr=1
def mos(e):
    global mx,my
    mx=e.x
    my=e.y
def ky(e):
    global keyy
    keyy=e.keysym
w.geometry('700x700')
w.resizable(False,False)
w.bind('<ButtonPress>',prs)
w.bind('<Motion>',mos)
w.bind('<Key>',ky)
def main():
    global ind,mx,my,pr,data,prs,keyy,pi,co,hi
    if ind=='s':
        c.delete('res')
        c.create_text(351,101,text='ウーロンを探せ',fill='#555555',font=('New Times Roman',60),tag='res')
        c.create_text(350,100,text='ウーロンを探せ',fill='red',font=('New Times Roman',60),tag='res')
        c.create_text(351,351,text='1分以内にできるだけ多くのウーロンを見つけよ\n左から右または上から下に読んでウーロンになるもの\nを見つけその各文字をクリック\nEnterでランダムに文字列を作り直す\n間違えたものをクリックしていても正解があれば点数は貰える',fill='#333333',font=('New Times Roman',19),tag='res')
        c.create_text(350,350,text='1分以内にできるだけ多くのウーロンを見つけよ\n左から右または上から下に読んでウーロンになるもの\nを見つけその各文字をクリック\nEnterでランダムに文字列を作り直す\n間違えたものをクリックしていても正解があれば点数は貰える',fill='#666666',font=('New Times Roman',19),tag='res')
        c.create_text(350,600,text='Enterでスタート',fill='#999999',font=('New Times Roman',40),tag='res')
        if keyy=='Return':
            keyy=0
            ind=0
            co=0
    if ind==0:
        c.delete('res')
        c.create_text(500,25,text=f'ポイント：{pi}',fill='red',font=('New Times Roman',30),tag='res')
        c.create_text(100,25,text=f'残り{int(60-co/10)}秒',fill='red',font=('New Times Roman',30),tag='res2')
        data=[[],[],[],[],[],[],[],[],[],[],[],[]]
        prs=[[],[],[],[],[],[],[],[],[],[],[],[]]
        for i in range(12):
            for a in range(12):
                data[i].append(ch(['ウ','ー','ロ','ン','ソ']))
                prs[i].append(0)
        putoo()
        putoo()
        ind=1
    elif ind==1:
        c.delete('res2')
        c.create_text(100,25,text=f'残り{int(60-co/10)}秒',fill='red',font=('New Times Roman',30),tag='res2')
        c.delete('games')
        for x in range(12):
            for y in range(12):
                if mx>50+50*x and mx<100+50*x and my>80+50*y and my<130+50*y and pr==1:
                    c.create_rectangle(50+50*x,80+50*y,100+50*x,130+50*y,fill="red",outline='#888',width=2,tag='games')
                    c.create_text(75+50*x,105+50*y,text=str(data[x][y]),fill="white",font=('New Times Roman',30),tag='games')
                    prs[x][y]=1
                    pr=0
                else:
                    if prs[x][y]==0:
                        c.create_rectangle(50+50*x,80+50*y,100+50*x,130+50*y,fill="white",outline='#888',width=2,tag='games')
                        c.create_text(75+50*x,105+50*y,text=str(data[x][y]),fill="black",font=('New Times Roman',30),tag='games')
                    if prs[x][y]==1:
                        c.create_rectangle(50+50*x,80+50*y,100+50*x,130+50*y,fill="red",outline='#888',width=2,tag='games')
                        c.create_text(75+50*x,105+50*y,text=str(data[x][y]),fill="white",font=('New Times Roman',30),tag='games')
        if keyy=='Return':
            ind=2
            keyy=0
        if co==600:
            for i in range(12):
                for a in range(12):
                    if i<9:
                        if prs[i][a]==1 and prs[i+1][a]==1 and prs[i+2][a]==1 and prs[i+3][a]==1:
                            if data[i][a]=='ウ' and data[i+1][a]=='ー' and data[i+2][a]=='ロ' and data[i+3][a]=='ン':
                                pi+=1
                    if a<9:
                        if prs[i][a]==1 and prs[i][a+1]==1 and prs[i][a+2]==1 and prs[i][a+3]==1:
                            if data[i][a]=='ウ' and data[i][a+1]=='ー' and data[i][a+2]=='ロ' and data[i][a+3]=='ン':
                                pi+=1
            ind=3
    elif ind==2:
        c.delete('res2')
        c.create_text(100,25,text=f'残り{int(60-co/10)}秒',fill='red',font=('New Times Roman',30),tag='res2')
        a=[]
        c.delete('games')
        for i in range(12):
            for a in range(12):
                if i<9:
                    if prs[i][a]==1 and prs[i+1][a]==1 and prs[i+2][a]==1 and prs[i+3][a]==1:
                        if data[i][a]=='ウ' and data[i+1][a]=='ー' and data[i+2][a]=='ロ' and data[i+3][a]=='ン':
                            pi+=1
                if a<9:
                    if prs[i][a]==1 and prs[i][a+1]==1 and prs[i][a+2]==1 and prs[i][a+3]==1:
                        if data[i][a]=='ウ' and data[i][a+1]=='ー' and data[i][a+2]=='ロ' and data[i][a+3]=='ン':
                            pi+=1
        ind=0
    elif ind==3:
        c.delete('games')
        c.delete('res')
        c.delete('res2')
        hi=int(hi)
        if hi<pi:
            with open('C:\\findoolong\\high.txt','w')as tx:
                tx.write(str(pi))
            hi=pi
        c.create_text(350,150,text='Time is up!',fill='red',font=('New Times Roman',80),tag='res')
        c.create_text(350,350,text=f'{pi}ポイント',fill='red',font=('New Times Roman',50),tag='res')
        c.create_text(350,450,text=f'ハイスコア：{hi}ポイント',fill='red',font=('New Times Roman',40),tag='res')
        c.create_text(350,600,text='Enterで戻る',fill='#999999',font=('New Times Roman',40),tag='res')
        if keyy=='Return':
            keyy=0
            ind='s'
            co=0
            pi=0
    co+=1
    w.after(100,main)
main()
w.mainloop()
