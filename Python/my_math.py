import math as m
def heron(a,b,c):
    """
    ヘロンの公式より三角形の面積を返します。
    a:辺aの長さ
    b:辺bの長さ
    c:辺cの長さ
    """
    s=(a+b+c)/2
    S=m.sqrt(s*(s-a)*(s-b)*(s-c))
    return S
def factorial(n):
    """nの階乗を返します。"""
    ret=1
    for i in range(1,n+1):
        ret*=i
    return ret
def combination(n,r):
    """nからr個選んだ組み合わせ(nCr)を返します。"""
    ret=factorial(n)/factorial(n-r)
    return ret
def permutation(n,r):
    """nからr個選んだ順列(nPr)を返します。"""
    ret=combination(n,r)/factorial(r)
    return ret
def GP_sum(a1,r,n):
    """
    等比数列の第n項までの総和を返します。
    a1:初項
    r:公比
    n:第n項
    """
    if(r==1.0):return a1*n
    return a1*(1-r**n/(1-r))
def GP_n(a1,r,n):
    """
    等差数列の第n項までの総和を返します。
    a1:初項
    r:公比
    n:第n項
    """
    return a1*r**(n-1)
def AP_sum(a1,d,n):
    """
    等差数列の第n項までの総和を返します。
    a1:初項
    d:公差
    n:第n項
    """
    return n*(2*a1+(n-1)*d)/2
def AP_n(a1,d,n):
    """
    等差数列の第n項を返します。
    a1:初項
    d:公差
    n:第n項
    """
    return a1+(n-1)*d
def circle(r):
    """半径rから円周を返します。"""
    return 2*m.pi*r
def circle_s(r):
    """半径rから円の面積を返します。"""
    return m.pi*r*r
def sphere(r):
    """半径rから球の体積を返します。"""
    return 4/3*m.pi*r**3
def sphere_s(r):
    """半径rから球の表面積を返します。"""
    return 4*m.pi*r**2
def distance(x1,y1,x2,y2):
    """(x1,y1)と(x2,y2)の間の直線距離を返します。"""
    return m.sqrt((x2-x1)**2+(y2-y1)**2)
def divide_point(x1,y1,x2,y2,m,n):
    """(x1,y1)と(x2,y2)を結ぶ線分のm:nの内分点を[x,y]のリストで返します。"""
    return [(n*x1+m*x2)/(m+n),(n*y1+m*y2)/(m+n)]
def tri_cent(x1,y1,x2,y2,x3,y3):
    """
    三角形abcの重心を[x,y]のリストで返します。
    x1:頂点aのx
    y1:頂点aのy
    x2:頂点bのx
    y2:頂点bのy
    x3:頂点cのx
    y3:頂点cのy
    """
    return [(x1 + x2 + x3) / 3,(y1 + y2 + y3) / 3]
def focus(a,b):
    """楕円(x^2/a^2 + y^2/b^2 = 1)の2焦点を[x1,y1,x2,y2]のリストで返します。"""
    if(a>b):
        c=m.sqrt(a * a - b * b)
        return [c, 0, -c, 0]
    if(a<b):
        c=m.sqrt(b * b - a * a)
        return [0, c, 0, -c]
    return [0,0,0,0]
def hyperbola_focus(a,b,n):
    """
    双曲線(x^2/a^2 + y^2/b^2 = n)の焦点を[x1,y1,x2,y2]のリストで返します。
    n:1か-1
    """
    if(int(n)==1):
        c=m.sqrt(a * a + b * b)
        return [c, 0, -c, 0]
    if(int(n)==-1):
        c=m.sqrt(a * a + b * b)
        return [0, c, 0, -c]
    return [0,0,0,0]
def cos_theorem(b,c,A):
    """
    三角形の2辺の長さとその間の角から、余剰定理により残りの1辺の長さを求めます。
    b:辺1
    c:辺2
    A:その間の角(ラジアン値)
    """
    return b**2+c**2-2*b*c*m.cos(A)
def sin_theorem(A,B,a):
    """
    三角形ABC(角A,B,Cに対する位置の辺をa,b,cとする)のaとA,Bから、正弦定理によりbを求めます。
    A,B:ラジアン値
    """
    return a/m.sin(A)*m.sin(B)
def rad(arc):
    """60分法の角度をラジアンに変換します。"""
    return arc/180*m.pi
def arc(rad):
    """ラジアンを60分法に変換します。"""
    return rad*180/m.pi
def tri_S(b,c,A):
    """
    三角形の2辺とその間の角から三角形の面積を求めます。
    b:辺1
    c:辺2
    A:その間の角(ラジアン値)
    """
    return 1/2*b*c*m.sin(A)
class mathVector:
    """ベクトルを扱うクラスです。"""
    v1=0
    v2=0
    ang=None
    def __init__(self) -> None:
        pass
    def __init__(self,v_x:float,v_y:float,angle: float) -> None:
        """
        v_x:ベクトルのx成分
        v_y:ベクトルのy成分
        angle:ベクトルの角度
        """
        self.v1=v_x
        self.v2=v_y
        self.ang=angle
    def __init__(self,x1:float,y1:float,x2:float,y2:float) -> None:
        """
        (x1,y1):ベクトルの始点
        (x2,y2):ベクトルの終点
        """
        self.v1=x2-x1
        self.v2=y2-y1
        v=cos_theorem(self.v1,self.v2,m.pi/2)
        self.ang=m.asin(self.v2/v)
        if(self.v1<0):self.ang=m.pi-self.ang
def vecValue(vec:mathVector)-> int:
    """ベクトルの大きさを返します。"""
    return (vec.v1**2+vec.v2**2)**0.5