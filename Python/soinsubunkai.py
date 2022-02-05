import sys
def soi(i):
    if float(i).is_integer():
        i=int(i)
    else:
        print('error')
        sys.exit()
    if i<2:
        print('error')
        sys.exit()
    res=[]
    bo=0
    while bo==0:
        for co in range(2,i):
            ch=divmod(i,co)
            if ch[1]==0:
                res.append(co)
                i=ch[0]
                break
        else:
            res.append(i)
            bo=1
    ress=""
    for t in range(len(res)-1):
        ress=ress+str(res[t])+'*'
    else:
        try:
            ress=ress+str(res[t+1])
        except:
            ress=str(i)
    return ress
if __name__=="__main__":
    a=input()
    print(soi(a))