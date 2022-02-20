"""パリティを扱う関数が入っています。"""
def odd_parity(value):
    """
    引数valueの奇数パリティを文字列で返します。\n
    valueはstrかintで渡してください、それ以外の型では"-1"が返されます。\n
    valueを文字列で渡す場合、データを2進数で表したものを渡してください(例:"1001111")
    """
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
    """
    引数valueの偶数パリティを文字列で返します。\n
    valueはstrかintで渡してください、それ以外の型では"-1"が返されます。\n
    valueを文字列で渡す場合、データを2進数で表したものを渡してください(例:"1001111")
    """
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
    """
    引数valueの水平垂直パリティ(奇数)を文字列のリストで返します。\n
    valueはstrかintで渡してください、それ以外の型では"-1"が返されます。\n
    valueを二進数に変換し、7つのまとまりに分けて(最後の方で要素が足りなくなった場合その分0を末尾に追加します。)それぞれ垂直パリティを計算します。\n
    それをまとまりの末尾に追加し、まとまりの同じインデックス同士で水平パリティを計算します。\n
    計算したパリティのみを["垂直パリティ","水平パリティ"]の形で返します。\n
    valueを文字列で渡す場合、データを2進数で表したものを渡してください(例:"10011110011011")
    """
    if not isinstance(value,str) and not isinstance(value,int):return "-1"
    if isinstance(value,int):
        value=bin(value)
    valueList=[]
    ret=["",""]
    for i in range((int)((len(value)+6)/7)):
        valueList.append(value[i*7])
        for j in range(1,7):
            ind=i*7+j
            if(ind<len(value)):valueList[i]+=value[ind]
            else:valueList[i]+="0"
    for i in range(len(valueList)):
        ret[0]+=odd_parity(valueList[i])
        valueList[i]+=odd_parity(valueList[i])
    for i in range(8):
        l=""
        for j in range(len(valueList)):
            l+=valueList[j][i]
        ret[1]+=odd_parity(l)
    return ret
def even_v_l_parity(value):
    """
    引数valueの水平垂直パリティ(偶数)を文字列のリストで返します。\n
    valueはstrかintで渡してください、それ以外の型では"-1"が返されます。\n
    valueを二進数に変換し、7つのまとまりに分けて(最後の方で要素が足りなくなった場合その分0を末尾に追加します。)それぞれ垂直パリティを計算します。\n
    それをまとまりの末尾に追加し、まとまりの同じインデックス同士で水平パリティを計算します。\n
    計算したパリティのみを["垂直パリティ","水平パリティ"]の形で返します。\n
    valueを文字列で渡す場合、データを2進数で表したものを渡してください(例:"10011110011011")
    """
    if not isinstance(value,str) and not isinstance(value,int):return "-1"
    if isinstance(value,int):
        value=bin(value)
    valueList=[]
    ret=["",""]
    for i in range((int)((len(value)+6)/7)):
        valueList.append(value[i*7])
        for j in range(1,7):
            ind=i*7+j
            if(ind<len(value)):valueList[i]+=value[ind]
            else:valueList[i]+="0"
    for i in range(len(valueList)):
        ret[0]+=even_parity(valueList[i])
        valueList[i]+=even_parity(valueList[i])
    for i in range(8):
        l=""
        for j in range(len(valueList)):
            l+=valueList[j][i]
        ret[1]+=even_parity(l)
    return ret
