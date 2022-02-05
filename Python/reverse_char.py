jp="あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん"
inp=input()
res=""
print("a から z,あ から ん を右から左に並べたときに右からx番目の文字を左からx番目の文字に変換します。")
for i in inp:
    fin=False
    a=0
    if ord(i)>=ord('a') and ord(i)<=ord('z'):
        res+=chr(ord('z')-(ord(i)-ord('a')))
        fin=True
    else:
        for j in jp:
            if i==j:
                res+=jp[len(jp)-a-1]
                fin=True
            a+=1
    if fin==False:
        res+=i
print(res)