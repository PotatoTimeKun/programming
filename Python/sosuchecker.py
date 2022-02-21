"""素数を調べる関数を扱います。"""
def check_prime(i):
    """
    引数が素数かどうか判断し、素数ならTrue、素数でなければFalseを返します。
    """
    if float(i).is_integer():
        i=int(i)
    else:
        return False
    if i<2:
        return False
    for ic in range(2,i):
        if i%ic==0:
            return False
    return True
if __name__=="__main__":
    inp=input()
    print(check_prime(inp))
