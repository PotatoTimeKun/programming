def printJPPote(jpStr):
     lis=[]
     for c in jpStr:
         c_jis=int.from_bytes(c.encode("SHIFT_JIS"),"big")
         if(c_jis>0xFF):
             lis.append("ポ"*(16-len(bin(c_jis)[2:]))+bin(c_jis)[2:])
         else:
             lis.append("ポ"*(8-len(bin(c_jis)[2:]))+bin(c_jis)[2:])
     for child in lis:
         child=child.replace("0","ポ").replace("1","テ")
         print(child)
printJPPote(input())