import json
import codecs
from unittest import case
file=open("settings.json","r")
settings=json.load(file)
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
while(True):
    command=input()
    if(command=="make"):
        makeReadme(settings)
        save(settings)
    elif(command=="new"):
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
            settings["lang"]={}
            settings[lang][title]=desc
            print(f"# {lang}\n\n## {title}\nver{vertion}\\~now:  \n{desc}")
    elif(command=="getLang"):
        for i in settings["language"]:
            print(i)
    elif(command=="getTitle"):
        print("language:")
        lang=input()
        for i in settings[lang].keys():
            print(i)
    elif(command=="get"):
        print("language:")
        lang=input()
        print("title:")
        title=input()
        print(settings[lang][title])
    elif(command=="add"):
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
        print(f"ver{vertion}\\~now:  \n{desc}")
        settings[lang][title]+=desc
    elif(command=="update"):
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
        settings[lang][title]=desc
        print(f"ver{vertion}\\~now:  \n{desc}")
    elif(command=="verUp"):
        ver=int(settings["vertion"].replace(".",""))
        ver+=1
        settings["vertion"]=str(ver//10)
        settings["localVertion"]="0"
    elif(command=="locVerUp"):
        ver=int(settings["localVertion"])
        ver+=1
        settings["localVertion"]=str(ver)
    elif(command=="delete"):
        print("language:")
        lang=input()
        print("title:")
        title=input()
        del settings[lang][title]
    elif(command=="delLang"):
        print("language:")
        lang=input()
        del settings[lang]
    print("")