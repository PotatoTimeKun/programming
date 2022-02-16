from random import randint
list=[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
copy=[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
toppo=['t','o','p','p','o']
for i in range(5):
    for j in range(5):
        list[i][j]=toppo[randint(0,4)]
while(True):
    for i in range(5):
        print(i,end='')
        print(list[i])
    print("   0    1    2    3    4")
    print("right:r,left:l,up:u,down:d")
    rlud=input()
    print("line")
    line=input()
    print("value")
    value=input()
    for i in range(5):
        for j in range(5):
            copy[i][j]=list[i][j]
    if(rlud=='r'):
        for i in range(5):
            list[int(line)][i]=copy[int(line)][(i-int(value))%5]
    if(rlud=='l'):
        for i in range(5):
            list[int(line)][i]=copy[int(line)][(i+int(value))%5]
    if(rlud=='u'):
        for i in range(5):
            list[i][int(line)]=copy[(i+int(value))%5][int(line)]
    if(rlud=='d'):
        for i in range(5):
            list[i][int(line)]=copy[(i-int(value))%5][int(line)]
