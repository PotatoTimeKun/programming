import chardet as ct
import pathlib as pl
inp=input()
l=0
def count(parent:int)->None:
    global l
    pt=pl.Path(parent)
    for f in pt.iterdir():
        try:
            if f.is_dir():count(f)
            else :
                print(f"{f}")
                tx=open(f"{f}",'rb')
                get=(ct.detect(tx.read()))
                tx.close()
                tx=open(f"{f}",'r',encoding=get['encoding'])
                get=tx.read()
                l+=len(get)
                tx.close()
        except:
            print("this file is not text")
            pass
count(inp)
print(l,"文字")