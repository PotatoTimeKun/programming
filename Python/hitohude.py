import tkinter as tk
import time as ti
import os
import pathlib as pl
if os.path.exists('C:\\hitohude\\data.txt'):
    with open('C:\\hitohude\\data.txt','r')as r:
        b=r.read()
else:
    b='100000,100000,100000'
    pl.Path('C:\\hitohude').mkdir()
    with open('C:\\hitohude\\data.txt','x')as t:
        t.write('100000,100000,100000')
w=tk.Tk()
w.title('一筆書き')
w.geometry('700x700')
w.resizable(False,False)
fot='Times New Roman'
b=b.split(',')
high=b
high[0]=int(high[0])
high[1]=int(high[1])
high[2]=int(high[2])
st=0
s1=[
    [1,1,1,1,1,1,1,1,1,1,1,1],
    [1,2,1,0,0,0,1,1,0,0,1,1],
    [0,0,1,1,1,0,0,0,0,0,0,1],
    [0,0,0,0,1,1,0,0,0,0,0,1],
    [0,0,1,0,0,0,1,1,0,0,1,1],
    [0,0,1,0,0,0,1,1,1,0,1,1],
    [0,0,0,1,1,0,1,0,0,0,1,1],
    [0,1,0,0,1,0,0,0,1,1,1,1],
    [0,1,1,0,0,1,1,1,1,0,0,1],
    [0,0,0,1,0,1,1,1,1,0,0,1],
    [0,0,0,0,0,0,0,0,0,0,0,1],
    [1,1,1,0,0,0,0,0,0,0,0,1]
]
s2=[
    [1,1,1,1,0,0,0,1,1,1,1,1],
    [1,0,0,1,0,0,0,0,1,1,0,0],
    [1,1,0,1,1,0,1,0,1,1,1,0],
    [1,0,0,1,1,0,0,0,0,1,0,0],
    [1,0,1,1,1,1,0,0,0,0,0,1],
    [1,0,0,1,1,1,0,0,1,1,1,1],
    [0,0,0,0,1,1,0,0,1,0,0,1],
    [0,0,0,0,1,1,1,0,0,0,0,1],
    [0,1,1,1,1,1,0,0,0,0,0,1],
    [0,0,0,0,1,1,0,0,0,1,1,1],
    [1,1,1,0,0,1,0,0,1,1,1,1],
    [1,1,1,1,0,0,0,0,1,1,1,1]
]
s3=[
    [1,0,0,0,0,1,1,1,0,0,1,1],
    [1,0,0,1,0,1,1,1,0,0,1,1],
    [1,1,0,1,0,1,1,0,0,0,0,1],
    [1,0,0,1,0,0,0,0,1,0,0,1],
    [0,0,0,0,1,0,0,1,1,0,1,1],
    [0,0,0,0,0,1,1,1,1,0,0,0],
    [1,1,0,0,0,1,1,1,0,0,0,0],
    [1,1,0,0,0,1,1,1,0,0,1,1],
    [1,1,1,0,0,0,0,0,0,0,1,1],
    [1,0,0,0,1,0,0,0,0,0,1,1],
    [1,0,1,1,1,1,1,1,1,0,1,1],
    [1,0,0,0,0,0,0,0,0,0,1,1]
]
ind=0
tm=0
pr=0
mosx=0
mosy=0
ho=None
now=[1,1]
nowold=[1,1]
co=0
res=0
f=0
c=tk.Canvas(w,width=700,height=700,bg='white')
c.pack()
def pres(e):
    global pr
    pr=1
def txt2(x,y,cl,cl2,tx,sz,ta):
    fon=(fot,sz)
    c.create_text(x+2,y+2,fill=cl2,text=tx,font=fon,tag=ta)
    c.create_text(x,y,fill=cl,text=tx,font=fon,tag=ta)
def mos(e):
    global mosx,mosy
    mosx=e.x
    mosy=e.y
def prk(e):
    global ho
    ho=e.keysym
