from email.mime import image
from inspect import indentsize
from selectors import SelectSelector
import gameMaterial as gm
import tkinter as tk
import tkinter.ttk as ttk
from random import choice
from random import randint as rnd
import pygame
import sys
import json
from copy import deepcopy as cpy
w = tk.Tk()
c = tk.Canvas(w, width=900, height=600)
c.pack()
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


w.bind('<ButtonPress>', press)
w.bind('<Motion>', mouseMove)
w.bind("<ButtonRelease>", release)
w.bind('<Key>', keyDown)
w.geometry('900x600')
w.resizable(False, False)
w.title("ポテトしかおらんRPG")
titleImg = 0
"""タイトル画面の画像"""
bgmCh = 0
"""BGMのチャンネル"""
seCh = 0
"""SEのチャンネル"""
toSetFrom = 0
"""設定に飛んできた元のインデックス"""
settings = 0
"""セーブデータ"""
data = 0
"""現在プレイヤーのデータ(settingsからアドレス渡し)"""
serihuIndex = 0
"""セリフのインデックス"""
try:  # セーブデータ取得
    file = open("settings.json", "r")
    settings = json.load(file)
except:
    settings = {"bgm": 0.4, "se": 0.4, "saves": []}
bgmVol = settings["bgm"]
"""bgmのボリューム"""
seVol = settings["se"]
"""seのボリューム"""


def saveGame():
    """settingsをファイルにセーブ"""
    global settings
    to = open("settings.json", "w")
    json.dump(settings, to)
    to.close()


def contGame():
    """続きから"""
    global data, index, serihuIndex
    data = settings["saves"][comb.current()-1]
    index = 7
    serihuIndex = 0
    for btn in btn1:
        btn.place_forget()
    comb.place_forget()
    c.delete("show")
    playSe()


def jmpSet():
    """設定へ"""
    global index, toSetFrom
    toSetFrom = index
    index = 3
    playSe()


def endGame():
    """ゲーム終了"""
    saveGame()
    sys.exit()


def newGame():
    """初めから"""
    global settings, index, data, serihuIndex, c, btn1
    playSe()
    settings["saves"] += [{}]
    data = settings["saves"][len(settings["saves"])-1]
    name = tk.simpledialog.askstring("new data", "名前を入力してください")
    if(name == None or name == ""):
        del settings["saves"][len(settings["saves"])-1]
        return
    data["name"] = name
    data["mapIndex"] = 0
    data["x"] = 2.5
    data["y"] = 5.5
    data["Lv"] = 1
    data["keiken"] = 0
    data["HP"] = 10
    data["HPmax"] = 10
    data["MP"] = 10
    data["MPmax"] = 10
    data["power"] = 3
    data["job"] = [0, 0]
    data["jobLv"] = [1, 1, 1, 1]
    data["jobKeiken"] = [0, 0, 0, 0]
    data["jobPower"] = [0, 0, 0, 5]
    data["waza"] = [[], []]
    data["event"] = [True, True, True, True, True, True,
                     True, True, True, True, True, True, False, True]
    data["visited"] = [True, False, False, False, False, False,
                       False, False, False, False, False, False, False, False]
    data["dead"] = 0
    data["killed"] = 0
    data["bag"] = [[], []]
    data["soubi"] = [0, 0, 0]
    data["money"] = 15
    data["farm"] = 0
    data["maps"] = cpy(gm.maps)
    data["mapEvent"] = cpy(gm.mapEvent)
    index = 7
    serihuIndex = 0
    for btn in btn1:
        btn.place_forget()
    comb.place_forget()
    c.delete("show")


btn1 = [tk.Button(w, text="続きから", command=contGame, width=35, font=("Yu Gothic UI Semilight", 15)),
        tk.Button(w, text="はじめから", command=newGame, width=35,
                  font=("Yu Gothic UI Semilight", 15)),
        tk.Button(w, text="設定", command=jmpSet, width=35,
                  font=("Yu Gothic UI Semilight", 15)),
        tk.Button(w, text="終了", command=endGame, width=35, font=("Yu Gothic UI Semilight", 15))]
"""タイトル画面のボタンリスト"""

comb = ttk.Combobox(w, state="readonly")
"""プレイヤー選択のドロップダウンリスト"""
comb["values"] = ("セーブデータを選択",) + \
    tuple((f"{i['name']}-{i['Lv']}Lv" for i in settings["saves"]))
comb.current(0)

pygame.mixer.init()
bgmSo = pygame.mixer.Sound("bgm.mp3")
"""bgmのsound"""
seSo = pygame.mixer.Sound("se.mp3")
"""seのsound"""
seCh = pygame.mixer.Channel(5)
var = [tk.DoubleVar(), tk.DoubleVar()]
"""音量スライダー用"""
var[0].set(bgmVol)
var[1].set(seVol)


def playSe():
    """seを鳴らす"""
    seCh.play(seSo)


def setVolb(e):
    """bgmスライダーの呼び出し関数"""
    global bgmCh, settings
    settings["bgm"] = var[0].get()
    bgmCh.set_volume(var[0].get())


def setVols(e):
    """seスライダーの呼び出し関数"""
    global seCh, settings
    settings["se"] = var[1].get()
    seCh.set_volume(var[1].get())


scl = tk.Scale(w, command=setVolb, variable=var[0], from_=0,
               to=1, resolution=0.05, length=400, orient=tk.HORIZONTAL)
"""bgmスライダー"""
scl2 = tk.Scale(w, command=setVols, variable=var[1], from_=0,
                to=1, resolution=0.05, length=400, orient=tk.HORIZONTAL)
"""seスライダー"""


def dataOut():
    """セーブデータの外部出力"""
    try:
        gm.jsonSave(settings)
    except:
        pass


def dataIn():
    """セーブデータの外部入力"""
    global bgmVol, seVol, bgmCh, seCh, var
    try:
        settings = gm.jsonGet()
        bgmVol = settings["bgm"]
        seVol = settings["se"]
        bgmCh.set_volume(bgmVol)
        var[0].set(bgmVol)
        seCh.set_volume(seVol)
        var[1].set(seVol)
    except:
        pass


btn2 = [tk.Button(w, text="セーブデータ出力", command=dataOut, width=35, font=("Yu Gothic UI Semilight", 15)),
        tk.Button(w, text="セーブデータ入力", command=dataIn, width=35, font=("Yu Gothic UI Semilight", 15))]
"""設定のボタンリスト"""
soncho = tk.PhotoImage(file="sonco.png")
"""村長の画像"""
potekun = [tk.PhotoImage(file=f"p{i}.png") for i in "frbl"]
"""主人公の画像リスト、向いてる方向が↓→↑←の順"""
mapImg = [tk.PhotoImage(file=f"{i}.png") for i in range(21)]
"""マップの画像リスト"""
p0d = tk.PhotoImage(file=f"0d.png")
p0m = tk.PhotoImage(file=f"0m.png")
p0s = tk.PhotoImage(file=f"0s.png")
p1d = tk.PhotoImage(file=f"1d.png")
p1s = tk.PhotoImage(file=f"1s.png")  # 各マップで異なる0,1の画像、d=洞窟,m=森,s=空
playerNow = potekun[0]
"""プレイヤーの現在向いてる向きの画像"""


def showMap():
    """マップを表示"""
    cenX = 450  # xの中心(プレイヤーの表示位置)
    cenY = 250  # y 〃
    nowMap = data["maps"][data["mapIndex"]]
    # 端では中心をずらす
    if data["x"] < 4.5:
        cenX -= (4.5-data["x"])*100
    if data["x"] > len(nowMap[0])-4.5:
        cenX += (4.5-(len(nowMap[0])-data["x"]))*100
    if data["y"] < 2.5:
        cenY -= (2.5-data["y"])*100
    if data["y"] > len(nowMap)-3.5:
        cenY += (3.5-(len(nowMap)-data["y"]))*100
    # 0,1,12は先に表示、マップごとに画像が異なる
    for i, mapArray in enumerate(nowMap):
        for j, cell in enumerate(mapArray):
            x = (j-data["x"])*100+50+cenX  # 表示位置
            y = (i-data["y"])*100+50+cenY
            if(cell == 0 or cell == 12):
                if(data["mapIndex"] == 0 or data["mapIndex"] == 10):
                    c.create_image(x, y, image=mapImg[0], tag="show")
                elif(data["mapIndex"] <= 4 or data["mapIndex"] == 14):
                    c.create_image(x, y, image=p0m, tag="show")
                elif(data["mapIndex"] <= 9):
                    c.create_image(x, y, image=p0d, tag="show")
                elif(data["mapIndex"] <= 13):
                    c.create_image(x, y, image=p0s, tag="show")
            elif(cell == 1 or cell == 5):
                if(data["mapIndex"] <= 4 or data["mapIndex"] == 10 or data["mapIndex"] == 14):
                    c.create_image(x, y, image=mapImg[1], tag="show")
                elif(data["mapIndex"] <= 9):
                    c.create_image(x, y, image=p1d, tag="show")
                elif(data["mapIndex"] <= 13):
                    c.create_image(x, y, image=p1s, tag="show")
    # その他の画像を表示
    for i, mapArray in enumerate(nowMap):
        for j, cell in enumerate(mapArray):
            x = (j-data["x"])*100+50+cenX
            y = (i-data["y"])*100+50+cenY
            if(cell not in [0, 1, 12]):
                c.create_image(x, y, image=mapImg[cell], tag="show")
    # プレイヤーの表示
    c.create_image(cenX, cenY, image=playerNow, tag="show")


def swAndHe():
    """剣士とヒーラーを選んだ時"""
    global data, serihuIndex
    serihuIndex += 1
    data["job"] = [1, 2]
    data["waza"] = [[[1, "剣殴り", 0.5]], [[2, "ヒール", 1]]]
    playSe()


def heAndAr():
    """ヒーラーとアーチャーを選んだ時"""
    global data, serihuIndex
    serihuIndex += 1
    data["job"] = [2, 3]
    data["waza"] = [[[2, "ヒール", 1]], [[1, "アローショット", 0.5]]]
    playSe()


