import tkinter as tk
import pyautogui as pg
w=tk.Tk()
w.title('clicking')
w.geometry('600x500')
fot='Times New Roman'
c=tk.Canvas(w,width=600,height=500,bg='white')
c.pack()
ky=''
mosx=mosy=0
clicknow=False
c.create_text(200,110,fill='#aaa',font=(fot,30),text='Enterで座標を設定')
c.create_text(200,310,fill='#aaa',font=(fot,30),text='F1でクリック開始')
c.create_text(300,410,fill='#aaa',font=(fot,30),text='マウスを動かしてクリック停止')
def presskey(e):
    global ky,mosx,mosy
    ky=e.keysym
    if(ky=='Return'):
        p=pg.position()
        mosx=p[0]
        mosy=p[1]
        c.delete('pos')
        c.create_text(100,210,fill='#aaa',font=(fot,30),text='('+str(mosx)+','+str(mosy)+')',tag='pos')
def mainwork():
    global ky,mosy,mosx,clicknow
    if(ky=='F1'):
        clicknow = True
        ky=''
    if(clicknow):
        pg.click((mosx,mosy))
    if(clicknow):
        p=pg.position()
        if p[0]!=mosx or p[1]!=mosy:clicknow=False
    w.after(100,mainwork)
w.bind('<Key>',presskey)
mainwork()
w.mainloop()