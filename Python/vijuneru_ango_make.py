def vij(key,sent):
    x,y=0,0
    ang=""
    key=key.lower()
    sent=sent.lower()
    while y<len(sent):
        if ord(sent[y])>=ord('a') and ord(sent[y])<=ord('z'):
            ang+=chr(ord('A')+(ord(sent[y])+ord(key[x])-ord('a')*2)%26)
            x+=1
        else:
            ang+=sent[y]
        y+=1
        x%=len(key)
    return ang
print("ウィジュネル暗号生成ツール\n鍵=",end='')
key=input()
print("文字列=",end='')
sen=input()
print("->"+vij(key,sen))