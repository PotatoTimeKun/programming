import math as m
import decimal as d


def heron(a: float, b: float, c: float) -> float:
    """
    ヘロンの公式より三角形の面積を返します。
    a:辺aの長さ
    b:辺bの長さ
    c:辺cの長さ
    """
    s = (a+b+c)/2
    S = m.sqrt(s*(s-a)*(s-b)*(s-c))
    return S


def factorial(n: int) -> int:
    """nの階乗を返します。"""
    ret = 1
    for i in range(1, n+1):
        ret *= i
    return ret


def permutation(n: int, r: int) -> int:
    """nからr個選んだ順列(nPr)を返します。"""
    ret = factorial(n)/factorial(n-r)
    return ret


def combination(n: int, r: int) -> int:
    """nからr個選んだ組み合わせ(nCr)を返します。"""
    ret = permutation(n, r)/factorial(r)
    return ret


def GP_sum(a1: float, r: float, n: int) -> float:
    """
    等比数列の第n項までの総和を返します。
    a1:初項
    r:公比
    n:第n項
    """
    if(r == 1.0):
        return a1*n
    return a1*(1-r**n/(1-r))


def GP_n(a1: float, r: float, n: int) -> float:
    """
    等差数列の第n項までの総和を返します。
    a1:初項
    r:公比
    n:第n項
    """
    return a1*r**(n-1)


def AP_sum(a1: float, d: float, n: int) -> float:
    """
    等差数列の第n項までの総和を返します。
    a1:初項
    d:公差
    n:第n項
    """
    return n*(2*a1+(n-1)*d)/2


def AP_n(a1: float, d: float, n: int) -> float:
    """
    等差数列の第n項を返します。
    a1:初項
    d:公差
    n:第n項
    """
    return a1+(n-1)*d


def circle(r: float) -> float:
    """半径rから円周を返します。"""
    return 2*m.pi*r


def circle_s(r: float) -> float:
    """半径rから円の面積を返します。"""
    return m.pi*r*r


def sphere(r: float) -> float:
    """半径rから球の体積を返します。"""
    return 4/3*m.pi*r**3


def sphere_s(r: float) -> float:
    """半径rから球の表面積を返します。"""
    return 4*m.pi*r**2


def distance(x1: float, y1: float, x2: float, y2: float) -> float:
    """(x1,y1)と(x2,y2)の間の直線距離を返します。"""
    return m.sqrt((x2-x1)**2+(y2-y1)**2)


def divide_point(x1: float, y1: float, x2: float, y2: float, m: float, n: float) -> list:
    """(x1,y1)と(x2,y2)を結ぶ線分のm:nの内分点を[x,y]のリストで返します。"""
    return [(n*x1+m*x2)/(m+n), (n*y1+m*y2)/(m+n)]


def tri_cent(x1: float, y1: float, x2: float, y2: float, x3: float, y3: float) -> list:
    """
    三角形abcの重心を[x,y]のリストで返します。
    x1:頂点aのx
    y1:頂点aのy
    x2:頂点bのx
    y2:頂点bのy
    x3:頂点cのx
    y3:頂点cのy
    """
    return [(x1 + x2 + x3) / 3, (y1 + y2 + y3) / 3]


def focus(a: float, b: float) -> list:
    """楕円(x^2/a^2 + y^2/b^2 = 1)の2焦点を[x1,y1,x2,y2]のリストで返します。"""
    if(a > b):
        c = m.sqrt(a * a - b * b)
        return [c, 0, -c, 0]
    if(a < b):
        c = m.sqrt(b * b - a * a)
        return [0, c, 0, -c]
    return [0, 0, 0, 0]


def hyperbola_focus(a: float, b: float, n: int) -> list:
    """
    双曲線(x^2/a^2 + y^2/b^2 = n)の焦点を[x1,y1,x2,y2]のリストで返します。
    n:1か-1
    """
    if(int(n) == 1):
        c = m.sqrt(a * a + b * b)
        return [c, 0, -c, 0]
    if(int(n) == -1):
        c = m.sqrt(a * a + b * b)
        return [0, c, 0, -c]
    return [0, 0, 0, 0]


def cos_theorem(b: float, c: float, A: float) -> float:
    """
    三角形の2辺の長さとその間の角から、余剰定理により残りの1辺の長さを求めます。
    b:辺1
    c:辺2
    A:その間の角(ラジアン値)
    """
    return (b**2+c**2-2*b*c*m.cos(A))**0.5


def sin_theorem(A: float, B: float, a: float) -> float:
    """
    三角形ABC(角A,B,Cに対する位置の辺をa,b,cとする)のaとA,Bから、正弦定理によりbを求めます。
    A,B:ラジアン値
    """
    return a/m.sin(A)*m.sin(B)


def rad(arc: float) -> float:
    """60分法の角度をラジアンに変換します。"""
    return arc/180*m.pi


def arc(rad: float) -> float:
    """ラジアンを60分法に変換します。"""
    return rad*180/m.pi


def tri_S(b: float, c: float, A: float) -> float:
    """
    三角形の2辺とその間の角から三角形の面積を求めます。
    b:辺1
    c:辺2
    A:その間の角(ラジアン値)
    """
    return 1/2*b*c*m.sin(A)


