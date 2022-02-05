import tkinter as tk
import time as ti
from random import randint as ri
r=tk.Tk()
r.title('すごろくゲーム')
r.geometry('1200x600')
r.resizable(False,False)
p=0
c=0
game='c'
def go():
    global p,c,ca,r,game
    if game=="c":
        labp=tk.Label(r,text='',bg="#40a0c0",fg='white',font=('Times New Roman',40))
        labp.place(x=600,y=400)
        labc=tk.Label(r,text='',bg="#40a0c0",fg='white',font=('Times New Roman',40))
        labc.place(x=600,y=460)
        for i in range(10):
            labp['text']='Prayer:'+str(ri(1,6))
            labp.update()
            ti.sleep(0.1)
        pp=ri(1,6)
        cc=ri(1,6)
        labp['text']='Prayer:'+str(pp)
        labp.update()
        p+=pp
        if p>19:
            p=19
        ca.delete('kp')
        ca.create_oval(110+50*p,110,140+50*p,140,fill='blue',width=0,tag='kp')
        for i in range(10):
            labc['text']='Computer:'+str(ri(1,6))
            labc.update()
            ti.sleep(0.1)
        labc['text']='Computer:'+str(cc)
        labc.update()
        c+=cc
        if c>19:
            c=19
        ca.delete('kc')
        ca.create_oval(110+50*c,310,140+50*c,340,fill='blue',width=0,tag='kc')
        if p==19 and c==19:
            lar=tk.Label(r,text='Draw!',bg="#40a0c0",fg='red',font=('Times New Roman',100))
            lar.place(x=600,y=400)
            game='e'
        if p==19 and c<19:
            lar=tk.Label(r,text='Win!',bg="#40a0c0",fg='red',font=('Times New Roman',100))
            lar.place(x=600,y=400)
            game='e'
        if p<19 and c==19:
            lar=tk.Label(r,text='Lose!',bg="#40a0c0",fg='red',font=('Times New Roman',100))
            lar.place(x=600,y=400)
            game="e"
ca=tk.Canvas(r,width=1200,height=600,bg="#40a0c0")
for i in range(20):
    ca.create_rectangle(100+50*i,100,150+50*i,150,fill='white',outline='red',width=4)
    ca.create_rectangle(100+50*i,300,150+50*i,350,fill='white',outline='red',width=4)
lap=tk.Label(r,text='Player',bg="#40a0c0",font=('Times New Roman',40))
lap.place(x=100,y=20)
laps=tk.Label(r,text='start',bg="#40a0c0",font=('Times New Roman',30))
laps.place(x=10,y=100)
lapg=tk.Label(r,text='goal',bg="#40a0c0",font=('Times New Roman',30))
lapg.place(x=1110,y=100)
lac=tk.Label(r,text='Computer',bg="#40a0c0",font=('Times New Roman',40))
lac.place(x=100,y=220)
lacs=tk.Label(r,text='start',bg="#40a0c0",font=('Times New Roman',30))
lacs.place(x=10,y=300)
lacg=tk.Label(r,text='goal',bg="#40a0c0",font=('Times New Roman',30))
lacg.place(x=1110,y=300)
bt=tk.Button(r,text=' サイコロを振る ',bg='white',font=('Times New Roman',30),command=go)
bt.place(x=100,y=450)
ca.create_oval(110,110,140,140,fill='blue',width=0,tag='kp')
ca.create_oval(110,310,140,340,fill='blue',width=0,tag='kc')
ca.pack()
r.mainloop()