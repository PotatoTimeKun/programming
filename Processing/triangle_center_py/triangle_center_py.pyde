tri=[100,50,10,500,600,400]
def setup():
    size(600,600)
    noLoop()
def draw():
    background(255)
    fill(50,50,255)
    triangle(tri[0],tri[1],tri[2],tri[3],tri[4],tri[5])
    strokeWeight(10)
    cent=tri_cent(tri[0],tri[1],tri[2],tri[3],tri[4],tri[5])
    point(cent[0],cent[1])
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
