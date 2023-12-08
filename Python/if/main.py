import tkinter as tk
import tkinter.ttk as ttk
import sys
import json
from copy import deepcopy as cpy
import material as game 
import random

WIDTH=1280
HEIGHT=720

window = tk.Tk()
canvas = tk.Canvas(window, width=WIDTH, height=HEIGHT)
canvas.pack()

nowPress = False
"""クリックしたかどうか(瞬時)"""
nowRelease = True
"""クリックしていないかどうか"""
mouseX = 0
"""マウスのx座標"""
mouseY = 0
"""マウスのy座標"""
key = 0
"""押したキー"""
index = 0
"""main関数のインデックス"""
timer = 0
"""約0.1秒ごとに約1足す"""


def press(e):  # クリックしたらnowPressをTrueに、nowReleaseをFalseに
    global nowPress, nowRelease
    nowRelease = False
    nowPress = True


def release(e):  # マウスボタンを離したらnowReleaseをTrueに
    global nowRelease
    nowRelease = True


def mouseMove(e):  # マウスを動かしたら座標をmouseX,mouseYに代入
    global mouseX, mouseY
    mouseX, mouseY = e.x, e.y


def keyDown(e):  # キーを押したらkey変数に代入
    global key
    key = e.keysym


window.bind('<ButtonPress>', press)
window.bind('<Motion>', mouseMove)
window.bind("<ButtonRelease>", release)
window.bind('<Key>', keyDown)
window.geometry(f'{WIDTH}x{HEIGHT}')
window.resizable(False, False)
window.title("IF?")
titleImg = tk.PhotoImage(file="./resource/IF.png")

txtPos=[]
txtSpeed=[]
for i in range(len(game.titleTxt)):
    txtPos.append([random.random()*WIDTH,random.random()*HEIGHT])
    txtSpeed.append([random.random()*2-1,random.random()*2-1])
    speed=1/(txtSpeed[i][0]**2+txtSpeed[i][1]**2)
    txtSpeed[i][0]*=speed
    txtSpeed[i][1]*=speed

stageIndex=0

def nextStage():
    global stageIndex,index
    stageIndex=(stageIndex+1)%len(game.stageTitle)
    index=2

def showHelp():
    global index
    index=3

def backStage():
    global index
    index=2


nextBtn = tk.Button(window, text="次へ", command=nextStage, width=15,font=("Yu Gothic UI Semilight", 20))
helpBtn = tk.Button(window, text="ゲーム説明", command=showHelp, width=15,font=("Yu Gothic UI Semilight", 20))
backStageBtn = tk.Button(window, text="戻る", command=backStage, width=15,font=("Yu Gothic UI Semilight", 20))
helpScrTxt=[]
scrLog=[]
logTxt=""
inputTxt=[]

data={"clear":[],"achievement":[]}

def saveGame():
    """dataをファイルにセーブ"""
    global data
    to = open("data.json", "w")
    json.dump(data, to)
    to.close()

try:  # セーブデータ取得
    file = open("data.json", "r")
    data = json.load(file)
except:
    for i in range(len(game.stage)):
        sub=[]
        for j in range(len(game.stage[i])):
            sub.append(False)
        data["clear"].append(sub)
    for i in range(len(game.achieveTitle)):
        data["achievement"].append(False)
    saveGame()

stageNum=0

def runFunc():
    global logTxt
    nowStage=game.stage[stageIndex][stageNum]
    if(nowStage["inp"]==1):
        a=inputTxt[0].get()
        scrLog[0].config(state="normal")
        scrLog[0].insert(tk.END,f"f({a})={nowStage['fun'](a)}\n")
        logTxt+=f"f({a})={nowStage['fun'](a)}\n"
        scrLog[0].config(state="disabled")
    if(nowStage["inp"]==2):
        a=inputTxt[0].get()
        b=inputTxt[1].get()
        scrLog[0].config(state="normal")
        scrLog[0].insert(tk.END,f"f({a},{b})={nowStage['fun'](a,b)}\n")
        logTxt+=f"f({a},{b})={nowStage['fun'](a,b)}\n"
        scrLog[0].config(state="disabled")
    if(nowStage["inp"]==3):
        a=inputTxt[0].get()
        b=inputTxt[1].get()
        c=inputTxt[2].get()
        scrLog[0].config(state="normal")
        scrLog[0].insert(tk.END,f"f({a},{b},{c})={nowStage['fun'](a,b,c)}\n")
        logTxt+=f"f({a},{b},{c})={nowStage['fun'](a,b,c)}\n"
        scrLog[0].config(state="disabled")
    if(nowStage["inp"]==4):
        a=inputTxt[0].get()
        b=inputTxt[1].get()
        c=inputTxt[2].get()
        d=inputTxt[3].get()
        scrLog[0].config(state="normal")
        scrLog[0].insert(tk.END,f"f({a},{b},{c},{d})={nowStage['fun'](a,b,c,d)}\n")
        logTxt+=f"f({a},{b},{c},{d})={nowStage['fun'](a,b,c,d)}\n"
        scrLog[0].config(state="disabled")

