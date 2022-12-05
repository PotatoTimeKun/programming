import numpy as np
import matplotlib.pyplot as plt
from random import randint
data=np.loadtxt("bunruiData.csv",delimiter=",",skiprows=1)  # データの読み込み
x1,x2,y=data[:,0],data[:,1],data[:,2]  # x1,x2,yを取り出す
x1_0,x2_0,x1_1,x2_1=np.array([]),np.array([]),np.array([]),np.array([])
for i in range(x1.shape[0]): #ラベルごとにx1,x2を取り出す
    if y[i]==0:
        x1_0=np.append(x1_0,x1[i])
        x2_0=np.append(x2_0,x2[i])
    else:
        x1_1=np.append(x1_1,x1[i])
        x2_1=np.append(x2_1,x2[i])
test_x1,test_x2,test_y=np.array([]),np.array([]),np.array([]) # テストデータ用
for i in range(int(x1.shape[0]*3/10)): # データの3割をテスト用データとする
    j=randint(0,x1.shape[0]-1) # ランダムなインデックス
    test_x1=np.append(test_x1,x1[j])
    test_x2=np.append(test_x2,x2[j])
    test_y=np.append(test_y,y[j])
    x1=np.delete(x1,j)
    x2=np.delete(x2,j)
    y=np.delete(y,j)
# x1のz-score正規化
mu=x1.mean() # 平均
sigma=x1.std() # 標準偏差
standardize=lambda x:(x-mu)/sigma # z-score正規化を行う関数
x1=standardize(x1)
# x2のz-score正規化
mu2=x2.mean()
sigma2=x2.std()
standardize2=lambda x:(x-mu2)/sigma2
x2=standardize2(x2)
plt.plot(standardize(x1_0),standardize2(x2_0),'o',color="b") # ラベルで色を分けてx1,x2を表示
plt.plot(standardize(x1_1),standardize2(x2_1),'o',color="r")
print("ロジスティクス回帰\nデータはbunruiData.csvより(z-score正規化を通す)\nx1の次数を入力:")
degree=int(input()) # 次数を受け取る
x=np.array([list(x1**i) for i in range(degree+1)]+[list(x2)])
 # x、x0=x1^0=1,x1,x1^2,...,x1^degree,x2
t=np.array([1]*(degree+2)) # Θ、最後の要素はx2にかかるパラメータ
sgm=lambda x,theta:1/(np.exp(-np.dot(theta,x))+1) # シグモイド関数
print("学習率を入力:")
ETA=float(input()) # 学習率η
for i in range(10000):
    t=t+ETA*np.dot(y-sgm(x,t),x.T)
graphx1=np.linspace(3,-3,100)
graphx2=-np.dot(np.array([graphx1**i for i in range(degree+1)]).T,t[:degree+1])/t[-1]
 # x2=-(θ0*x1^0+...+θdegree*x_x1^degree)/θ(degree+1)
plt.plot(graphx1,graphx2,color="g") # 決定境界の表示
# 評価
TP,TN,FP,FN=0,0,0,0
x1=np.append(x1,standardize(test_x1))
x2=np.append(x2,standardize2(test_x2))
y=np.append(y,test_y)
x=np.array([list(x1**i) for i in range(degree+1)]+[list(x2)])
answer=sgm(x,t) # 得られた関数によるデータの分類の結果
for i in range(x1.shape[0]): # TP,TN,FP,FNを数える
    if y[i]==1:
        if answer[i]>=0.5:
            TP+=1
        else:
            FP+=1
    else:
        if answer[i]<0.5:
            TN+=1
        else:
            FN+=1
print(f"TP:{TP},TN:{TN},FP:{FP},FN:{FN}")
print(f"Accuracy={(TP+TN)/(TP+TN+FP+FN)}")
Precision=TP/(TP+FP)
print(f"Precision={Precision}")
Recall=TP/(TP+FN)
print(f"Recall={Recall}")
print(f"Fmeasure={2*Precision*Recall/(Precision+Recall)}")
plt.show()