def game():
    global fot,ind,tm,pr,mosx,mosy,ho,now,nowold,co,res,st,high,f
    tm+=1
    if ind==0:  #タイトル画面
        txt2(350,150,"#50a0d0","blue",'一筆書き',100,'titlet')
        if tm%8<4:
            a=0
        else:
            a=1
        if a==0:
            c.create_text(350,500,fill='#888',font=(fot,30),text='クリックでスタート',tag='title')
        else:
            c.delete('title')
        if pr==1:
            ind=1
            pr=0
            f=1
    elif ind==1:  #選択画面
        c.delete('games')
        c.delete('hint')
        c.delete('result')
        c.delete('title')
        c.delete('titlet')
        if f==1:
            f=0
            for i in range(50):
                c.create_line(30*i+10,-10,-10,30*i+10,fill='#ffffaa',width=10)
        for i in range(1,4):
            c.create_rectangle(200+2,100*i+50*(i-1)+2,500+2,100*i+50*(i-1)+100+2,fill='#777',outline='#000',width=0,tag=f'sel{i}')
            c.create_rectangle(200,100*i+50*(i-1),500,100*i+50*(i-1)+100,fill='#40d0a0',outline='#000',width=0,tag=f'sel{i}')
            c.create_text(350,150*i,fill='white',font=(fot,40),text=f'Stage {i}',tag=f'selt{i}')
            if mosx>200 and mosx<500 and mosy>100*i+50*(i-1) and mosy<100*i+50*(i-1)+100:
                c.delete(f'sel{i}')
                c.delete(f'selt{i}')
                c.create_rectangle(200+2,100*i+50*(i-1)+2,500+2,100*i+50*(i-1)+100+2,fill='blue',outline='#000',width=0,tag=f'sel{i}')
                c.create_text(352,150*i+2,fill='white',font=(fot,40),text=f'Stage {i}',tag=f'selt{i}')
            if mosx>200 and mosx<500 and mosy>100*i+50*(i-1) and mosy<100*i+50*(i-1)+100 and pr==1:
                pr=0
                ind=i+1
                co=ti.time()
                st=i-1
                ho=0
    elif ind==2:  #stage1
        for i in range(1,4):
            c.delete(f'sel{i}')
            c.delete(f'selt{i}')
        c.delete('games')
        c.delete('hint')
        nowold=[now[0],now[1]]
        if ho=='Down' and now[0]!=11 and s1[now[0]+1][now[1]]==0:
            now[0]+=1
            ho=None
        if ho=='Right' and now[1]!=11 and s1[now[0]][now[1]+1]==0:
            now[1]+=1
            ho=None
        if ho=='Up' and now[0]!=0 and s1[now[0]-1][now[1]]==0:
            now[0]-=1
            ho=None
        if ho=='Left' and now[1]!=0 and s1[now[0]][now[1]-1]==0:
            now[1]-=1
            ho=None
        if ho=='Escape':
            for my in range(12):
                for mx in range(12):
                    if s1[mx][my]==2:
                        s1[mx][my]=0
                    if s1[mx][my]==3:
                        s1[mx][my]=0
            f=1
            ho=None
            ind=1
            nowold=[1,1]
            now=[1,1]
        s1[nowold[0]][nowold[1]]=2
        s1[now[0]][now[1]]=3
        if ho=='Return':
            co=ti.time()
            for my in range(12):
                for mx in range(12):
                    if s1[mx][my]==2:
                        s1[mx][my]=0
                    if s1[mx][my]==3:
                        s1[mx][my]=0
            nowold=[1,1]
            now=[1,1]
            s1[1][1]=3
        for my in range(12):
            for mx in range(12):
                if s1[my][mx]==1:
                    c.create_rectangle(50+50*mx,80+50*my,100+50*mx,130+50*my,fill="#50a0d0",outline='#888',width=1,tag='games')
                if s1[my][mx]==0:
                    c.create_rectangle(50+50*mx,80+50*my,100+50*mx,130+50*my,fill="white",outline='#888',width=1,tag='games')
                if s1[my][mx]==2:
                    c.create_rectangle(50+50*mx,80+50*my,100+50*mx,130+50*my,fill="#ff9090",outline='#888',width=1,tag='games')
                if s1[my][mx]==3:
                    c.create_rectangle(50+50*mx,80+50*my,100+50*mx,130+50*my,fill="#ff3030",outline='#888',width=1,tag='games')
        c.create_text(350,40,font=(fot,20),fill='black',text='空白を埋めよう　方向キー：移動\nエンター：リセット　エスケープ：メニュー',tag='hint')
        a=0
        for x in s1:
            if 0 in x:
                a+=1
        if a==0:
            ind=5
            ho=0
            for my in range(12):
                for mx in range(12):
                    if s1[mx][my]==2:
                        s1[mx][my]=0
                    if s1[mx][my]==3:
                        s1[mx][my]=0
            now=[1,1]
            nowold=[1,1]
    elif ind==3:  #stage2
        for i in range(1,4):
            c.delete(f'sel{i}')
            c.delete(f'selt{i}')
        c.delete('games')
        c.delete('hint')
        nowold=[now[0],now[1]]
        if ho=='Down' and now[0]!=11 and s2[now[0]+1][now[1]]==0:
            now[0]+=1
            ho=None
        if ho=='Right' and now[1]!=11 and s2[now[0]][now[1]+1]==0:
            now[1]+=1
            ho=None
        if ho=='Up' and now[0]!=0 and s2[now[0]-1][now[1]]==0:
            now[0]-=1
            ho=None
        if ho=='Left' and now[1]!=0 and s2[now[0]][now[1]-1]==0:
            now[1]-=1
            ho=None
        if ho=='Escape':
            for my in range(12):
                for mx in range(12):
                    if s2[mx][my]==2:
                        s2[mx][my]=0
                    if s2[mx][my]==3:
                        s2[mx][my]=0
            f=1
            ho=None
            ind=1
            nowold=[1,1]
            now=[1,1]
        s2[nowold[0]][nowold[1]]=2
        s2[now[0]][now[1]]=3
        if ho=='Return':
            co=ti.time()
            for my in range(12):
                for mx in range(12):
                    if s2[mx][my]==2:
                        s2[mx][my]=0
                    if s2[mx][my]==3:
                        s2[mx][my]=0
            nowold=[1,1]
            now=[1,1]
            s2[1][1]=3
            ho=None
        for my in range(12):
            for mx in range(12):
                if s2[my][mx]==1:
                    c.create_rectangle(50+50*mx,100+50*my,100+50*mx,150+50*my,fill="#50a0d0",outline='#888',width=1,tag='games')
                if s2[my][mx]==0:
                    c.create_rectangle(50+50*mx,100+50*my,100+50*mx,150+50*my,fill="white",outline='#888',width=1,tag='games')
                if s2[my][mx]==2:
                    c.create_rectangle(50+50*mx,100+50*my,100+50*mx,150+50*my,fill="#ff9090",outline='#888',width=1,tag='games')
                if s2[my][mx]==3:
                    c.create_rectangle(50+50*mx,100+50*my,100+50*mx,150+50*my,fill="#ff3030",outline='#888',width=1,tag='games')
        c.create_text(350,40,font=(fot,20),fill='black',text='空白を埋めよう　方向キー：移動\nエンター：リセット　エスケープ：メニュー',tag='hint')
        a=0
        for x in s2:
            if 0 in x:
                a+=1
        if a==0:
            ind=5
            ho=0
            for my in range(12):
                for mx in range(12):
                    if s2[mx][my]==2:
                        s2[mx][my]=0
                    if s2[mx][my]==3:
                        s2[mx][my]=0
            now=[1,1]
            nowold=[1,1]
    elif ind==4:  #stage3
        for i in range(1,4):
            c.delete(f'sel{i}')
            c.delete(f'selt{i}')
        c.delete('games')
        c.delete('hint')
        nowold=[now[0],now[1]]
        if ho=='Down' and now[0]!=11 and s3[now[0]+1][now[1]]==0:
            now[0]+=1
            ho=None
        if ho=='Right' and now[1]!=11 and s3[now[0]][now[1]+1]==0:
            now[1]+=1
            ho=None
        if ho=='Up' and now[0]!=0 and s3[now[0]-1][now[1]]==0:
            now[0]-=1
            ho=None
        if ho=='Left' and now[1]!=0 and s3[now[0]][now[1]-1]==0:
            now[1]-=1
            ho=None
        if ho=='Escape':
            for my in range(12):
                for mx in range(12):
                    if s3[mx][my]==2:
                        s3[mx][my]=0
                    if s3[mx][my]==3:
                        s3[mx][my]=0
            f=1
            ho=None
            ind=1
            nowold=[1,1]
            now=[1,1]
        s3[nowold[0]][nowold[1]]=2
        s3[now[0]][now[1]]=3
        if ho=='Return':
            co=ti.time()
            for my in range(12):
                for mx in range(12):
                    if s3[mx][my]==2:
                        s3[mx][my]=0
                    if s3[mx][my]==3:
                        s3[mx][my]=0
            nowold=[1,1]
            now=[1,1]
            s3[1][1]=3
        for my in range(12):
            for mx in range(12):
                if s3[my][mx]==1:
                    c.create_rectangle(50+50*mx,100+50*my,100+50*mx,150+50*my,fill="#50a0d0",outline='#888',width=1,tag='games')
                if s3[my][mx]==0:
                    c.create_rectangle(50+50*mx,100+50*my,100+50*mx,150+50*my,fill="white",outline='#888',width=1,tag='games')
                if s3[my][mx]==2:
                    c.create_rectangle(50+50*mx,100+50*my,100+50*mx,150+50*my,fill="#ff9090",outline='#888',width=1,tag='games')
                if s3[my][mx]==3:
                    c.create_rectangle(50+50*mx,100+50*my,100+50*mx,150+50*my,fill="#ff3030",outline='#888',width=1,tag='games')
        c.create_text(350,40,font=(fot,20),fill='black',text='空白を埋めよう　方向キー：移動\nエンター：リセット　エスケープ：メニュー',tag='hint')
        a=0
        for x in s3:
            if 0 in x:
                a+=1
        if a==0:
            ind=5
            ho=0
            for my in range(12):
                for mx in range(12):
                    if s3[mx][my]==2:
                        s3[mx][my]=0
                    if s3[mx][my]==3:
                        s3[mx][my]=0
            now=[1,1]
            nowold=[1,1]
    elif ind==5:  #結果
        c.delete('games')
        c.delete('hint')
        if res==0:
            res=ti.time()-co
            res=int(res)
        if high[st]>res:
            high[st]=res
            for i in range(3):
                high[i]=str(high[i])
            a=','.join(high)
            with open('C:\\hitohude\\data.txt','w')as r:
                r.write(f'{a}')
            for i in range(3):
                high[i]=int(high[i])
        hi=high[st]
        c.create_text(350,200,text='CLEAR!',fill='red',font=(fot,80),tag='result')
        c.create_text(350,400,text=f'Time: {res} 秒',fill='red',font=(fot,50),tag='result') 
        c.create_text(350,500,text=f'HighScore：{hi} 秒',fill='red',font=(fot,50),tag='result')
        c.create_text(350,620,text='Enterでステージ選択に戻る',fill='#888',font=(fot,35),tag='result')
        if ho=='Return':
            ind=1
            ho=0
            st=0
            res=0
            f=1
            pr=0
    pr=0
    w.after(100,game)
w.bind("<ButtonPress>",pres)
w.bind('<Motion>',mos)
w.bind('<Key>',prk)
game()
w.mainloop()