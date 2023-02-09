import math as m
import decimal as d
from decimal import Decimal as deci
from copy import deepcopy

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
    if (r == 1.0):
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
    if (a > b):
        c = m.sqrt(a * a - b * b)
        return [c, 0, -c, 0]
    if (a < b):
        c = m.sqrt(b * b - a * a)
        return [0, c, 0, -c]
    return [0, 0, 0, 0]


def hyperbola_focus(a: float, b: float, n: int) -> list:
    """
    双曲線(x^2/a^2 + y^2/b^2 = n)の焦点を[x1,y1,x2,y2]のリストで返します。
    n:1か-1
    """
    if (int(n) == 1):
        c = m.sqrt(a * a + b * b)
        return [c, 0, -c, 0]
    if (int(n) == -1):
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
    onGraph:始点と終点を指定してベクトルを返す
    naiseki:内積
    size:ベクトルの大きさ
    set:ベクトルの更新
    +:ベクトル同士の加法
    -:ベクトル同士の減法
    *:ベクトルと数値の乗法
    /:ベクトルと数値の除法
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
        self.set(v_x, v_y)

    def set(self, v_x, v_y):
        """
        v_x:ベクトルのx成分
        v_y:ベクトルのy成分
        """
        self.v1 = v_x
        self.v2 = v_y
        if v_y == 0 and v_x == 0:
            self.ang = None
        else:
            v = (v_x**2+v_y**2)**0.5
            self.ang = m.asin(v_y/v)
            if (v_x < 0):
                self.ang = m.pi-self.ang

    @classmethod
    def onGraph(self, x1: float, y1: float, x2: float, y2: float):
        """
        mathVectorを返します。
        (x1,y1):ベクトルの始点
        (x2,y2):ベクトルの終点
        """
        return __class__(x2-x1, y2-y1)

    def size(self):
        """
        ベクトルの大きさ(|→V|)を返します
        """
        return (self.v1**2+self.v2**2)**0.5

    def naiseki(self, otherVector):
        """
        自身と引数のベクトルとの内積を返します。
        """
        if (isinstance(otherVector, self.__class__)):
            return self.v1*otherVector.v1+self.v2*otherVector.v2
        else:
            raise Exception("内積はベクトルを引数としてください")

    def __add__(self, otherVector):  # vec(self) + vec(otherVector)
        if (isinstance(otherVector, self.__class__)):
            return self.__class__(self.v1+otherVector.v1, self.v2+otherVector.v2)
        else:
            raise Exception("+はベクトル量との加算です")

    def __sub__(self, otherVector):  # vec(self) - vec(otherVector)
        if (isinstance(otherVector, self.__class__)):
            return self.__class__(self.v1-otherVector.v1, self.v2-otherVector.v2)
        else:
            raise Exception("-はベクトル量との減算です")

    def __mul__(self, other):  # vec(self) * sca(other)
        if (isinstance(other, int) or isinstance(other, float)):
            return self.__class__(other*self.v1, other*self.v2)
        else:
            raise Exception("*はスカラー量との乗算です")

    def __rmul__(self, other):  # sca(other) * vec(self)
        if (isinstance(other, int) or isinstance(other, float)):
            return self.__class__(other*self.v1, other*self.v2)
        else:
            raise Exception("*はスカラー量との乗算です")

    def __truediv__(self, other):  # vec(self) / sca(other)
        if (isinstance(other, int) or isinstance(other, float)):
            return self.__class__(self.v1/other, self.v2/other)
        else:
            raise Exception("/はスカラー量との除算です")

    def __eq__(self, other):  # self == other
        if (isinstance(other, self.__class__)):
            return (self.v1 == other.v1) and (self.v2 == other.v2)
        else:
            return False

    def __ne__(self, other):  # self != other
        if (isinstance(other, self.__class__)):
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