def arAndSw():
    """アーチャーと剣士を選んだ時"""
    global data, serihuIndex
    serihuIndex += 1
    data["job"] = [3, 1]
    data["waza"] = [[[1, "アローショット", 0.5]], [[1, "剣殴り", 0.5]]]
    playSe()


btn3 = [
    tk.Button(w, text="剣士とヒーラー", command=swAndHe, width=35,
              font=("Yu Gothic UI Semilight", 15)),
    tk.Button(w, text="ヒーラーとアーチャー", command=heAndAr,
              width=35, font=("Yu Gothic UI Semilight", 15)),
    tk.Button(w, text="アーチャーと剣士", command=arAndSw, width=35,
              font=("Yu Gothic UI Semilight", 15)),
]
"""イベント0の職業選択のボタンリスト"""


def showProf():
    """プロフィールの表示"""
    global index
    index = 11
    for btn in btn4:
        btn.place_forget()
    playSe()


def jumSet2():
    """設定へ"""
    global toSetFrom, index
    toSetFrom = index
    index = 3
    for btn in btn4:
        btn.place_forget()
    playSe()


def showItem():
    """アイテム・装備を表示"""
    global index
    index = 13
    for btn in btn4:
        btn.place_forget()
    playSe()


def saveAndEnd():
    """セーブしてタイトル画面へ"""
    global index
    for btn in btn4:
        btn.place_forget()
    saveGame()
    index = 1
    playSe()


def endMenu():
    """ゲーム画面へ"""
    global index
    for btn in btn4:
        btn.place_forget()
    index = 8
    playSe()


def save():
    """セーブ"""
    saveGame()
    playSe()


btn4 = [
    tk.Button(w, text="メニューを閉じる", command=endMenu, width=35,
              font=("Yu Gothic UI Semilight", 15)),
    tk.Button(w, text="設定", command=jumSet2, width=35,
              font=("Yu Gothic UI Semilight", 15)),
    tk.Button(w, text="プロフィール", command=showProf, width=35,
              font=("Yu Gothic UI Semilight", 15)),
    tk.Button(w, text="アイテム・装備", command=showItem, width=35,
              font=("Yu Gothic UI Semilight", 15)),
    tk.Button(w, text="セーブ", command=save, width=35,
              font=("Yu Gothic UI Semilight", 15)),
    tk.Button(w, text="セーブしてタイトルに戻る", command=saveAndEnd, width=35,
              font=("Yu Gothic UI Semilight", 15)),
]
"""メニュー画面のボタンリスト"""


def mapTo(ind): # 指定したインデックスのマップへ飛ぶ
    global data
    data["mapIndex"] = ind
    for i in range(len(data["mapEvent"][ind])):
        for j in range(len(data["mapEvent"][ind][0])):
            if(data["mapEvent"][ind][i][j] == -(ind+1)):
                data["x"] = j+0.5
                data["y"] = i+0.5
    playSe()


mapTitle = ["村", "森1", "森2", "森3", "洞窟1", "洞窟2", "洞窟2-2",
            "洞窟3", "洞窟4", "草原", "空1", "空2", "空3", "魔女の家"]
"""ワープ用マップタイトル"""

moveMaps = [
    lambda: mapTo(0),
    lambda: mapTo(1),
    lambda: mapTo(2),
    lambda: mapTo(3),
    lambda: mapTo(5),
    lambda: mapTo(6),
    lambda: mapTo(7),
    lambda: mapTo(8),
    lambda: mapTo(9),
    lambda: mapTo(10),
    lambda: mapTo(11),
    lambda: mapTo(12),
    lambda: mapTo(13),
    lambda: mapTo(14)
]
"""ワープ用関数リスト"""

btn5 = [tk.Button(w, text=mapTitle[i], command=moveMaps[i], width=25,
                  font=("Yu Gothic UI Semilight", 15)) for i in range(len(mapTitle))]
"""ワープ用ボタンリスト"""

mapTitleAll = ["村", "森1", "森2", "森3", "洞窟3-2", "洞窟1", "洞窟2",
               "洞窟2-2", "洞窟3", "洞窟4", "草原", "空1", "空2", "空3", "魔女の家"]
"""マップ名表示用マップタイトル"""

jobTitle = ["剣士", "ヒーラー", "アーチャー", "魔法使い"]
"""職業名のリスト"""

showingSerihu = False
"""セリフ表示するときにTrue"""

serihu = ""
"""表示するセリフ"""

showingJob = False
"""転職屋を開いているかどうか"""

def setJob(j1, j2): # 指定した職業(1~4)に設定する
    global showingJob
    for i, j in enumerate([j1, j2]):
        data["job"][i] = j
        data["waza"][i] = []
        if j == 1:
            data["waza"][i] += [[1, "剣殴り", 0.5]]
            if data["jobLv"][j-1] >= 10:
                data["waza"][i] += [[1, "回転切り", 0.7]]
            if data["jobLv"][j-1] >= 20:
                data["waza"][i] += [[1, "大剣切り", 1]]
            if data["jobLv"][j-1] >= 40:
                data["waza"][i] += [[1, "木端微塵切り", 1.5]]
            if data["jobLv"][j-1] >= 60:
                data["waza"][i] += [[1, "なんかすごい切り方", 2]]
        elif j == 2:
            data["waza"][i] += [[2, "ヒール", 1]]
            if data["jobLv"][j-1] >= 10:
                data["waza"][i] += [[3, "ハイヒール", 4, 5]]
            if data["jobLv"][j-1] >= 20:
                data["waza"][i] += [[4, "ハイパーヒール", 4, 5]]
            if data["jobLv"][j-1] >= 40:
                data["waza"][i] += [[4, "スーパーヒール", 4, 8]]
            if data["jobLv"][j-1] >= 60:
                data["waza"][i] += [[4, "スゲーヒール", 100, 10]]
        elif j == 3:
            data["waza"][i] += [[1, "アローショット", 0.5]]
            if data["jobLv"][j-1] >= 10:
                data["waza"][i] += [[5, "毒矢", 4, 0.4]]
            if data["jobLv"][j-1] >= 20:
                data["waza"][i] += [[6, "ArrowとArrayって似てる", 2]]
            if data["jobLv"][j-1] >= 40:
                data["waza"][i] += [[1, "3連射", 1.5]]
            if data["jobLv"][j-1] >= 60:
                data["waza"][i] += [[7, "ネクスト", 2.5]]
        elif j == 4:
            data["waza"][i] += [[10, "イートヘルス", 0.5]]
            if data["jobLv"][j-1] >= 10:
                data["waza"][i] += [[5, "ポイズン", 5, 0.5]]
            if data["jobLv"][j-1] >= 20:
                data["waza"][i] += [[1, "魔法弾", 1.5]]
            if data["jobLv"][j-1] >= 40:
                data["waza"][i] += [[8, "混乱", 0.5]]
            if data["jobLv"][j-1] >= 60:
                data["waza"][i] += [[9, "サイコロdieス", 7, 1]]
    for i in btn6:
        i.place_forget()
    showingJob = False
    playSe()


set2Job = [
    lambda:setJob(1, 2),
    lambda:setJob(2, 3),
    lambda:setJob(3, 1),
    lambda:setJob(4, 1),
    lambda:setJob(4, 2),
    lambda:setJob(4, 3)
]
"""転職屋用関数リスト"""

jobs = ["剣士とヒーラー", "ヒーラーとアーチャー", "アーチャーと剣士",
        "魔法使いと剣士", "魔法使いとヒーラー", "魔法使いとアーチャー"]
"""転職屋用ボタン名リスト"""

btn6 = [tk.Button(w, text=jobs[i], command=set2Job[i], width=25,
                  font=("Yu Gothic UI Semilight", 15)) for i in range(len(jobs))]
"""転職屋用ボタン"""

itemTitle = ["ドリル", "火炎放射器", "回復ポーション", "MPポーション", "パワーポーション", "革の上着", "革のズボン", "木の剣", "普通の弓", "木の杖",
             "鉄の鎧", "鉄のズボン", "鉄の剣", "ぷよぷよボール銃", "不思議な杖", "MPオーブ", "ポテトの鎧", "ポテトのズボン", "じゃがいも", "風船", "ポテチの袋", "僕", "買えるもんなら買ってみな"]
"""アイテム名リスト"""

itemImage = [tk.PhotoImage(file=f"ki{i}.png") for i in range(2)]+[tk.PhotoImage(
    file=f"p{i}.png") for i in range(3)]+[tk.PhotoImage(file=f"i{i}.png") for i in range(18)]
"""アイテムの画像リスト"""

itemPrice = [-1, -1]+[[i for i in range(5, 56, 5)]]+[[i for i in range(5, 56, 5)]]+[[i for i in range(
    5, 56, 5)]]+[15, 15, 15, 15, 15, 100, 100, 100, 100, 100, 50, 400, 400, 500, 600, 600, 800, 10000000]
"""アイテムの売れる値段"""

itemDesc = [["岩も多分掘れるポテト"], ["火を噴くポテト君"]]+[[f"HPを{i}回復" for i in range(
    5, 69, 7)]]+[[f"MPを{i}回復" for i in range(5, 98, 10)]]+[[f"次のターン攻撃力{i}追加" for i in range(5, 76, 7)]]+["HPを5追加", "HPを5追加", "剣士の攻撃力3追加", "アーチャーの攻撃力3追加", "ヒーラー/魔法使いの攻撃力3追加", "HPを10追加", "HPを10追加", "剣士の攻撃力6追加",
                                                                                                         "アーチャーの攻撃力6追加", "ヒーラー/魔法使いの攻撃力6追加", "MPを20追加", "HPとMPを20追加", "HPとMPを20追加",
                                                                                                         "攻撃力20追加", "HPとMPを30追加", "HPとMPを30追加",
                                                                                                         "攻撃力30追加", "攻撃力100000追加"]
"""アイテムの説明文リスト"""

