def read_vij(key,ang):
    x=0
    y=0
    sente=""
    key=key.lower()
    ang=ang.lower()
    while y<len(ang):
        if ord(ang[y])>=ord('a') and ord(ang[y])<=ord('z'):
            sente+=chr(ord('A')+(ord(ang[y])-ord(key[x]))%26)
            x+=1
        else:
            sente+=ang[y]
        y+=1
        x=x%len(key)
    return sente
if __name__=="__main__":
    print("ウィジュネル暗号解読ツール\n鍵=",end='')
    key=input()
    print("文字列=",end='')
    sen=input()
    print("->"+read_vij(key,sen))
