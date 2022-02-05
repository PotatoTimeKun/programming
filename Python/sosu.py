so=[]
for i in range(3,10001):
    a=0
    for ic in range(2,i):
        if i%ic==0:
            a=1
    if a==0:
        so.append(i)
print(so)