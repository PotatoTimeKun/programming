def bubble(array):
    for i in range(2,len(array)):
        for j in range(len(array)-i):
            if array[j]>array[j+1]:
                sw=array[j]
                array[j]=array[j+1]
                array[j+1]=sw
def select(array):
    for i in range(len(array)-1):
        min=i
        for j in range(i,len(array)-1):
            if array[min]>array[j]:min=j
        sw=array[i]
        array[i]=array[min]
        array[min]=sw
def insert(array):
    for i in range(2,len(array)):
        for j in reversed(range(1,i)):
            if(array[j-1]<array[j]):break
            else:
                sw=array[j]
                array[j]=array[j-1]
                array[j-1]=sw
def shell(array):
    for c in reversed(range(1,4)):
        for i in range(2,len(array),c):
            for p in range(0,c):
                for j in reversed(range(c+p,i,c)):
                    if(array[j-c]<array[j]):break
                    else:
                        sw=array[j]
                        array[j]=array[j-c]
                        array[j-c]=sw
def quick(array,start=0,end=-1):
    if(end==-1):end=len(array)-1
    if(start<end):
        pip=start
        pi=array[int((start+end)/2)]
        array[int((start+end)/2)]=array[start]
        for i in range(start+1,end+1):
            if array[i]<pi:
                pip+=1
                sw=array[pip]
                array[pip]=array[i]
                array[i]=sw
        array[start]=array[pip]
        array[pip]=pi
        quick(array,start,pip-1)
        quick(array,pip+1,end)
def marge(array):
    def mar(st,mid,en):
        S=[]
        E=[]
        for i in range(st,mid):
            S.append(array[i])
        for i in range(mid,en):
            E.append(array[i])
        S.append(max(array)+1)
        E.append(max(array)+1)
        i=0
        j=0
        for k in range(st,en):
            if S[i]<=E[j]:
                array[k]=S[i]
                i+=1
            else:
                array[k]=E[j]
                j+=1
    def sort(st,en):
        if(st+1<en):
            mid=int((st+en)/2)
            sort(st,mid)
            sort(mid,en)
            mar(st,mid,en)
    sort(0,len(array))