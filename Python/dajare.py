from pykakasi import kakasi as jp
convert = jp().convert
text = input()
word = []
for i in convert(text):
    word.append(i["hira"])
textHira = "".join(word)
print(textHira)
for i in word:
    print(i)
    if(len(i)<=1):continue
    if(ord(i[0])<0xef):continue
    if(textHira.count(i)>=2):
        print(f"{i}を検知しました")