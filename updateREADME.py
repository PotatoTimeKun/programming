# このプログラムは自分用(READMEの操作用)です。
# 操作ミスってもそのフォルダにあるREADMEが書き換わるだけなので触ってもらっても構いません()
import json
import codecs
from copy import deepcopy as dCopy
file=open("settings.json","r")
settings=json.load(file)
beforSet=dCopy(settings)
def save(data):
    to=open("settings.json","w")
    json.dump(data,to)
    to.close()
def makeReadme(data):
    text=""
    text+=data["first"]+"  \n\n"
    for i in data["language"]:
        text+=f"# {i}\n\n"
        for j in data[i].keys():
            text+=f"## {j}\n{data[i][j]}\n"
    to=codecs.open("README.md","w","utf-8")
    print(text,file=to)
    to.close()
commands=["make","new","getLang","getTitle","get","getVer","add","update","verUp","locVerUp","delete","delLang","updFirst","getFirst","back"]
descs=[
    "変更結果を適用します。",
    "新しい項目を作ります。",
    "言語の一覧を取得します。",
    "指定した言語の項目一覧を取得します。",
    "指定した項目の内容を取得します。",
    "グローバル及びローカルバージョンを取得します。",
    "指定した項目に差分的に内容を追加します。",
    "指定した項目の内容を書き換えます。",
    "グローバルバージョンを1つ上げます。(ローカルバージョンは0になります。)",
    "ローカルバージョンを1つ上げます。",
    "指定した項目を削除します。",
    "指定した言語を削除します。",
    "最初の文を変更します。",
    "最初の文を取得します。",
    "1つ前の状態に戻ります(2回実行しても2つ前には戻れません)"
]
while(True):
    command=input()
    try:
        if(command=="make"):
            makeReadme(settings)
            save(settings)
        elif(command=="new"):
            beforSet=dCopy(settings)
            print("language:")
            lang=input()
            print("title:")
            title=input()
            print("description(write '.end' to finish):")
            desc=""
            while(True):
                text=input()
                if(text==".end"):break
                desc+=text+"  \n"
            vertion=settings["vertion"]+"."+settings["localVertion"]
            if(lang in settings["language"]):
                settings[lang][title]=desc
                print(f"## {title}\nver{vertion}\\~now:  \n{desc}")
            else:
                settings["language"].append(lang)
                settings[lang]={}
                settings[lang][title]=desc
                print(f"# {lang}\n\n## {title}\nver{vertion}\\~now:  \n{desc}")
        elif(command=="getLang"):
            for i in settings["language"]:
                print(i)
            print("")
            continue
        elif(command=="getTitle"):
            print("language:")
            lang=input()
            for i in settings[lang].keys():
                print(i)
            print("")
            continue
        elif(command=="get"):
            print("language:")
            lang=input()
            print("title (or 'num'):")
            title=input()
            if(title=="num"):
                for i,j in enumerate(settings[lang].keys()):
                    print(f"{j}:{i}")
                title=list(settings[lang].keys())[int(input())]
            print(settings[lang][title])
            print("")
            continue
        elif(command=="getVer"):
            print(f"{settings['vertion']}.{settings['localVertion']}\n")
            continue
        elif(command=="add"):
            beforSet=dCopy(settings)
            print("language:")
            lang=input()
            print("title (or 'num'):")
            title=input()
            if(title=="num"):
                for i,j in enumerate(settings[lang].keys()):
                    print(f"{i}:{j}")
                title=list(settings[lang].keys())[int(input())]
            print("description(write '.end' to finish):")
            print(settings[lang][title]+"\n+\n")
            desc=""
            while(True):
                text=input()
                if(text==".end"):break
                desc+=text+"  \n"
            vertion=settings["vertion"]+"."+settings["localVertion"]
            print(f"ver{vertion}\\~now:  \n{desc}")
            settings[lang][title]+=desc
        elif(command=="update"):
            beforSet=dCopy(settings)
            print("language:")
            lang=input()
            print("title (or 'num'):")
            title=input()
            if(title=="num"):
                for i,j in enumerate(settings[lang].keys()):
                    print(f"{j}:{i}")
                title=list(settings[lang].keys())[int(input())]
            print("description(write '.end' to finish):")
            print(settings[lang][title]+"\n→\n")
            desc=""
            while(True):
                text=input()
                if(text==".end"):break
                desc+=text+"  \n"
            vertion=settings["vertion"]+"."+settings["localVertion"]
            settings[lang][title]=desc
            print(f"ver{vertion}\\~now:  \n{desc}")
        elif(command=="verUp"):
            beforSet=dCopy(settings)
            ver=int(settings["vertion"].replace(".",""))
            ver+=1
            settings["vertion"]=str(ver//10)
            settings["localVertion"]="0"
        elif(command=="locVerUp"):
            beforSet=dCopy(settings)
            ver=int(settings["localVertion"])
            ver+=1
            settings["localVertion"]=str(ver)
        elif(command=="delete"):
            beforSet=dCopy(settings)
            print("language:")
            lang=input()
            print("title (or 'num'):")
            title=input()
            if(title=="num"):
                for i,j in enumerate(settings[lang].keys()):
                    print(f"{j}:{i}")
                title=list(settings[lang].keys())[int(input())]
            del settings[lang][title]
        elif(command=="delLang"):
            beforSet=dCopy(settings)
            print("language:")
            lang=input()
            settings["language"].remove(lang)
            del settings[lang]
        elif(command=="updFirst"):
            beforSet=dCopy(settings)
            print(f"now description:\n{settings['first']}\n")
            print("new description(write '.end' to finish):")
            desc=""
            while(True):
                text=input()
                if(text==".end"):break
                desc+=text+"  \n"
            settings["first"]=desc
        elif(command=="getFirst"):
            print(f"{settings['first']}\n")
            continue
        elif(command=="back"):
            settings=dCopy(beforSet)
        elif(command=="help"):
            for i in range(len(commands)):
                print(f"  {commands[i]}:{descs[i]}")
            print("")
            continue
        else:
            print("this command is not defined\n")
            continue
    except:
        print("error\n")
    else:
        print("success\n")