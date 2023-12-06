def toSum(a,b):
    text=f"{a}*{b}"
    plus=""
    for i in range(b):
        text+=f"={a}*S({b-1-i})"+plus
        plus+=f"+{a}"
        text+=f"={a}*{b-1-i}"+plus
    text+="="+plus[1:]
    return [text,[a]*b]

def calculateSum(l):
    text="+".join(str(i) for i in l)
    while(len(l)>1):
        text+=f"={l[0]}+"+"S("*l[1]+"0"+")"*l[1]
        if(len(l)>2):
            text+="+"+"+".join(str(i) for i in l[2:])
        text+="="+"S("*l[1]+f"{l[0]}"+")"*l[1]
        if(len(l)>2):
            text+="+"+"+".join(str(i) for i in l[2:])
        text+=f"={l[0]+l[1]}"
        if(len(l)>2):
            text+="+"+"+".join(str(i) for i in l[2:])
        l=[l[0]+l[1]]+l[2:]
    return [text,l[0]]

def calculateMul(a,b):
    ab=toSum(a,b)
    absum=calculateSum(ab[1])
    return [ab[0]+"="+absum[0],absum[1]]
