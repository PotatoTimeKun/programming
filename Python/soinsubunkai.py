"""素因数分解を扱います。"""
def prime_fact(i):
    """
    引数の値で素因数分解を行い、素因数をリストで返します。(昇順・重複あり)\n
    引数が小数や1以下の場合[-1]が返されます。
    """
    if float(i).is_integer():
        i=int(i)
    else:
        return [-1]
    if i<2:
        return [-1]
    res=[]
    doing=True
    while doing:
        for n in range(2,i):
            check=divmod(i,n)
            if check[1]==0:
                res.append(n)
                i=check[0]
                break
        else:
            res.append(i)
            doing=False
    return res
if __name__=="__main__":
    inp=input()
    print(prime_fact(inp))
