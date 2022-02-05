inp=input()
toppo="toppo"
res=""
index=0
t_ind=0
inp+="x"
for i in inp:
    if(index==5):
        index=0
    if(i==toppo[index]):
        index+=1
        res+=i
    else:
        res+="*"
res=res[0:len(res)-1]
print(res)