def pr_ma(su1,su2):
    print('-'*(su1-1)+'P'+'-'*(29-su1)+'Goal')
    print('-'*(su2-1)+'C'+'-'*(29-su2)+'Goal')
from random import randint as ri
p=1
c=1
pr_ma(p,c)
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
        pr_ma(p,c)