itemPower = [-1, -1]+[[[1, i] for i in range(5, 69, 7)]]+[[[2, i]
                                                           for i in range(5, 98, 10)]]+[[[3, i] for i in range(5, 76, 7)]]+[[1, 5], [1, 5], [2, 3], [3, 3], [4, 3], [1, 10], [1, 10], [2, 6], [3, 6], [4, 6],
                                                                                                                            [5, 20], [6, 20], [6, 20], [7, 15], [6, 30], [6, 30], [7, 30], [7, 100000]]
"""アイテムの効果リスト"""

soubi = ttk.Combobox(w, state="readonly")
"""装備のドロップダウンリスト"""

def setSoubi(ind): # 指定した位置(0:鎧 1:ズボン 2:武器)に選択している装備を着る
    global index
    if(soubi.current() == 0):
        return
    if(data["soubi"][ind] != 0):
        power = itemPower[data["soubi"][ind]]
        if(power[0] == 1):
            data["HPmax"] -= power[1]
        elif(power[0] in [2, 3]):
            data["jobPower"][power[0]-2] -= power[1]
        elif(power[0] == 4):
            data["jobPower"][2] -= power[1]
            data["jobPower"][3] -= power[1]
        elif(power[0] == 5):
            data["MPmax"] -= power[1]
        elif(power[0] == 6):
            data["HPmax"] -= power[1]
            data["MPmax"] -= power[1]
        elif(power[0] == 7):
            data["power"] -= power[1]
        data["bag"][1] += [data["soubi"][ind]]
    if(soubi.current() == 1):
        data["soubi"][ind] = 0
    else:
        data["soubi"][ind] = data["bag"][1][soubi.current()-2]
        del data["bag"][1][soubi.current()-2]
        power = itemPower[data["soubi"][ind]]
        if(power[0] == 1):
            data["HPmax"] += power[1]
        elif(power[0] in [2, 3]):
            data["jobPower"][power[0]-2] += power[1]
        elif(power[0] == 4):
            data["jobPower"][2] += power[1]
            data["jobPower"][3] += power[1]
        elif(power[0] == 5):
            data["MPmax"] += power[1]
        elif(power[0] == 6):
            data["HPmax"] += power[1]
            data["MPmax"] += power[1]
        elif(power[0] == 7):
            data["power"] += power[1]
    if(data["HP"] > data["HPmax"]):
        data["HP"] = data["HPmax"]
    if(data["MP"] > data["MPmax"]):
        data["MP"] = data["MPmax"]
    soubi.current(0)
    index = 13
    playSe()


setSoubiArray = [
    lambda: setSoubi(0),
    lambda: setSoubi(1),
    lambda: setSoubi(2)
]
"""装備設定用関数リスト"""

btn7Title = ["鎧に装備", "ズボンに装備", "武器に装備"]
"""装備設定用ボタン名リスト"""

btn7 = [tk.Button(w, text=btn7Title[i], command=setSoubiArray[i], width=25,
                  font=("Yu Gothic UI Semilight", 15)) for i in range(3)]
"""装備設定用ボタンリスト"""

item = ttk.Combobox(w, state="readonly")
"""アイテムのドロップダウンリスト"""

def useItem(): # 選択したアイテムを使用する
    global index
    if(item.current() != 0 and data["bag"][0][item.current()-1][0] not in [0, 1]):
        if(data["bag"][0][item.current()-1][0] == 2):
            data["HP"] += itemPower[2][data["bag"][0][item.current()-1][1]][1]
        if(data["bag"][0][item.current()-1][0] == 3):
            data["MP"] += itemPower[3][data["bag"][0][item.current()-1][1]][1]
        del data["bag"][0][item.current()-1]
        playSe()
    if(data["HP"] > data["HPmax"]):
        data["HP"] = data["HPmax"]
    if(data["MP"] > data["MPmax"]):
        data["MP"] = data["MPmax"]
    index = 13


btn8 = tk.Button(w, text="アイテムを使用", command=useItem, width=25,
                 font=("Yu Gothic UI Semilight", 15))
"""アイテム使用ボタン"""

modeBuy = False
"""ショップのモード"""

def changeMode(): # modeBuyの切り替え
    global modeBuy, index
    modeBuy = not modeBuy
    index = 15
    playSe()


btn9 = tk.Button(w, text="モード変更", command=changeMode,
                 width=25, font=("Yu Gothic UI Semilight", 15))
"""ショップのモード変更ボタン"""

def sell_s(): # 装備を売る
    global index
    if(soubi.current() != 0):
        data["money"] += itemPrice[data["bag"][1][soubi.current()-1]]
        del data["bag"][1][soubi.current()-1]
        playSe()
        index = 15


def sell_i(): # アイテムを売る
    global index
    if(item.current() != 0 and data["bag"][0][item.current()-1][0] not in [0, 1]):
        data["money"] += itemPrice[data["bag"][0]
                                   [item.current()-1][0]][data["bag"][0][item.current()-1][1]]
        del data["bag"][0][item.current()-1]
        playSe()
        index = 15


btn10 = [
    tk.Button(w, text="この装備を売る", command=sell_s, width=25,
              font=("Yu Gothic UI Semilight", 15)),
    tk.Button(w, text="このアイテムを売る", command=sell_i,
              width=25, font=("Yu Gothic UI Semilight", 15))
]
"""売却用ボタン"""


def buy_s(): # 装備を買う
    global index
    if(soubi.current() != 0):
        if(data["money"] < int(itemPrice[5+soubi.current()-1]*1.1)):
            return
        data["money"] -= int(itemPrice[5+soubi.current()-1]*1.1)
        data["bag"][1] += [5+soubi.current()-1]
        playSe()
        index = 15


