"""素数を扱います。"""
def prime_num(start:int,end:int)->list:
    """
    第一引数から第二引数-1までの素数をリストで返します。
    """
    numlist=[]
    for i in range(start,end):
        is_sosu=True
        for n in range(2,i):
            if i%n==0:
                is_sosu=False
        if is_sosu and i >= 2:
            numlist.append(i)
    return numlist
if __name__=="__main__":
    print("start=",end="")
    s=input()
    print("end=",end="")
    e=input()
    for i in prime_num(int(s),int(e)):
          print(i)
