def printJPTo(jpStr,p,t):
    """
    jpStrをSHIFT-JISの文字コードに変換し、
    2進数において0をp,1をtにした文字列を返します。
    """
    lis=[]
    for c in jpStr:
        c_jis=int.from_bytes(c.encode("SHIFT_JIS"),"big")
        if(c_jis>0xFF):
            lis.append(p*(16-len(bin(c_jis)[2:]))+bin(c_jis)[2:])
        else:
            lis.append(p*(8-len(bin(c_jis)[2:]))+bin(c_jis)[2:])
    for child in lis:
        child=child.replace("0",p).replace("1",t)
        print(child)
def printToJP(ptStr,p,t):
    """
    ptStrをSHIFT-JIS文字と捉え、pを0,tを1に置き換えて2進数として
    変換した文字列を返します。
    """
    ptInt=int("0b"+ptStr.replace(p,"0").replace(t,"1"),2)
    if(ptInt>0xFF):
        ptBytes=ptInt.to_bytes(2,"big")
    else:
        ptBytes=ptInt.to_bytes(1,"big")
    print(ptBytes.decode("SHIFT_JIS"))