class mathVector:
    """
    平面のベクトルを扱うクラスです。
    コンストラクタ:x成分,y成分を指定
    onGraph:クラスメソッド、始点と終点を指定してベクトルを返す
    naiseki:内積
    +:ベクトル同士の加法
    -:ベクトル同士の減法
    *:ベクトルと数値の乗法
    ==:等しいかどうか
    !=:等しくないかどうか
    """
    v1 = 0
    v2 = 0
    ang = None

    def __init__(self, v_x=0, v_y=0):
        """
        v_x:ベクトルのx成分
        v_y:ベクトルのy成分
        """
        self.v1 = v_x
        self.v2 = v_y
        if v_y == 0 and v_x == 0:
            ang = None
        else:
            v = cos_theorem(self.v1, self.v2, m.pi/2)
            self.ang = m.asin(self.v2/v)
            if(self.v1 < 0):
                self.ang = m.pi-self.ang

    @classmethod
    def onGraph(x1: float, y1: float, x2: float, y2: float):
        """
        mathVectorを返します。
        (x1,y1):ベクトルの始点
        (x2,y2):ベクトルの終点
        """
        ret = mathVector(x2-x1, y2-y1)
        return ret

    def naiseki(self, otherVector):
        return self.v1*otherVector.v1+self.v2*otherVector.v2

    def __add__(self, otherVector):
        ret = mathVector(self.v1+otherVector.v1, self.v2+otherVector.v2)
        return ret

    def __sub__(self, otherVector):
        ret = mathVector(self.v1-otherVector.v1, self.v2-otherVector.v2)
        return ret

    def __mul__(self, other):
        if(isinstance(other, int) or isinstance(other, float)):
            ret = mathVector(other*self.v1, other*self.v2)
            return ret

    def __rmul__(self, other):
        if(isinstance(other, int) or isinstance(other, float)):
            ret = mathVector(other*self.v1, other*self.v2)
            return ret

    def __eq__(self, other) -> bool:
        if(isinstance(other, mathVector)):
            return (self.v1 == other.v1) and (self.v2 == other.v2)
        else:
            return False

    def __ne__(self, other) -> bool:
        if(isinstance(other, mathVector)):
            return (self.v1 != other.v1) or (self.v2 != other.v2)
        else:
            return True


def vecValue(vec: mathVector) -> float:
    """ベクトルの大きさを返します。(つまり|→vec|)"""
    return (vec.v1**2+vec.v2**2)**0.5


def differential(func):
    """引数に渡した関数を微分して導関数を返します。"""
    def ret(x):
        return (func(x+0.00000000001)-func(x))/(0.00000000001)
    return ret


def dif_decimal(func):
    """引数に渡した関数を微分して導関数を返します。
    値をすべてdecimal型で扱い、小数点以下15で切り捨てます。
    引数に渡す関数の処理においてもdecimal型を用いてください。
    導関数において微分係数を導く時の引数が小数ならそれもdecimal型にしてください。"""
    def ret(x):
        d.getcontext().prec = 100
        return round((func(x+d.Decimal('0.00000000000000000000000000000001'))-func(x))/(d.Decimal('0.00000000000000000000000000000001')), 15)
    return ret


def show_table(func, firstList: list, secondList: list, strLen=10) -> None:
    """
    引数が2つある関数に、2つのリストから全ての場合で順に値を渡して、表を表示します。
    Args:
        func (function): 関数
        firstList (list): 要素が関数の第一引数となるリスト
        secondList (list): 要素が関数の代に引数となるリスト
        strLen (int, optional): 表の列の横幅(左寄せに使う). Defaults to 10.
    """
    print("fir\\sec".ljust(strLen), end='')
    for i in secondList:
        print(str(i).ljust(strLen), end='')
    print()  # 改行
    for i in firstList:
        print(str(i).ljust(strLen), end='')
        for j in secondList:
            print(str(func(i, j)).ljust(strLen), end='')
        print()


def prime_fact(i: int) -> int:
    """
    引数の値で素因数分解を行い、素因数をリストで返します。(昇順・重複あり)\n
    引数が小数や1以下の場合[-1]が返されます。
    """
    if float(i).is_integer():
        i = int(i)
    else:
        return [-1]
    if i < 2:
        return [-1]
    res = []
    doing = True
    while doing:
        for n in range(2, i):
            check = divmod(i, n)
            if check[1] == 0:
                res.append(n)
                i = check[0]
                break
        else:
            res.append(i)
            doing = False
    return res


def yakubun(a, b)->str:
    """
    a/bを約分した状態の文字列を返します。
    a>0,b>0,a!=1,b!=1で動きます。
    a,bは数字でも文字列でもいいですが、一応小数は文字列にすることをおすすめします
    """
    a = str(a)
    b = str(b)
    a = a[::-1]
    b = b[::-1]
    a_dot = 0
    b_dot = 0
    try:
        a_dot = a.index('.')
    except:
        a = '.'+a
    try:
        b_dot = b.index('.')
    except:
        b = '.'+b
    if(a_dot == b_dot):
        a = a[:a_dot]+a[a_dot+1:]
        b = b[:b_dot]+b[b_dot+1:]
    elif(a_dot > b_dot):
        a = a[:a_dot]+a[a_dot+1:]
        b = '0'*(a_dot-b_dot)+b[:b_dot]+b[b_dot+1:]
    else:
        a = '0'*(b_dot-a_dot)+a[:a_dot]+a[a_dot+1:]
        b = b[:b_dot]+b[b_dot+1:]
    a = int(a[::-1])
    b = int(b[::-1])
    a_lis = prime_fact(a)
    b_lis = prime_fact(b)
    i = 0
    while(i < len(a_lis)):
        for j in range(len(b_lis)):
            if(a_lis[i] == b_lis[j]):
                a_lis = a_lis[:i]+a_lis[i+1:]
                b_lis = b_lis[:j]+b_lis[j+1:]
                i -= 1
                break
        i += 1
    a = 1
    for i in a_lis:
        a *= i
    b = 1
    for i in b_lis:
        b *= i
    return str(a)+"/"+str(b)