def yakubun(a, b) -> str:
    """
    a/bを約分した状態の文字列を返します。
    bに0を入れるとエラーを返します。  
    a,bは数字でも文字列でもいいですが、一応小数は文字列にすることをおすすめします
    """
    if (float(b) == 0):
        raise Exception("function yakubun:0で割らないでください")
    sign = float(a)/abs(float(a))*float(b)/abs(float(b))  # 結果の符号
    a = str(a)
    b = str(b)
    if (a[0] == '-'):  # -は取る
        a = a[1:]
    if (b[0] == '-'):
        b = b[1:]
    # 以下は小数点以下の桁数を揃える
    a = a[::-1]  # 逆順に
    b = b[::-1]
    a_dot = 0  # .の位置
    b_dot = 0
    try:
        a_dot = a.index('.')
    except:
        a = '.'+a  # .がない場合追加する
    try:
        b_dot = b.index('.')
    except:
        b = '.'+b
    if (a_dot == b_dot):  # 小数点以下の桁数が同じ
        a = a[:a_dot]+a[a_dot+1:]  # .を消す
        b = b[:b_dot]+b[b_dot+1:]
    elif (a_dot > b_dot):  # aの方が小数点以下の桁数が多い
        a = a[:a_dot]+a[a_dot+1:]  # aは.を消す
        b = '0'*(a_dot-b_dot)+b[:b_dot]+b[b_dot+1:]  # bは差の分0を追加し.を消す
    else:  # a_dot < b_dot
        a = '0'*(b_dot-a_dot)+a[:a_dot]+a[a_dot+1:]
        b = b[:b_dot]+b[b_dot+1:]
    a = int(a[::-1])  # 逆順から戻し、整数に
    b = int(b[::-1])
    # 以下は素因数分解して同じ値を消す
    a_lis = prime_fact(a)  # 素因数分解
    if (a_lis[0] == -1):
        a_lis = [a]  # 素因数分解不可→0もしくは1
    b_lis = prime_fact(b)
    if (b_lis[0] == -1):
        b_lis = [1]  # 素因数分解不可→1
    i = 0
    while (i < len(a_lis)):
        for j in range(len(b_lis)):
            if (a_lis[i] == b_lis[j] != 1):
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
    ret = ""
    if (sign < 0):
        ret = "-"
    ret += str(a)
    if (a != 0 and b != 1):
        ret += "/"+str(b)
    return ret


def prime_num(start: int, end: int) -> list:
    """
    第一引数から第二引数-1までの素数をリストで返します。
    """
    numlist = []
    for i in range(start, end):
        is_sosu = True
        for n in range(2, i):
            if i % n == 0:
                is_sosu = False
        if is_sosu and i >= 2:
            numlist.append(i)
    return numlist


def check_prime(i: int) -> bool:
    """
    引数が素数かどうか判断し、素数ならTrue、素数でなければFalseを返します。
    """
    if float(i).is_integer():
        i = int(i)
    else:
        return False
    if i < 2:
        return False
    for ic in range(2, i):
        if i % ic == 0:
            return False
    return True


def atan(x):
    """
    arctan(x)をテイラー展開して求めています。
    桁数を保持するために、strで返します。
    """
    savedContext = d.getcontext().prec
    d.getcontext().prec = 100  # 桁数設定
    powerdX = x
    sumValue = deci(0)
    sign = 1
    for i in range(5000):  # arctan(x)=x-(x**3)/3+(x**5)/5-(x**7)/7...
        sumValue += sign/(deci(2)*i+1)*powerdX
        powerdX *= x*x
        sign *= -1
    strSumValue=str(sumValue)
    d.getcontext().prec = savedContext
    return strSumValue

def asin(x):
    """
    arcsin(x)をテイラー展開して求めています。
    桁数を保持するために、strで返します。
    """
    savedContext=d.getcontext().prec
    d.getcontext().prec=100
    poweredX=x
    n2kaijo=deci(1)
    nkaijo=deci(1)
    njou4=deci(1)
    sumValue=deci(0)
    for i in range(5000):
        sumValue+=poweredX*(n2kaijo/(njou4*nkaijo*nkaijo*(2*i+1)))
        poweredX*=x*x
        n2kaijo*=(2*i+1)*(2*i+2)
        nkaijo*=2*i+1
        njou4*=4
    strSumValue=str(sumValue)
    d.getcontext().prec=savedContext
    return strSumValue

