def printJP(ptStr):
    ptInt=int("0b"+ptStr.replace("ポ","0").replace("テ","1"),2)
    if(ptInt>0xFF):
        ptBytes=ptInt.to_bytes(2,"big")
    else:
        ptBytes=ptInt.to_bytes(1,"big")
    print(ptBytes.decode("SHIFT_JIS"))
while(True):
    printJP(input())