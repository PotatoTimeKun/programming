def odd_parity(value):
    if not isinstance(value,str) and not isinstance(value,int):return "-1"
    if isinstance(value,int):
        value=bin(value)
    i=0
    for c in value:
        if(c=="1"):
            i+=1
    if(i%2==0):
        return "1"
    return "0"
def even_parity(value):
    if not isinstance(value,str) and not isinstance(value,int):return "-1"
    if isinstance(value,int):
        value=bin(value)
    i=0
    for c in value:
        if(c=="1"):
            i+=1
    if(i%2==0):return "0"
    return "1"
def odd_v_l_parity(value):
    if not isinstance(value,str) and not isinstance(value,int):return "-1"
    if isinstance(value,int):
        value=bin(value)
    valueList=[]
    ret=["",""]
    for i in range((int)((len(value)+5)/6)):
        valueList.append(value[i*6])
        for j in range(1,6):
            ind=i*6+j
            if(ind<len(value)):valueList[i]+=value[ind]
            else:valueList[i]+="0"
    for i in range(len(valueList)):
        ret[0]+=odd_parity(valueList[i])
        valueList[i]+=odd_parity(valueList[i])
    for i in range(7):
        l=""
        for j in range(len(valueList)):
            l+=valueList[j][i]
        ret[1]+=odd_parity(l)
    return ret
def even_v_l_parity(value):
    if not isinstance(value,str) and not isinstance(value,int):return "-1"
    if isinstance(value,int):
        value=bin(value)
    valueList=[]
    ret=["",""]
    for i in range((int)((len(value)+5)/6)):
        valueList.append(value[i*6])
        for j in range(1,6):
            ind=i*6+j
            if(ind<len(value)):valueList[i]+=value[ind]
            else:valueList[i]+="0"
    for i in range(len(valueList)):
        ret[0]+=even_parity(valueList[i])
        valueList[i]+=even_parity(valueList[i])
    for i in range(7):
        l=""
        for j in range(len(valueList)):
            l+=valueList[j][i]
        ret[1]+=even_parity(l)
    return ret