def acos(x):
    """
    arccos(x) = pi/2 - arcsin(x)
    strで返します。
    """
    savedContext=d.getcontext().prec
    d.getcontext().prec=100
    piPer2=2*(2*deci(atan(deci(1)/3))+deci(atan(deci(1)/7)))
    deciAcos=str(piPer2 - deci(asin(deci(x))))
    d.getcontext().prec=savedContext
    return deciAcos

class mathMatrix:
    """
    行列を扱う
    コンストラクタ:行数,列数,内容(2次元リスト)
    determinant:行列式の計算
    """
    value=[]
    rowSize=0
    columnSize=0
    def __init__(self,row=1,column=1,lists=[[0]]):
        self.rowSize=row
        self.columnSize=column
        if(len(lists)!=row):
            raise Exception("error:(mathMatrix class constructor)illegal size")
        for i in range(row):
            if(len(lists[i])!=column):
                raise Exception("error:(mathMatrix class constuctor)illegal size")
        self.value=lists
    def determinant(self):
        """
        行列式を計算して返す
        """
        if(self.rowSize!=self.columnSize):
            raise Exception("error:(mathMatrix class function determinant)must be square")
        def split(lists): # 行列式を1行目に関する小行列式に分解して再帰的に計算
            if(len(lists)==1):return lists[0][0]
            if(len(lists)==2):return lists[0][0]*lists[1][1]-lists[0][1]*lists[1][0]
            sumValue=0
            for i in range(len(lists)):
                splited=[]
                for j in range(1,len(lists)):
                    splited.append([])
                    for k in range(len(lists)):
                        if(k==i):continue
                        splited[j-1].append(lists[j][k])
                sign=1
                if(i%2==1):sign=-1
                sumValue+=sign*lists[0][i]*split(splited)
            return sumValue
        return split(self.value)
    def inverse(self):
        """
        逆行列を計算してmathMatrixクラスのインスタンスで返す
        """
        if(self.rowSize!=self.columnSize):
            raise Exception("error:(mathMatrix class function inverse)must be square")
        selfDeterminant=self.determinant()
        if(selfDeterminant==0):
            raise Exception("error:(mathMatrix class function inverse)must be regular")
            # 行列式が0->正則でない
        invLists=[]
        for i in range(self.rowSize):
            sign=1
            if(i%2==1):sign=-1
            invLists.append([])
            for j in range(self.columnSize):
                minor=[] # 余因子(j,i)
                for k in range(self.rowSize):
                    if(k==j):continue
                    minor.append([])
                    for l in range(self.columnSize):
                        if(l==i):continue
                        minor[-1].append(self.value[k][l])
                minorDeterminant=self.__class__(self.rowSize-1,self.columnSize-1,minor).determinant()
                invLists[i].append(sign*minorDeterminant/selfDeterminant) # A^-1(i,j)=符号*余因子(j,i)/|A|
                sign*=-1
        return self.__class__(self.rowSize,self.columnSize,invLists)
    def transpose(self):
        """
        転置行列を返す
        """
        lists=[]
        for i in range(self.columnSize): # (i,j)=(j,i)
            lists.append([])
            for j in range(self.rowSize):
                lists[i].append(self.value[j][i])
        return self.__class__(self.columnSize,self.rowSize,lists)
    def __add__(self, otherMatrix):
        if (not isinstance(otherMatrix, self.__class__)):
            raise Exception("error:(mathMatrix class operator)not defined type")
        if(self.rowSize!=otherMatrix.rowSize or self.columnSize!=otherMatrix.columnSize):
            raise Exception("error:(mathMatrix class operator)illegal size")
        addLists=deepcopy(self.value)
        for i in range(self.rowSize):
            for j in range(self.columnSize):
                addLists[i][j]+=otherMatrix.value[i][j]
        return self.__class__(self.rowSize,self.columnSize,addLists)
    def __sub__(self, otherMatrix):
        if (not isinstance(otherMatrix, self.__class__)):
            raise Exception("error:(mathMatrix class operator)not defined type")
        if(self.rowSize!=otherMatrix.rowSize or self.columnSize!=otherMatrix.columnSize):
            raise Exception("error:(mathMatrix class operator)illegal size")
        addLists=deepcopy(self.value)
        for i in range(self.rowSize):
            for j in range(self.columnSize):
                addLists[i][j]-=otherMatrix.value[i][j]
        return self.__class__(self.rowSize,self.columnSize,addLists)
    def __mul__(self,operand):
        if(isinstance(operand,int) or isinstance(operand,float)): # スカラー量との乗算,各要素をoperand倍に
            lists=deepcopy(self.value)
            for i in range(self.rowSize):
                for j in range(self.columnSize):
                    lists[i][j]*=operand
            return self.__class__(self.rowSize,self.columnSize,lists)
        if(not isinstance(operand,self.__class__)):
            raise Exception("error:(mathMatrix class operator)not defined type")
        if(self.columnSize!=operand.rowSize):
            raise Exception("error:(mathMatrix class operator)illegal size")
        # 行列同士の乗算
        mulLists=[]
        for i in range(self.rowSize):
            mulLists.append([])
            for j in range(operand.columnSize):
                mulLists[i].append(0)
                for k in range(self.columnSize):
                    mulLists[i][j]+=self.value[i][k]*operand.value[k][j] #(i,j)=Σ[k=1->n]A(i,k)*B(k,j)
        return self.__class__(self.rowSize,operand.columnSize,mulLists)
    def __rmul__(self,operand):
        if(isinstance(operand,int) or isinstance(operand,float)): # スカラー量との乗算,各要素をoperand倍に
            lists=deepcopy(self.value)
            for i in range(self.rowSize):
                for j in range(self.columnSize):
                    lists[i][j]*=operand
            return self.__class__(self.rowSize,self.columnSize,lists)
        raise Exception("error:(mathMatrix class operator)not defined type")
    def __truediv__(self,operand):
        if(isinstance(operand,int) or isinstance(operand,float)): # スカラー量との除算
            lists=deepcopy(self.value)
            for i in range(self.rowSize):
                for j in range(self.columnSize):
                    lists[i][j]/=operand
            return self.__class__(self.rowSize,self.columnSize,lists)
        raise Exception("error:(mathMatrix class operator)not defined type")
    def __eq__(self,operand):
        if(not isinstance(operand,self.__class__)):return False
        if(self.value==operand.value):return True
        return False
    def __ne__(self,operand):
        return not(self==operand)

def cramer(argument,equals):
    """
    クラメルの公式を用いて連立方程式を解く
    argumentは係数行列(2次元リスト)
    equalsは連立する式の定数(ax+by=cのc,リスト)
    解をリストで返す、解がない場合空リストを返す
    """
    argMatrix=mathMatrix(len(argument),len(argument),argument)
    argDeterminant=argMatrix.determinant()
    if(argDeterminant==0): # 係数行列の行列式が0->解なし
        return []
    answer=[]
    for i in range(len(argument)):
        iArgument=deepcopy(argument)
        for j in range(len(argument)):
            iArgument[j][i]=equals[j]
        iArgMatrix=mathMatrix(len(argument),len(argument),iArgument)
        answer.append(iArgMatrix.determinant()/argDeterminant)
    return answer

def gcd(a,b):
    """
    最大公約数(gcd)を返す
    """
    if(not isinstance(a,int) or not isinstance(b,int)):
        raise Exception("error:(function gcd)a,b must be int")
    if(a<=0 or b<=0):
        raise Exception("error:(function gcd)a,b must be positive")
    # ユークリッドの互除法
    r=max(a,b)%min(a,b)
    if(r==0):
        return min(a,b)
    return gcd(r,min(a,b))