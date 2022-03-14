str=input()
list=[]
for c in str:
    list.append(ord(c))
def quick_sort(st,en):
    global list
    pip=0
    pi=0
    if(st<en):
        pip=st
        pi=list[int((st+en)/2)]
        list[int((st+en)/2)]=list[st]
        for i in range(st+1,en+1):
            if list[i]<pi:
                pip+=1
                sw=list[pip]
                list[pip]=list[i]
                list[i]=sw
        list[st]=list[pip]
        list[pip]=pi
        quick_sort(st,pip-1)
        quick_sort(pip+1,en)
quick_sort(0,len(list)-1)
ret=""
for c_i in list:
    ret+=chr(c_i)
print(ret)