runBtn = tk.Button(window, text="実行", command=runFunc, width=10,font=("Yu Gothic UI Semilight", 15))

def showHint():
    txt=game.stage[stageIndex][stageNum]["hint"]
    if(len(txt)>=15):
        txt=txt[0:15]+"\n"+txt[15:]
    game.text(canvas,720,400,txt,"black",20,"txt")

hintBtn = tk.Button(window, text="ヒント", command=showHint, width=15,font=("Yu Gothic UI Semilight", 20))

def endStage():
    global index
    for i in inputTxt:
        i.place_forget()
    runBtn.place_forget()
    endStageBtn.place_forget()
    hintBtn.place_forget()
    for i in scrLog:
        i.place_forget()
    index=2

endStageBtn = tk.Button(window, text="戻る", command=endStage, width=15,font=("Yu Gothic UI Semilight", 20))

answerList=[]
mistake=0

def profile():
    global index
    index=10

profBtn = tk.Button(window, text="プロフィール", command=profile, width=15,font=("Yu Gothic UI Semilight", 20))

def main():
    global canvas,window,index,nowPress,nowRelease,mouseX,mouseY,key,timer,WIDTH,HEIGHT,helpScrTxt,stageNum,scrLog,inputTxt,logTxt,answerList,mistake
    if index==0: # タイトル画面表示
        canvas.create_image(WIDTH//2, HEIGHT//2, image=titleImg, tag="show")
        index+=1
        nowPress=False
    elif index==1: # クリックするまでループ
        canvas.delete("txt")
        for i in range(len(game.titleTxt)):
            game.text(canvas,txtPos[i][0],txtPos[i][1],game.titleTxt[i],"gray",30,tag="txt")
            txtPos[i][0]+=txtSpeed[i][0]
            txtPos[i][1]+=txtSpeed[i][1]
            if(txtPos[i][0]>WIDTH+50 or txtPos[i][1]>HEIGHT+50 or txtPos[i][0]<-50 or txtPos[i][1]<-50):
                txtPos[i][0]=random.random()*WIDTH
                txtPos[i][1]=random.random()*HEIGHT
                txtSpeed[i][0]=2*random.random()-1
                txtSpeed[i][1]=2*random.random()-1
                speed=1/(txtSpeed[i][0]**2+txtSpeed[i][1]**2)
                txtSpeed[i][0]*=speed
                txtSpeed[i][1]*=speed
        if nowPress:
            index+=1
            nowPress=False
    elif index==2: # ステージ選択
        canvas.delete("txt")
        canvas.delete("show")
        for i in helpScrTxt:
            i.place_forget()
        backStageBtn.place_forget()
        game.text(canvas,100,50,game.stageTitle[stageIndex],"black",40,tag="txt")
        for i in range(len(game.stage[stageIndex])):
            X=(i%5)*(WIDTH-150)/5+150
            Y=(i//5)*(HEIGHT-200)/3+200
            canvas.create_oval(X-50,Y-50,X+50,Y+50,fill="#9999FF",tag="show")
            game.text(canvas,X,Y,str(i),"black",30,tag="txt")
            if(data["clear"][stageIndex][i]):
                game.text(canvas,X,Y+50,"クリア","red",30,tag="txt")
        nextBtn.place(x=200,y=15)
        helpBtn.place(x=900,y=15)
        profBtn.place(x=500,y=15)
        nowPress=False
        index+=3
    elif index==3: #ヘルプ
        canvas.delete("txt")
        canvas.delete("show")
        nextBtn.place_forget()
        helpBtn.place_forget()
        profBtn.place_forget()
        helpScrTxt=game.scrText(30,10,1200,500,game.helpTxt)
        backStageBtn.place(x=30,y=550)
        index+=1
    elif index==4: #ループ(help)
        pass
    elif index==5: #ループ(ステージ選択)
        if nowPress:
            for i in range(len(game.stage[stageIndex])):
                X=(i%5)*(WIDTH-150)/5+150
                Y=(i//5)*(HEIGHT-200)/3+200
                if((mouseX-X)**2+(mouseY-Y)**2<=50**2):
                    index+=1
                    stageNum=i
                    logTxt=""
                    answerList=[]
                    timer=0
                    mistake=0
            nowPress=False
    elif index==6: #ゲーム画面
        canvas.delete("txt")
        canvas.delete("show")
        nextBtn.place_forget()
        helpBtn.place_forget()
        profBtn.place_forget()
        for i in inputTxt:
            i.place_forget()
        runBtn.place_forget()
        endStageBtn.place_forget()
        hintBtn.place_forget()
        for i in scrLog:
            i.place_forget()
        nowStage=game.stage[stageIndex][stageNum]
        game.text(canvas,WIDTH/2-100,150,nowStage["que"],"black",30,tag="txt")
        inputTxt=[]
        for i in range(nowStage["inp"]):
            inputTxt.append(tk.Entry())
            game.text(canvas,400,300+i*50+5,f"引数{i+1}","black",10,tag="txt")
            inputTxt[i].place(x=420,y=300+i*50,width=100)
        if nowStage["inp"]!=0:
            scrLog=game.scrText(50,300,300,300,logTxt)
            runBtn.place(x=420,y=550)
        endStageBtn.place(x=20,y=10)
        hintBtn.place(x=300,y=10)
        for i in range(len(nowStage["sel"])):
            X=(i%2)*100+WIDTH-200
            Y=(i//2)*100+50
            canvas.create_oval(X-40,Y-40,X+40,Y+40,fill="#9999FF",tag="show")
            game.text(canvas,X,Y,nowStage["sel"][i],"black",30,tag="txt")
        X=WIDTH-100
        Y=6*100+50
        canvas.create_oval(X-40,Y-40,X+40,Y+40,fill="#ff9999",tag="show")
        game.text(canvas,X,Y,"OK","black",30,tag="txt")
        for i in range(nowStage["len"]):
            X=i*60+40
            canvas.create_oval(X-30,Y-30,X+30,Y+30,fill="#ffffff",tag="show")
        for i in range(len(answerList)):
            X=i*60+40
            canvas.create_oval(X-30,Y-30,X+30,Y+30,fill="#ff9999",tag="show")
            game.text(canvas,X,Y,answerList[i],"black",20,tag="txt")
        index+=1
        nowPress=False
    elif index==7: #ループ(ゲーム画面)
        if nowPress:
            nowStage=game.stage[stageIndex][stageNum]
            for i in range(len(nowStage["sel"])):
                X=(i%2)*100+WIDTH-200
                Y=(i//2)*100+50
                if((mouseX-X)**2+(mouseY-Y)**2<=40**2 and len(answerList)<nowStage["len"]):
                    answerList.append(nowStage["sel"][i])
                    index-=1
            X=WIDTH-100
            Y=6*100+50
            if (mouseX-X)**2+(mouseY-Y)**2<=40**2:
                if "".join(answerList) in nowStage["ans"]:
                    index+=1
                else:
                    answerList=[]
                    mistake+=1
                    index-=1
            nowPress=False
    elif index==8: # リザルト画面
        canvas.delete("txt")
        canvas.delete("show")
        for i in inputTxt:
            i.place_forget()
        runBtn.place_forget()
        endStageBtn.place_forget()
        hintBtn.place_forget()
        for i in scrLog:
            i.place_forget()
        nowStage=game.stage[stageIndex][stageNum]
        game.text(canvas,WIDTH/2,100,f"{game.stageTitle[stageIndex]}-{stageNum} クリア！","#ff9999",40,"txt")
        game.text(canvas,WIDTH/2,200,f"{nowStage['txt']}","#ff9999",30,"txt")
        game.text(canvas,WIDTH/2,300,f"クリアタイム:{timer//100}秒\nミス回数:{mistake}回","black",20,"txt")
        game.text(canvas,WIDTH/2,HEIGHT-100,f"クリックして戻る","gray",30,"txt")
        data["clear"][stageIndex][stageNum]=True
        data["achievement"][0]=True
        for i in range(len(game.stage)):
            if False not in data["clear"][i]:
                data["achievement"][i+1]=True
        if(False not in data["clear"][1:len(game.stage)]):
            data["achievement"][-2]=True
        if(random.randint(0,30)==1):
            data["achievement"][-1]=True
        saveGame()
        index+=1
        nowPress=False
    elif index==9: # ループ(リザルト画面)
        if nowPress:
            index=2
    elif index==10:
        canvas.delete("txt")
        canvas.delete("show")
        nextBtn.place_forget()
        helpBtn.place_forget()
        profBtn.place_forget()
        count=0
        tCount=0
        for i in data["clear"]:
            for j in i:
                count+=1
                if j:
                    tCount+=1
        rate=tCount/count
        game.text(canvas,WIDTH/2,100,f"クリア率:{round(rate*100)}%","black",40,"txt")
        for i in range(len(data["achievement"])):
            if(data["achievement"][i]):
                game.text(canvas,WIDTH/2,200+50*i,f"{game.achieveTitle[i]}-{game.achieveTxt[i]}","black",30,"txt")
        endStageBtn.place(x=20,y=20)
    elif index==11:
        pass
    timer+=1
    window.after(10, main)

main()
window.mainloop()