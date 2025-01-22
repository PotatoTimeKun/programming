import function
import MisskeyAPI
import json
import threading
import datetime
import time

setting = {}

def readSetting():
    """
    AIPCsetting.jsonから設定を読み込む
    """
    global setting
    f = open("AIPCsetting.json","r",encoding="utf-8")
    setting = json.load(f)
    f.close()

readSetting()

function.readSetting()

misskey = None
# トークンを設定
misskey = MisskeyAPI.MisskeyAPI(server=setting["misskeyServer"],token=setting["misskeyToken"])

timerStop = False
def timer(): # 1分ごとにmainを実行
    beforeTime = -1
    while True:
        if timerStop:
            break
        nowTime = datetime.datetime.now()
        if beforeTime==nowTime.minute:
            time.sleep(10)
            continue
        beforeTime = nowTime.minute
        main(nowTime)
        time.sleep(10)
        if timerStop:
            break

def main(time : datetime.datetime):
    for event in setting["AIPC"]["schedule"]:
        if event["type"]=="once" and event["startAt"][0]==time.hour and event["startAt"][1]==time.minute:
            print(f"run - {event['function']}")
            eventRun(event["function"])
        elif event["type"]=="interval" and event["startAt"][0]*60+event["startAt"][1]<=time.hour*60+time.minute and (time.hour*60+time.minute-(event["startAt"][0]*60+event["startAt"][1]))%event["timer"]==0:
            # interval かつ startAtを過ぎている かつ ちょうどtimerの間隔だけ経った(0を含む)
            print(f"run - {event['function']}")
            eventRun(event["function"])
    for thread in threads:
        if not thread.is_alive():
            threads.remove(thread)

threads = []

def eventRun(eventName : str): # イベント名と機能を対応付ける
    if eventName=="note-generation":
        thread = threading.Thread(target=function.makeNote,args=(misskey,))
        thread.start()
        threads.append(thread)
    elif eventName=="575-generation":
        thread = threading.Thread(target=function.make575,args=(misskey,))
        thread.start()
        threads.append(thread)
    elif eventName=="uranai-generation":
        thread = threading.Thread(target=function.makeUranai,args=(misskey,))
        thread.start()
        threads.append(thread)
    elif eventName=="weathercast-generate":
        thread = threading.Thread(target=function.weathercast,args=(misskey,))
        thread.start()
        threads.append(thread)
    elif eventName=="reaction-send":
        thread = threading.Thread(target=function.sendReaction,args=(misskey,))
        thread.start()
        threads.append(thread)
    else:
        print(f"定義されないイベント : {eventName}")

thread = threading.Thread(target=timer)
thread.start()
threads.append(thread)

# while True:
#     inputted = input()
#     if inputted!="exit":
#         eventRun(inputted)
#         print(f"run(prompt) - {inputted}")
#         continue
#     timerStop = True
#     for thread in threads:
#         thread.join()
#     break