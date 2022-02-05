res=""
print("Unicodeの16ビット文字としてビット反転した結果を返します")
inp=input()
for i in inp:
    res+=chr(ord(i)^0xFFFF)
print(res)