def buy_i(): # アイテムを買う
    global index
    if(item.current() != 0):
        if(data["money"] < int(itemPrice[2+(item.current()-1)//10][(item.current()-1) % 10]*1.1)):
            return
        data["money"] -= int(itemPrice[2+(item.current()-1)//10]
                             [(item.current()-1) % 10]*1.1)
        data["bag"][0] += [[2+(item.current()-1)//10, (item.current()-1) % 10]]
        playSe()
        index = 15


btn11 = [
    tk.Button(w, text="この装備を買う", command=buy_s, width=25,
              font=("Yu Gothic UI Semilight", 15)),
    tk.Button(w, text="このアイテムを買う", command=buy_i, width=25,
              font=("Yu Gothic UI Semilight", 15))
]
"""購入用ボタン"""

mapLv = [[0, 0], [1, 1], [1, 2], [2, 3], [2, 3], [3, 4], [4, 5], [
    4, 5], [5, 6], [5, 6], [5, 6], [6, 7], [7, 8], [7, 8], [7, 8]]
"""マップのレベルリスト[最小,最大]"""

nowEnemy = {}
"""現在戦っている敵"""

enemyImage = [tk.PhotoImage(file=f"m{i}.png") for i in range(19)]
"""敵の画像リスト"""

enemyHP = [[5, 5], [7, 15], [25, 40], [60, 80], [80, 130], [200, 400],
           [300, 600], [600, 1000], [100, 100], [500, 500], [2000, 2000]]
"""各レベルの敵のHP"""

enemyPower = [[2, 2], [3, 5], [4, 6], [7, 10], [9, 15], [
    20, 25], [20, 40], [40, 60], [6, 6], [15, 15], [70, 70]]
"""各レベルの敵の攻撃力"""

dropPote = [[10, 10], [10, 20], [20, 40], [40, 50], [50, 60], [
    60, 70], [70, 90], [90, 110], [100, 100], [200, 200], [500, 500]]
"""各レベルの敵の落とす金"""

dropKeiken = [[3, 5], [5, 8], [8, 10], [10, 20], [20, 35], [
    35, 50], [50, 70], [60, 80], [20, 20], [50, 50], [100, 100]]
"""各レベルの敵の落とす経験値"""

enemyName = ["ポテトのなる木", "バグポテト", "魔女", "腐ったポテト", "キーボード塗りッシャー", "マッチョポテェ", "弓使いポテェ", "激辛ポテェ", "ナイフ持ったポテト",
             "揚げたて激熱ポテェ", "魔法使いポテト", "ポテト使いポテト", "暑さで溶けポテェ", "毒ポテト", "岩ポテト", "flyドポテト", "リアルポテト", "リアルポテト君", "もう名前思いつかない君"]
"""敵の名前リスト"""

enemyWaza = [
    [[1, "大暴れ", 2], [2, "収穫期", 10], [3, "リーフカッター", 3, 0.7]],
    [[1, "見えない武器", 2],[1, "見えない武器", 2], [4, "HP増加", 20], [5, "不思議な力", 3]],
    [[1, "魔法弾", 2],[1, "魔法弾", 2], [6, "弱体化魔法", 3, 40], [7, "HP吸収", 1]],
    [[1, "殴り", 1]],
    [[1, "キーボード投げ", 1], [1, "キーボード投げ", 1], [8, "カモフラージュ", 50]],
    [[1, "パンチ", 1], [1, "パンチ", 1], [5, "筋トレ", 2]],
    [[1, "アローショット", 1], [1, "アローショット", 1], [9, "毒矢", 3]],
    [[1, "ポテト投げ", 1], [1, "ポテト投げ", 1], [9, "辛味", 3]],
    [[1, "ナイフ投げ", 1], [1, "ナイフ投げ", 1], [1, "ナイフ連射", 1.5]],
    [[9, "やけど", 3], [9, "やけど", 3], [10, "夏バテ", 15]],
    [[7, "イートヘルス", 0.6], [1, "魔法弾", 1.5], [1, "魔法弾", 1.5]],
    [[2, "イートポテト", 10], [1, "ポテト投げ", 1], [1, "ポテト投げ", 1]],
    [[9, "猛暑", 4], [2, "クーラー", 10]],
    [[9, "ポイズン", 4], [1, "毒", 1]],
    [[1, "体当たり", 1.5]],
    [[1, "ポテト落下", 1.5], [1, "ポテト落下", 1.5], [8, "飛行", 60]],
    [[1, "ポテトガン", 1.5], [1, "ポテトガン", 1.5], [2, "おいしい", 15]],
    [[1, "ポテェ", 2],[1, "ポテェ", 2],[1, "ポテェ", 2], [11, "プログラムのバグ"]],
    [[1, "なんかの攻撃", 1.5], [1, "すごい攻撃", 2]]
]
"""敵の技リスト[攻撃方法,技の名前(,効果1,効果2)]"""

nowEnemy = {"index": 0, "HP": 0, "HPmax": 0, "power": 0,
            "Lv": 1, "turnHP": [], "turnPower": [], "kaihi": 0}
"""戦闘中の敵"""

nowPlayer = {"turnHP": [], "turnPower": []}
"""戦闘中のプレイヤー情報"""

waza = ttk.Combobox(w, state="readonly")
"""技のドロップダウンリスト"""

turn = 1
"""先頭のターン"""

hpChange_p = 0
"""プレイヤーのHPの変化(前-後)"""
hpChange_e = 0
"""敵のHPの変化(前-後)"""
wazaSerihu = ""
"""技を発動したときのセリフ"""


def useItem_s(): # アイテム使用(戦闘中)
    global index, turn, hpChange_e, hpChange_p, wazaSerihu
    if turn == 0 or index == 20:
        return
    hpChange_p = data["HP"]
    hpChange_e = nowEnemy["HP"]
    if(item.current() != 0 and data["bag"][0][item.current()-1][0] not in [0, 1]):
        wazaSerihu = f"{item.get()}を使用した"
        if(data["bag"][0][item.current()-1][0] == 2):
            data["HP"] += itemPower[2][data["bag"][0][item.current()-1][1]][1]
        if(data["bag"][0][item.current()-1][0] == 3):
            data["MP"] += itemPower[3][data["bag"][0][item.current()-1][1]][1]
        if(data["bag"][0][item.current()-1][0] == 4):
            try:
                nowPlayer["turnPower"][0] += itemPower[2][data["bag"]
                                                          [0][item.current()-1][1]][1]
            except:
                nowPlayer["turnPower"] += [itemPower[2]
                                           [data["bag"][0][item.current()-1][1]][1]]
        del data["bag"][0][item.current()-1]
        if(data["MP"] > data["MPmax"]):
            data["MP"] = data["MPmax"]
        if(len(nowEnemy["turnHP"]) >= 1):
            nowEnemy["HP"] += nowEnemy["turnHP"][0]
            del nowEnemy["turnHP"][0]
        if(len(nowPlayer["turnHP"]) >= 1):
            data["HP"] += nowPlayer["turnHP"][0]
            del nowPlayer["turnHP"][0]
        if(data["HP"] > data["HPmax"]):
            data["HP"] = data["HPmax"]
        if(data["HP"] < 0):
            data["HP"] = 0
        if(nowEnemy["HP"] > nowEnemy["HPmax"]):
            nowEnemy["HP"] = nowEnemy["HPmax"]
        if(nowEnemy["HP"] < 0):
            nowEnemy["HP"] = 0
        hpChange_p -= data["HP"]
        hpChange_e -= nowEnemy["HP"]
        item.current(0)
        playSe()
        item["values"] = ("アイテムを選択",) + tuple(
            (f"{itemTitle[data['bag'][0][i][0]]}-Lv{data['bag'][0][i][1]}" for i in range(len(data["bag"][0]))))
        index = 20
        turn = (turn+1) % 3


def useWaza(): # 技の使用
    global index, turn, hpChange_p, hpChange_e, wazaSerihu
    if waza.current() == 0 or index == 20 or turn == 0:
        return
    hpChange_p = data["HP"]
    hpChange_e = nowEnemy["HP"]
    jobPower = [data["jobPower"][data["job"][0]-1],
                data["jobPower"][data["job"][1]-1]]
    jobIndex = 0
    wazaIndex = waza.current()-1
    if wazaIndex >= len(data["waza"][0]):
        jobIndex = 1
        wazaIndex -= len(data["waza"][0])
    nowWaza = data["waza"][jobIndex][wazaIndex]
    MPneed = 1 if wazaIndex == 0 else 3 if wazaIndex == 1 else 7 if wazaIndex == 2 else 15 if wazaIndex == 3 else 30
    if data["MP"]-MPneed < 0:
        return
    wazaSerihu = f"{data['name']}は\n{nowWaza[1]}をした"
    data["MP"] -= MPneed
    turnPower = 0
    try:
        turnPower = nowPlayer["turnPower"][0]
        del nowPlayer["turnPower"][0]
    except:
        pass
    if rnd(1, 100) < nowEnemy["kaihi"]:
        pass
    elif nowWaza[0] == 1:
        nowEnemy["HP"] -= int((data["power"] +
                              jobPower[jobIndex]+turnPower)*nowWaza[2])
    elif nowWaza[0] == 2:
        data["HP"] += int((data["power"]+jobPower[jobIndex] +
                          turnPower)*nowWaza[2])
    elif nowWaza[0] == 3:
        for i in range(nowWaza[2]):
            try:
                nowPlayer["turnHP"][i] += nowWaza[3]
            except:
                nowPlayer["turnHP"] += [nowWaza[3]]
    elif nowWaza[0] == 4:
        for i in range(nowWaza[2]):
            try:
                nowPlayer["turnHP"][i] += nowWaza[3]
            except:
                nowPlayer["turnHP"] += [nowWaza[3]]
        for i in range(nowWaza[2]):
            try:
                nowEnemy["turnHP"][i] -= nowWaza[3]
            except:
                nowEnemy["turnHP"] += [-nowWaza[3]]
    elif nowWaza[0] == 5:
        for i in range(nowWaza[2]):
            try:
                nowEnemy["turnHP"][i] -= int((data["power"] +
                                             jobPower[jobIndex]+turnPower)*nowWaza[3])
            except:
                nowEnemy["turnHP"] += [-int((data["power"] +
                                            jobPower[jobIndex]+turnPower)*nowWaza[3])]
    elif nowWaza[0] == 6:
        try:
            nowPlayer["turnPower"][0] += data["power"]+jobPower[jobIndex]
        except:
            nowPlayer["turnPower"] += [data["power"]+jobPower[jobIndex]]
    elif nowWaza[0] == 7:
        try:
            nowEnemy["turnHP"][0] += 0
        except:
            nowEnemy["turnHP"] += [0]
        try:
            nowEnemy["turnHP"][1] -= int((data["power"] +
                                         jobPower[jobIndex]+turnPower)*nowWaza[2])
        except:
            nowEnemy["turnHP"] += [-int((data["power"] +
                                        jobPower[jobIndex]+turnPower)*nowWaza[2])]
    elif nowWaza[0] == 8:
        try:
            nowEnemy["turnPower"][0] += 0
        except:
            nowEnemy["turnPower"] += [0]
        nowEnemy["turnPower"][0] -= int((nowEnemy["power"] +
                                     nowEnemy["turnPower"][0])*nowWaza[2])
    elif nowWaza[0] == 9:
        nowEnemy["HP"] -= int((data["power"] +
                              jobPower[jobIndex]+turnPower)*nowWaza[3])
        if(rnd(1, 100) == nowWaza[2]):
            nowEnemy["HP"] = 0
    elif nowWaza[0] == 10:
        nowEnemy["HP"] -= int((data["power"] +
                              jobPower[jobIndex]+turnPower)*nowWaza[2])
        data["HP"] += int((data["power"]+jobPower[jobIndex] +
                          turnPower)*nowWaza[2])
    if(len(nowEnemy["turnHP"]) >= 1):
        nowEnemy["HP"] += nowEnemy["turnHP"][0]
        del nowEnemy["turnHP"][0]
    if(len(nowPlayer["turnHP"]) >= 1):
        data["HP"] += nowPlayer["turnHP"][0]
        del nowPlayer["turnHP"][0]
    nowEnemy["kaihi"] = 0
    if(data["HP"] > data["HPmax"]):
        data["HP"] = data["HPmax"]
    if(data["HP"] < 0):
        data["HP"] = 0
    if(nowEnemy["HP"] > nowEnemy["HPmax"]):
        nowEnemy["HP"] = nowEnemy["HPmax"]
    if(nowEnemy["HP"] < 0):
        nowEnemy["HP"] = 0
    hpChange_p -= data["HP"]
    hpChange_e -= nowEnemy["HP"]
    playSe()
    index = 20
    turn = (turn+1) % 3


btn12 = tk.Button(w, text="アイテムを使用", command=useItem_s, width=15,
                  font=("Yu Gothic UI Semilight", 15))
"""戦闘用のアイテム使用ボタン"""

btn13 = tk.Button(w, text="技を使う", command=useWaza, width=15,
                  font=("Yu Gothic UI Semilight", 15))
"""戦闘用の技使用ボタン"""

def escapeButtle(): # 「逃げる」コマンド
    global index
    if index != 19:
        return
    c.delete("show")
    c.delete("show2")
    item.place_forget()
    waza.place_forget()
    btn14.place_forget()
    btn13.place_forget()
    btn12.place_forget()
    index = 8


btn14 = tk.Button(w, text="逃げる", command=escapeButtle, width=15,
                  font=("Yu Gothic UI Semilight", 15))
"""戦闘用「逃げる」ボタン"""

mapEnemy = [0, 5, 7, 3, 0, 7, 5, 0, 3, 6, 0, 7, 8, 8, 0]
"""各マップでの敵の出やすさ"""

def main():
    global index, mouseX, mouseY, nowPress, key, timer, c, nowRelease, titleImg, btn1, bgmVol, scl, scl2, bgmCh
    global bgmSo, toSetFrom, serihuIndex, playerNow, btn5, showingSerihu, serihu, showingJob, modeBuy, nowEnemy, turn
    global wazaSerihu, hpChange_e, hpChange_p
    if index == 0:  # bgmを鳴らす
        titleImg = tk.PhotoImage(file="title.png")
        index += 1
        bgmCh = bgmSo.play(-1)
        bgmCh.set_volume(bgmVol)
        seCh.set_volume(seVol)
    elif index == 1:  # タイトル画面の表示 indexは2でループ
        c.create_image(450, 300, image=titleImg, tag="show")
        for i, btn in enumerate(btn1):
            btn.place(x=250, y=200+80*i)
        comb["values"] = ("セーブデータを選択",) + \
            tuple((f"{i['name']}-{i['Lv']}Lv" for i in settings["saves"]))
        comb.place(x=250, y=180)
        index += 1
    elif index == 3:  # 設定の表示、4でループ
        for btn in btn1:
            btn.place_forget()
        comb.place_forget()
        c.delete("show")
        gm.text(c, 130, 80, "BGM", "black", 15)
        gm.text(c, 130, 180, "SE", "black", 15)
        gm.text(
            c, 750, 130, "キー操作\n移動  wasd\nアクション  Enter\nメニュー  Esc\n戻る  Esc", "black", 15)
        scl.place(x=200, y=50)
        scl2.place(x=200, y=150)
        for i, btn in enumerate(btn2):
            btn.place(x=250, y=400+80*i)
        index += 1
    elif index == 4:  # 設定、Escで戻る
        if key == "Escape":
            index = toSetFrom-1
            scl.place_forget()
            scl2.place_forget()
            for btn in btn2:
                btn.place_forget()
            playSe()
            c.delete("show")
    elif index == 7:  # 初期イベント(イベント0)
        c.delete("show")
        if(not data["event"][0]):
            index += 1
            timer += 1
            key = 0
            w.after(10, main)
            return
        if serihuIndex <= 9:
            c.create_rectangle(0, 0, 900, 600, fill="black", tag="show")
            gm.showSerihu(c, gm.serihu1[serihuIndex])
            c.create_image(450, 250, image=soncho, tag="show")
            c.create_image(250, 250, image=potekun[1], tag="show")
        elif serihuIndex == 10:
            playerNow = potekun[0]
            showMap()
            c.create_image(450, 250, image=soncho, tag="show")
        elif serihuIndex <= 31:
            playerNow = potekun[1]
            showMap()
            c.create_image(450, 250, image=soncho, tag="show")
            gm.showSerihu(c, gm.serihu2[serihuIndex-11])
        elif serihuIndex == 32:
            for i, btn in enumerate(btn3):
                btn.place(x=250, y=100+80*i)
        elif serihuIndex <= 39:
            for btn in btn3:
                btn.place_forget()
            playerNow = potekun[1]
            showMap()
            c.create_image(450, 250, image=soncho, tag="show")
            gm.showSerihu(c, gm.serihu3[serihuIndex-33])
        else:
            index += 1
            serihuIndex = 0
            data["event"][0] = False
        if (key == "Return" and serihuIndex != 32):
            serihuIndex += 1
            playSe()
    elif index == 8:  # ゲーム画面
        c.delete("show")
        breaking = True
        # 移動イベント

        def getEve(): return data["mapEvent"][data["mapIndex"]][int(
            data["y"])][int(data["x"])]
        if(getEve() < -20 and (-getEve()) % 2 == 1):
            fromMap = data["mapIndex"]
            telIndex = getEve()
            for m in range(len(data["maps"])):
                data["mapIndex"] = m
                finished = False
                if(m == fromMap):
                    continue
                for i, rowArray in enumerate(data["mapEvent"][data["mapIndex"]]):
                    for j, cell in enumerate(rowArray):
                        if(cell == telIndex-1):
                            data["x"] = j+0.5
                            data["y"] = i+0.5
                            if(m >= 4):
                                m -= 1
                            data["visited"][m] = True
                            finished = True
                if(finished):
                    break
        else:
            breaking = False
        if(breaking):
            timer += 1
            key = 0
            w.after(10, main)
            return
        breaking = True
        # 会話イベント
        if(data["mapIndex"] == 0):
            if(data["event"][1] and data["x"] > 6):
                showMap()
                gm.showSerihu(c, "村長「上にあるのはショップじゃ\nアイテムや装備を売買できるぞ」")
                if(key == "Return"):
                    data["event"][1] = False
                    playSe()
            elif(data["event"][2] and data["x"] > 9):
                showMap()
                gm.showSerihu(c, "村長「下にあるのは転職屋じゃ\nここで職業を変えられるぞ」")
                if(key == "Return"):
                    data["event"][2] = False
                    playSe()
            elif(data["event"][3] and data["x"] > 14):
                showMap()
                gm.showSerihu(c, "村長「ここは畑じゃ\n金を植えると金になるぞ」")
                if(key == "Return"):
                    data["event"][3] = False
                    playSe()
            elif(data["event"][4] and data["y"] < 3):
                showMap()
                gm.showSerihu(c, "村長「上に行くと森がある\n準備ができたら行ってみるのじゃ」")
                if(key == "Return"):
                    data["event"][4] = False
                    playSe()
            else:
                breaking = False
        elif data["mapIndex"] == 1:
            if(data["event"][5] and data["y"] < 19):
                showMap()
                serihu = ["村長「ここにはモンスターがいるから、戦闘について教えるぞ」",
                          "村長「戦闘は自分2ターン、敵1ターンを繰り返して行う」",
                          "村長「1ターン中に攻撃かアイテムの使用ができるぞ」",
                          "村長「逃げてもいいが、経験値とかは入らないぞ」"
                          ]
                gm.showSerihu(c, serihu[serihuIndex])
                if(key == "Return"):
                    serihuIndex += 1
                    playSe()
                if(serihuIndex == 4):
                    serihuIndex = 0
                    data["event"][5] = False
            elif(data["event"][6] and data["y"] < 17):
                showMap()
                gm.showSerihu(c, "村長「もしかしたら宝箱があるかもしれないから\nよく探すといいぞ」")
                if(key == "Return"):
                    data["event"][6] = False
                    playSe()
            else:
                breaking = False
        elif data["mapIndex"] == 2:
            if(data["event"][7] and data["y"] < 21):
                showMap()
                gm.showSerihu(c, "村長「宝箱からモンスターがでてくることもあるから\n気を付けるんじゃぞ」")
                if(key == "Return"):
                    data["event"][7] = False
                    playSe()
            elif(data["event"][8] and data["y"] < 6 and data["x"] < 8):
                showMap()
                gm.showSerihu(c, "村長「この先は何か掘るものがないと進めないようじゃ」")
                if(key == "Return"):
                    data["event"][8] = False
                    playSe()
            else:
                breaking = False
        elif data["mapIndex"] == 2:
            if(data["event"][9] and data["y"] < 17):
                showMap()
                gm.showSerihu(c, "村長「もしかしたら隠し通路が...?」")
                if(key == "Return"):
                    data["event"][9] = False
                    playSe()
            elif(data["event"][10] and data["maps"][2][4][17] != 11):
                showMap()
                gm.showSerihu(
                    c, "村長「戦利品の'ドリル'を持っている状態で\nEnterを押したら壊れる壁があるかもしれんぞ」")
                if(key == "Return"):
                    data["event"][10] = False
                    playSe()
            else:
                breaking = False
        elif data["mapIndex"] == 10:
            if(data["event"][11] and data["y"] < 10):
                serihu = ["なんだ!?",
                          "「ズドドドドドドド」",
                          "目の前がポテトだらけで通れない!魔女のしわざか!?",
                          "村長「ごめんごめん、間違えてPotezon買いすぎちゃった☆」",
                          "お前のせいかよ!!!!",
                          "村長「空からもいけるから許して?」",
                          "え?"]
                if(serihuIndex == 0):
                    showMap()
                    gm.showSerihu(c, serihu[serihuIndex])
                elif(serihuIndex == 1):
                    c.create_rectangle(
                        0, 0, 900, 600, fill="black", tag="show")
                    for i in range(len(data["maps"][10])):
                        for j in range(len(data["maps"][10][0])):
                            if(data["maps"][10][i][j] == 16):
                                data["maps"][10][i][j] = 17
                    gm.showSerihu(c, serihu[serihuIndex])
                elif(serihuIndex < 7):
                    showMap()
                    gm.showSerihu(c, serihu[serihuIndex])
                if(key == "Return"):
                    serihuIndex += 1
                    playSe()
                if(serihuIndex == 7):
                    serihuIndex = 0
                    data["mapIndex"] = 11
                    data["visited"][10]=True
                    data["y"] = 23.5
                    data["x"] = 15.5
                    data["event"][11] = False
            else:
                breaking = False
        elif data["mapIndex"] == 14:
            if(data["event"][13] and data["maps"][14][8][5] != 20):
                serihu = ["魔女「うわぁぁやられちゃぁぁぁぁぁ」",
                          "よし、勝ったな",
                          "村長「うわああああ戻っちゃぁぁぁぁぁ」",
                          "び、びっくりした",
                          "村長「戻してくれて感謝するぞ」",
                          "ポテトじゃない姿見せてくれないんですか?",
                          "村長「画像用意してないから無理」",
                          "ソーナンデスネー",
                          "村長「じゃあストーリー全部終わったからあとは\nなんかてきとうに遊んでね」"
                          ]
                showMap()
                gm.showSerihu(c, serihu[serihuIndex])
                if(key == "Return"):
                    serihuIndex += 1
                    playSe()
                if(serihuIndex == 9):
                    serihuIndex = 0
                    data["event"][13] = False
            elif(data["event"][12]):
                serihu = ["魔女「よくここまでたどり着いたな...\nいや勇者が来ないゲームとかないか」",
                          "あ、そっすね",
                          "魔女「それより、ポテトの姿から戻りたいんじゃないか?」",
                          "僕は元々ポテトなので",
                          "魔女「...」",
                          "魔女「シナリオ思いつかないからもう戦闘入るね」"
                          ]
                showMap()
                gm.showSerihu(c, serihu[serihuIndex])
                if key == "Return":
                    serihuIndex += 1
                    playSe()
                if(serihuIndex == 6):
                    serihuIndex = 0
                    data["event"][12] = False
                    index = 17
                    nowEnemy["Lv"] = 11
                    nowEnemy["index"] = 2
            else:
                breaking = False
        else:
            breaking = False
        if(breaking):
            timer += 1
            key = 0
            w.after(10, main)
            return
        breaking = True
        if(showingSerihu):
            showMap()
            gm.showSerihu(c, serihu)
            if(key == "Return"):
                showingSerihu = False
        else:
            breaking = False
        if(breaking):
            timer += 1
            key = 0
            w.after(10, main)
            return
        # 各タイルでのイベント
        breaking = True
        if(getEve() == 5):
            for i, btn in enumerate(btn5[0:8]):
                if data["visited"][i]:
                    btn.place(x=100, y=50+50*i)
            for i, btn in enumerate(btn5[8:]):
                if data["visited"][8+i]:
                    btn.place(x=400, y=50+50*i)
        elif(key == "Return"):
            if(getEve() == 2):
                playSe()
                showMap()
                serihu = "HPとMPが全回復した"
                data["HP"] = data["HPmax"]
                data["MP"] = data["MPmax"]
                showingSerihu = True
            elif(getEve() == 7):
                playSe()
                showMap()
                for i, btn in enumerate(btn6[:3]):
                    btn.place(x=300, y=50+50*i)
                if data["Lv"] >= 20:
                    for i, btn in enumerate(btn6[3:]):
                        btn.place(x=300, y=50+50*(i+3))
                showingJob = True
            elif(getEve() == 4):
                playSe()
                showMap()
                showingSerihu = True
                serihu = f"{data['farm']}ポテトをゲットした"
                data["money"] += data["farm"]
                data["farm"] = 0
            elif(getEve() == 3):
                playSe()
                index = 15
            elif(getEve() == 8):
                showMap()
                showingSerihu = True
                getPote = 5 + \
                    rnd(max(mapLv[data["mapIndex"]])-1,
                        max(mapLv[data["mapIndex"]])+1)*10
                serihu = f"{getPote}ポテトを手に入れた"
                data["money"] += getPote
                hakoPos = (1, 1)
                for i in range(3):
                    for j in range(3):
                        if(data["maps"][data["mapIndex"]][int(data["y"])+i-1][int(data["x"])+j-1] == 8):
                            hakoPos = (int(data["x"])+j-1, int(data["y"])+i-1)
                data["maps"][data["mapIndex"]][hakoPos[1]][hakoPos[0]] = 1
                for i in range(3):
                    for j in range(3):
                        if(data["mapEvent"][data["mapIndex"]][hakoPos[1]+i-1][hakoPos[0]+j-1] == 8):
                            data["mapEvent"][data["mapIndex"]
                                             ][hakoPos[1]+i-1][hakoPos[0]+j-1] = 0
                playSe()
            elif getEve() == 13:
                data["HP"] = data["HPmax"]
                data["MP"] = data["MPmax"]
                playSe()
            elif(getEve() == 10):
                index = 17
                lv = choice(mapLv[data["mapIndex"]])
                nowEnemy["Lv"] = lv
                nowEnemy["index"] = 3+(lv-1)*2+rnd(0, 1)
                hakoPos = (1, 1)
                for i in range(3):
                    for j in range(3):
                        if(data["maps"][data["mapIndex"]][int(data["y"])+i-1][int(data["x"])+j-1] == 10):
                            hakoPos = (int(data["x"])+j-1, int(data["y"])+i-1)
                data["maps"][data["mapIndex"]][hakoPos[1]][hakoPos[0]] = 1
                for i in range(3):
                    for j in range(3):
                        if(data["mapEvent"][data["mapIndex"]][hakoPos[1]+i-1][hakoPos[0]+j-1] == 10):
                            data["mapEvent"][data["mapIndex"]
                                             ][hakoPos[1]+i-1][hakoPos[0]+j-1] = 0
            elif getEve() == 11:
                index = 17
                nowEnemy["Lv"] = 9
                nowEnemy["index"] = 0
            elif getEve() == 14:
                index = 17
                nowEnemy["Lv"] = 10
                nowEnemy["index"] = 1
            elif getEve() == 20:
                data["event"][12] = True
            elif getEve() == 9:
                for i in data["bag"][0]:
                    if i[0] == 0:
                        del i
                        for k in range(len(data["maps"][2])):
                            for j in range(len(data["maps"][2][0])):
                                if data["maps"][2][k][j] == 9:
                                    data["maps"][2][k][j] = 1
                                if data["mapEvent"][2][k][j] == 9:
                                    data["mapEvent"][2][k][j] = 0
            elif getEve() == 15:
                for i in data["bag"][0]:
                    if i[0] == 1:
                        del i
                        for k in range(len(data["maps"][9])):
                            for j in range(len(data["maps"][9][0])):
                                if data["maps"][9][k][j] == 15:
                                    data["maps"][9][k][j] = 1
                                if data["mapEvent"][9][k][j] == 15:
                                    data["mapEvent"][9][k][j] = 0
            else:
                breaking = False
        else:
            for btn in btn5:
                btn.place_forget()
            breaking = False
        if(showingJob):
            showMap()
            if(key == "Escape"):
                showingJob = False
                for btn in btn6:
                    btn.place_forget()
            breaking = True
        if(breaking):
            timer += 1
            key = 0
            w.after(10, main)
            return
        # 自由移動
        before = (int(data["x"]), int(data["y"]))
        if(key == "w" and data["y"]-0.05 >= 0 and data["maps"][data["mapIndex"]][int(data["y"]-0.05)][int(data["x"])] in [1, 5, 12, 18]):
            playerNow = potekun[2]
            data["y"] -= 0.05
        if(key == "a" and data["x"]-0.05 >= 0 and data["maps"][data["mapIndex"]][int(data["y"])][int(data["x"]-0.05)] in [1, 5, 12, 18]):
            playerNow = potekun[3]
            data["x"] -= 0.05
        if(key == "s" and data["y"]+0.05 < len(data["maps"][data["mapIndex"]]) and data["maps"][data["mapIndex"]][int(data["y"]+0.05)][int(data["x"])] in [1, 5, 12, 18]):
            playerNow = potekun[0]
            data["y"] += 0.05
        if(key == "d" and data["x"]+0.05 < len(data["maps"][data["mapIndex"]][0]) and data["maps"][data["mapIndex"]][int(data["y"])][int(data["x"]+0.05)] in [1, 5, 12, 18]):
            playerNow = potekun[1]
            data["x"] += 0.05
        after = (int(data["x"]), int(data["y"]))
        # 戦闘に入るかどうか
        if before != after and rnd(1, 100) <= mapEnemy[data["mapIndex"]]:
            index = 17
            lv = choice(mapLv[data["mapIndex"]])
            nowEnemy["Lv"] = lv
            nowEnemy["index"] = 3+(lv-1)*2+rnd(0, 1)
        # メニュー画面へ
        if(key == "Escape"):
            index += 1
        showMap()
        c.create_rectangle(0, 0, 120, 40, fill="white", tag="show")
        gm.text(c, 60, 20, mapTitleAll[data["mapIndex"]], "black", 15)
        gm.shadowText(c, 600, 20, data["name"], "black", "white", 15)
        gm.shadowText(c, 750, 20, f"Lv.{data['Lv']}", "black", "white", 15)
        gm.makeBar(c, 600, 50, 800, 70,
                   data["HPmax"], data["HP"], "HP", "green")
        gm.makeBar(c, 600, 80, 800, 100,
                   data["MPmax"], data["MP"], "MP", "red")
        if(timer > 6000):
            data["farm"] += 1
            timer = 0
    elif index == 9:  # メニュー画面の表示、10でループ
        showMap()
        for i, btn in enumerate(btn4):
            btn.place(x=250, y=100+80*i)
        index += 1
    elif index == 11: # プロフィール
        c.delete("show")
        gm.text(c, 550, 25, f"名前:{data['name']}", "black", 20)
        keikenMax = 5
        for i in range(1, data["Lv"]):
            if i < 10:
                keikenMax += 1
            elif i < 20:
                keikenMax += 2
            elif i < 40:
                keikenMax += 4
            else:
                keikenMax += 5
        gm.makeBar(c, 350, 50, 750, 80, keikenMax,
                   data["keiken"], f"Lv.{data['Lv']}", "yellow")
        gm.text(c, 550, 110,
                f"次のレベルまであと{keikenMax-data['keiken']}", "black", 20)
        gm.makeBar(c, 350, 140, 750, 170,
                   data["HPmax"], data["HP"], "HP", "green")
        gm.makeBar(c, 350, 180, 750, 210,
                   data["MPmax"], data["MP"], "MP", "red")
        gm.text(c, 550, 240, f"倒した数 {data['killed']}", "black", 20)
        gm.text(c, 550, 270, f"死亡回数 {data['dead']}", "black", 20)
        gm.text(
            c, 100, 80, f"職業\n1:{jobTitle[data['job'][0]-1]}-Lv.{data['jobLv'][data['job'][0]-1]}\n2:{jobTitle[data['job'][1]-1]}-Lv.{data['jobLv'][data['job'][1]-1]}", "black", 20)
        gm.text(c, 100, 200, f"所持金{data['money']}ポテト", "black", 20)
        index += 1
    elif index == 12: # プロフィールのループ
        if key == "Escape":
            index = 9
    elif index == 13: # アイテム・装備
        c.delete("show")
        gm.text(c, 40, 45, "鎧", "black", 15)
        if(data["soubi"][0] != 0):
            c.create_image(
                90, 45, image=itemImage[data["soubi"][0]], tag="show")
            gm.text(c, 400, 45, itemDesc[data["soubi"][0]], "black", 15)
            gm.text(c, 210, 45, itemTitle[data["soubi"][0]], "black", 15)
        else:
            gm.text(c, 150, 45, "なし", "black", 15)
        gm.text(c, 40, 105, "ズボン", "black", 15)
        if(data["soubi"][1] != 0):
            c.create_image(
                90, 105, image=itemImage[data["soubi"][1]], tag="show")
            gm.text(c, 400, 105, itemDesc[data["soubi"][1]], "black", 15)
            gm.text(c, 210, 105, itemTitle[data["soubi"][1]], "black", 15)
        else:
            gm.text(c, 150, 105, "なし", "black", 15)
        gm.text(c, 40, 165, "武器", "black", 15)
        if(data["soubi"][2] != 0):
            c.create_image(
                90, 165, image=itemImage[data["soubi"][2]], tag="show")
            gm.text(c, 400, 165, itemDesc[data["soubi"][2]], "black", 15)
            gm.text(c, 210, 165, itemTitle[data["soubi"][2]], "black", 15)
        else:
            gm.text(c, 150, 165, "なし", "black", 15)
        soubi["values"] = ("装備を選択", "なし") + tuple(
            (f"{itemTitle[data['bag'][1][i]]}" for i in range(len(data["bag"][1]))))
        soubi.current(0)
        soubi.place(x=10, y=200)
        for i, btn in enumerate(btn7):
            btn.place(x=10, y=300+i*60)
        item["values"] = ("アイテムを選択",) + tuple(
            (f"{itemTitle[data['bag'][0][i][0]]}" for i in range(len(data["bag"][0]))))
        item.current(0)
        item.place(x=500, y=200)
        btn8.place(x=500, y=300)
        index += 1
    elif index == 14: # アイテム・装備のループ
        c.delete("desc")
        if(soubi.current() not in [0, 1]):
            gm.text(c, 150, 250, itemDesc[data["bag"][1]
                    [soubi.current()-2]], "black", 15, tag="desc")
        if(item.current() != 0):
            gm.text(c, 550, 250, itemDesc[data["bag"][0][item.current(
            )-1][0]][data["bag"][0][item.current()-1][1]], "black", 15, tag="desc")
        if(key == "Escape"):
            c.delete("desc")
            c.delete("show")
            for i in btn7:
                i.place_forget()
            btn8.place_forget()
            soubi.place_forget()
            item.place_forget()
            index = 9
    elif index == 15: # ショップ
        c.delete("show")
        soubi.place_forget()
        item.place_forget()
        btn9.place_forget()
        btn9.place(x=20, y=20)
        for btn in btn10:
            btn.place_forget()
        for btn in btn11:
            btn.place_forget()
        if not modeBuy:
            soubi["values"] = (
                "装備を選択",) + tuple((f"{itemTitle[data['bag'][1][i]]}" for i in range(len(data["bag"][1]))))
            item["values"] = ("アイテムを選択",) + tuple(
                (f"{itemTitle[data['bag'][0][i][0]]}-Lv{data['bag'][0][i][1]}" for i in range(len(data["bag"][0]))))
            for i, btn in enumerate(btn10):
                btn.place(x=550, y=250+200*i)
        else:
            soubi["values"] = ("装備を選択",) + \
                tuple((f"{itemTitle[i]}" for i in range(5, 10)))
            if data["Lv"] >= 10:
                soubi["values"] += tuple(
                    (f"{itemTitle[i]}" for i in range(10, 16)))
            if data["Lv"] >= 30:
                soubi["values"] += tuple(
                    (f"{itemTitle[i]}" for i in range(16, 19)))
            if data["Lv"] >= 45:
                soubi["values"] += tuple(
                    (f"{itemTitle[i]}" for i in range(19, 23)))
            item["values"] = (
                "アイテムを選択",) + tuple((f"{itemTitle[2+i//10]}-Lv{i%10}" for i in range(20)))
            for i, btn in enumerate(btn11):
                btn.place(x=550, y=250+200*i)
        soubi.place(x=20, y=100)
        item.place(x=20, y=300)
        soubi.current(0)
        item.current(0)
        index += 1
    elif index == 16: # ショップのループ
        c.delete("show")
        gm.text(c, 600, 50, f"所持金:{data['money']}", "black", 15)
        ind_s = 0
        ind_i = 0
        adding = 1
        if not modeBuy:
            try:
                ind_s = data["bag"][1][soubi.current()-1]
            except:
                pass
            try:
                ind_i = data["bag"][0][item.current()-1]
            except:
                pass
        else:
            ind_s = soubi.current()-1+5
            ind_i = [2+(item.current()-1)//10, (item.current()-1) % 10]
            adding = 1.1
        if soubi.current() != 0:
            c.create_image(45, 200, image=itemImage[ind_s], tag="show")
            gm.text(c, 250, 200, itemDesc[ind_s], "black", 15)
            gm.text(c, 500, 200,
                    f"{int(itemPrice[ind_s]*adding)}ポテト", "black", 15)
        if item.current() != 0:
            c.create_image(45, 400, image=itemImage[ind_i[0]], tag="show")
            gm.text(c, 250, 400, itemDesc[ind_i[0]][ind_i[1]], "black", 15)
            if(itemPrice[ind_i[0]] != -1):
                gm.text(
                    c, 500, 400, f"{int(itemPrice[ind_i[0]][ind_i[1]]*adding)}ポテト", "black", 15)
            else:
                gm.text(c, 500, 400, f"販売不可", "black", 15)
        if key == "Escape":
            for btn in btn10:
                btn.place_forget()
            for btn in btn11:
                btn.place_forget()
            btn9.place_forget()
            soubi.place_forget()
            item.place_forget()
            index = 8
    elif index == 17: # 戦闘初期化1
        global nowPlayer
        nowPlayer = {"turnHP": [], "turnPower": []}
        nowEnemy["turnHP"] = []
        nowEnemy["turnPower"] = []
        nowEnemy["kaihi"] = 0
        nowEnemy["HP"] = rnd(enemyHP[nowEnemy["Lv"]-1][0],
                             enemyHP[nowEnemy["Lv"]-1][1])
        nowEnemy["power"] = rnd(
            enemyPower[nowEnemy["Lv"]-1][0], enemyPower[nowEnemy["Lv"]-1][1])
        nowEnemy["HPmax"] = nowEnemy["HP"]
        item.place(x=200, y=360)
        waza.place(x=20, y=360)
        btn13.place(x=400, y=270)
        btn12.place(x=600, y=270)
        btn14.place(x=700, y=20)
        turn = 1
        index += 1
    elif index == 18: # 戦闘初期化2
        item["values"] = ("アイテムを選択",) + tuple(
            (f"{itemTitle[data['bag'][0][i][0]]}-Lv{data['bag'][0][i][1]}" for i in range(len(data["bag"][0]))))
        item.current(0)
        waza["values"] = ("技を選択",)+tuple(data["waza"][0][i][1] for i in range(len(
            data["waza"][0])))+tuple(data["waza"][1][i][1] for i in range(len(data["waza"][1])))
        waza.current(0)
        index += 1
    elif index == 19: # 戦闘のループ
        c.delete("show")
        c.create_rectangle(5, 260, 895, 590, fill="white", tag="show")
        gm.makeBar(c, 350, 20, 550, 50,
                   nowEnemy["HPmax"], nowEnemy["HP"], enemyName[nowEnemy["index"]], "red")
        c.create_image(
            450, 160, image=enemyImage[nowEnemy["index"]], tag="show")
        gm.makeBar(c, 60, 270, 230, 300,
                   data["HPmax"], data["HP"], "HP", "green")
        gm.makeBar(c, 60, 320, 230, 350,
                   data["MPmax"], data["MP"], "MP", "orange")
        if item.current() != 0:
            c.create_image(
                245, 550, image=itemImage[data["bag"][0][item.current()-1][0]], tag="show")
            gm.text(c, 450, 550, itemDesc[data["bag"][0][item.current(
            )-1][0]][data["bag"][0][item.current()-1][1]], "black", 15)
        if waza.current() != 0:
            wazaDesc = ""
            jobIndex = 0
            wazaIndex = waza.current()-1
            if wazaIndex >= len(data["waza"][0]):
                jobIndex = 1
                wazaIndex -= len(data["waza"][0])
            nowWaza = data["waza"][jobIndex][wazaIndex]
            if nowWaza[0] == 1:
                wazaDesc = f"敵に攻撃力の{nowWaza[2]}倍のダメージ"
            elif nowWaza[0] == 2:
                wazaDesc = f"攻撃力の{nowWaza[2]}倍回復"
            elif nowWaza[0] == 3:
                wazaDesc = f"{nowWaza[2]}ターンの間HPが{nowWaza[3]}回復"
            elif nowWaza[0] == 4:
                wazaDesc = f"{nowWaza[2]}ターンの間HPを敵から{nowWaza[3]}吸収"
            elif nowWaza[0] == 5:
                wazaDesc = f"{nowWaza[2]}ターンの間敵に{nowWaza[3]}ダメージ"
            elif nowWaza[0] == 6:
                wazaDesc = f"次のターン攻撃力が{nowWaza[2]}倍に"
            elif nowWaza[0] == 7:
                wazaDesc = f"次のターン敵に攻撃力の{nowWaza[2]}倍のダメージ"
            elif nowWaza[0] == 8:
                wazaDesc = f"相手の攻撃力を次のターン中{nowWaza[2]}倍にする"
            elif nowWaza[0] == 9:
                wazaDesc = f"{nowWaza[2]}%の確率で敵が即死する、敵に攻撃力の{nowWaza[3]}倍のダメージ"
            elif nowWaza[0] == 10:
                wazaDesc = f"敵から攻撃力の{nowWaza[2]}倍のHPを吸収する"
            gm.text(c, 450, 450, nowWaza[1]+":"+wazaDesc, "black", 15)
        if data["HP"] <= 0:
            index = 21
        elif nowEnemy["HP"] <= 0:
            index = 23
        elif turn == 0: # 敵のターン
            hpChange_p = data["HP"]
            hpChange_e = nowEnemy["HP"]
            power = nowEnemy["power"]
            if(len(nowEnemy["turnPower"]) >= 1):
                power += nowEnemy["turnPower"][0]
                del nowEnemy["turnPower"][0]
            selectedWaza = choice(enemyWaza[nowEnemy["index"]])
            wazaSerihu = f"{enemyName[nowEnemy['index']]}は\n{selectedWaza[1]}をした"
            if selectedWaza[0] == 1:
                data["HP"] -= int(power*selectedWaza[2])
            elif selectedWaza[0] == 2:
                nowEnemy["HP"] += selectedWaza[2]
            elif selectedWaza[0] == 3:
                for i in range(selectedWaza[2]):
                    try:
                        nowPlayer["turnHP"][i] -= int((power)*selectedWaza[3])
                    except:
                        nowPlayer["turnHP"] += [-int((power)*selectedWaza[3])]
            elif selectedWaza[0] == 4:
                nowEnemy["HPmax"] += selectedWaza[2]
                nowEnemy["HP"] += selectedWaza[2]
            elif selectedWaza[0] == 5:
                nowEnemy["power"] += selectedWaza[2]
            elif selectedWaza[0] == 6:
                for i in range(selectedWaza[2]):
                    try:
                        nowPlayer["turnPower"][i] -= selectedWaza[3]
                    except:
                        nowPlayer["turnPower"] += [selectedWaza[3]]
            elif selectedWaza[0] == 7:
                nowEnemy["HP"] += int((power)*selectedWaza[2])
                data["HP"] -= int((power)*selectedWaza[2])
            elif selectedWaza[0] == 8:
                nowEnemy["kaihi"] = selectedWaza[2]
            elif selectedWaza[0] == 9:
                for i in range(selectedWaza[2]):
                    try:
                        nowPlayer["turnHP"][i] -= int((power)/2)
                    except:
                        nowPlayer["turnHP"] += [-int((power)/2)]
            elif selectedWaza[0] == 10:
                for i in range(3):
                    try:
                        nowPlayer["turnPower"][i] -= int(
                            data["power"]*selectedWaza[2]/100)
                    except:
                        nowPlayer["turnPower"] += [
                            int(data["power"]*selectedWaza[2]/100)]
            elif selectedWaza[0] == 11:
                if(rnd(1, 100) <= 5):
                    escapeButtle()
            if(len(nowEnemy["turnHP"]) >= 1):
                nowEnemy["HP"] += nowEnemy["turnHP"][0]
                del nowEnemy["turnHP"][0]
            if(len(nowPlayer["turnHP"]) >= 1):
                data["HP"] += nowPlayer["turnHP"][0]
                del nowPlayer["turnHP"][0]
            if(data["HP"] > data["HPmax"]):
                data["HP"] = data["HPmax"]
            if(data["HP"] < 0):
                data["HP"] = 0
            if(nowEnemy["HP"] > nowEnemy["HPmax"]):
                nowEnemy["HP"] = nowEnemy["HPmax"]
            if(nowEnemy["HP"] < 0):
                nowEnemy["HP"] = 0
            hpChange_p -= data["HP"]
            hpChange_e -= nowEnemy["HP"]
            index = 20
            turn = 1
    elif index == 20: # 戦闘セリフ表示
        c.delete("show2")
        if wazaSerihu != "":
            gm.showSerihu2(c, wazaSerihu)
            if key == "Return":
                wazaSerihu = ""
                playSe()
        elif hpChange_p != 0:
            if(hpChange_p > 0):
                gm.showSerihu2(c, f"{data['name']}は\n{hpChange_p}ダメージを受けた")
            else:
                gm.showSerihu2(c, f"{data['name']}は\n{-hpChange_p}回復した")
            if key == "Return":
                hpChange_p = 0
                playSe()
        elif hpChange_e != 0:
            if(hpChange_e > 0):
                gm.showSerihu2(
                    c, f"{enemyName[nowEnemy['index']]}は\n{hpChange_e}ダメージを受けた")
            else:
                gm.showSerihu2(
                    c, f"{enemyName[nowEnemy['index']]}は\n{-hpChange_e}回復した")
            if key == "Return":
                hpChange_e = 0
                playSe()
        else:
            index = 19
    elif index == 21: # 敗北時
        c.delete("show")
        c.delete("show2")
        item.place_forget()
        waza.place_forget()
        btn14.place_forget()
        btn13.place_forget()
        btn12.place_forget()
        c.create_rectangle(0, 0, 900, 600, fill="black", tag="show")
        gm.showSerihu(c, "負けてしまった...")
        data["dead"] += 1
        index += 1
    elif index == 22: # 敗北時のループ
        if key == "Return":
            data["HP"] = data["HPmax"]
            data["mapIndex"] = 0
            data["x"] = 2.5
            data["y"] = 5.5
            playSe()
            index = 8
    elif index == 23: # 勝利時
        c.delete("show")
        c.delete("show2")
        item.place_forget()
        waza.place_forget()
        btn14.place_forget()
        btn13.place_forget()
        btn12.place_forget()
        data["killed"] += 1
        dropedKeiken = rnd(dropKeiken[nowEnemy["Lv"]-1]
                           [0], dropKeiken[nowEnemy["Lv"]-1][1])
        dropedKeikenCopy = dropedKeiken
        dropedPote = rnd(dropPote[nowEnemy["Lv"]-1][0],
                         dropPote[nowEnemy["Lv"]-1][1])
        while(dropedKeiken > 0):
            needKeiken = 4
            lvpower = 3
            lvhp = 10
            lvmp = 10
            for i in range(0, data["Lv"]):
                data["power"] = int(lvpower)
                data["HPmax"] = lvhp
                data["MPmax"] = lvmp
                if i <= 10:
                    needKeiken += 1
                    lvpower += 0.5
                    lvhp += 1
                    lvmp += 1
                elif i <= 20:
                    needKeiken += 2
                    lvpower += 1
                    lvhp += 2
                    lvmp += 4
                elif i <= 40:
                    needKeiken += 4
                    lvpower += 1
                    lvhp += 3
                    lvmp += 5
                else:
                    needKeiken += 5
                    lvpower += 1
                    lvhp += 5
                    lvmp += 6
            if data["keiken"]+dropedKeiken < needKeiken:
                data["keiken"] += dropedKeiken
                dropedKeiken = 0
            else:
                data["Lv"] += 1
                dropedKeiken -= needKeiken-data["keiken"]
                data["keiken"] = 0
                data["power"] = int(lvpower)
                data["HPmax"] = lvhp
                data["MPmax"] = lvmp
        for j in range(2):
            dropedKeiken = dropedKeikenCopy
            while(dropedKeiken > 0):
                needKeiken = 4.5
                lvpower = 0
                if data["job"][j] == 4:
                    lvpower = 5
                for i in range(0, data["jobLv"][data["job"][j]-1]):
                    data["jobPower"][data["job"][j]-1] = int(lvpower)
                    if i <= 10:
                        needKeiken += 0.5
                        lvpower += 0.5
                    elif i <= 20:
                        needKeiken += 1
                        lvpower += 0.25
                    elif i <= 40:
                        needKeiken += 1
                        lvpower += 0.25
                    else:
                        needKeiken += 2
                        lvpower += 0.5
                needKeiken = int(needKeiken)
                if data["jobKeiken"][data["job"][j]-1]+dropedKeiken < needKeiken:
                    data["jobKeiken"][data["job"][j]-1] += dropedKeiken
                    dropedKeiken = 0
                else:
                    data["jobLv"][data["job"][j]-1] += 1
                    dropedKeiken -= needKeiken - \
                        data["jobKeiken"][data["job"][j]-1]
                    data["jobKeiken"][data["job"][j]-1] = 0
                    data["jobPower"][data["job"][j]-1] = int(lvpower)
        for ind in range(3):
            if data["soubi"][ind] == 0:
                continue
            power = itemPower[data["soubi"][ind]]
            if(power[0] == 1):
                data["HPmax"] += power[1]
            elif(power[0] in [2, 3]):
                data["jobPower"][power[0]-2] += power[1]
            elif(power[0] == 4):
                data["jobPower"][2] += power[1]
                data["jobPower"][3] += power[1]
            elif(power[0] == 5):
                data["MPmax"] += power[1]
            elif(power[0] == 6):
                data["HPmax"] += power[1]
                data["MPmax"] += power[1]
            elif(power[0] == 7):
                data["power"] += power[1]
        setJob(data["job"][0], data["job"][1])
        data["money"] += dropedPote
        gm.text(c, 450, 100, "戦利品", "red", 20)
        gm.text(c, 450, 200, f"経験値を{dropedKeikenCopy}ゲットした", "black", 15)
        gm.text(c, 450, 300, f"{dropedPote}ポテトをゲットした", "black", 15)
        if nowEnemy["index"] == 0:
            data["bag"][0] += [[0, 0]]
            for i in range(len(data["maps"][3])):
                for j in range(len(data["maps"][3][0])):
                    if data["maps"][3][i][j] == 11:
                        data["maps"][3][i][j] = 1
                    if data["mapEvent"][3][i][j] == 11:
                        data["mapEvent"][3][i][j] = 0
            gm.text(c,450,400,"ドリルを手に入れた!", "red", 15)
        if nowEnemy["index"] == 1:
            data["bag"][0] += [[1, 0]]
            for i in range(len(data["maps"][8])):
                for j in range(len(data["maps"][8][0])):
                    if data["maps"][8][i][j] == 14:
                        data["maps"][8][i][j] = 1
                    if data["mapEvent"][8][i][j] == 14:
                        data["mapEvent"][8][i][j] = 0
            gm.text(c,450,400,"火炎放射器を手に入れた!", "red", 15)
        if nowEnemy["index"] == 2:
            for i in range(len(data["maps"][14])):
                for j in range(len(data["maps"][14][0])):
                    if data["maps"][14][i][j] == 20:
                        data["maps"][14][i][j] = 1
                    if data["mapEvent"][14][i][j] == 20:
                        data["mapEvent"][14][i][j] = 0
        index += 1
    elif index == 24: # 勝利時のループ
        if key == "Return":
            index = 8
    timer += 1
    key = 0
    w.after(10, main)


main()
w.mainloop()
