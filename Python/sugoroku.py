def print_sugoroku(point=[],name=[])->None:
    """
    すごろくの盤面を文字列で表現します。  
    すごろくの点数をリストで受け取ります。  
    盤面上の名前をリストで受け取ります。名前の数が足りない場合は数字が入ります。
    """
    for i in range(0,len(point)):
        try:
            print('-'*(point[i]-1)+name[i]+'-'*(29-point[i])+'Goal')
        except:
            print('-'*(point[i]-1)+i+'-'*(29-point[i])+'Goal')
from random import randint as ri
p=1
c=1
print_sugoroku([p,c],['P','C'])
print('スゴロクスタート!(Pがプレイヤーです)\nEnterを押すと進みます')
while True:
    input()
    a=ri(1,6)
    b=ri(1,6)
    p+=a
    c+=b
    print(f'プレイヤー:{a}を出しました')
    print(f'コンピューター:{b}を出しました')
    if p>=30 and c<30:
        print('-'*(29)+'Goal P')
        print('-'*(c-1)+'C'+'-'*(29-c)+'Goal')
        print('You win!')
        break
    elif p<30 and c>=30:
        print('-'*(p-1)+'P'+'-'*(29-p)+'Goal')
        print('-'*(29)+'Goal C')
        print('You lose...')
        break
    elif p>=30 and c>=30:
        print('-'*(29)+'Goal P')
        print('-'*(29)+'Goal C')
        print('Draw!')
        break
    else:
        print_sugoroku([p,c],['P','C'])