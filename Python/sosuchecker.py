import sys

i=input()
if float(i).is_integer():
    i=int(i)
else:
    print('error')
    sys.exit()
if i<0:
    print('error')
    sys.exit()
if i==1:
    print('素数ではない')
    sys.exit()
a=[]
ns=0
for ic in range(2,i):
    if i%ic==0:
        ns=1
        a.append(ic)
if ns==1:
    print(i,'と１で割り切れます')
    for te in (a):
        print(te,'で割り切れます')
    print('素数ではない')
    sys.exit()
print(i,'と１で割り切れます')
print('素数です')