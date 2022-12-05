import numpy as np
import matplotlib.pyplot as plt
from random import randint
train=np.loadtxt("data.csv",delimiter=",",skiprows=1)  # データの読み込み
train_x,train_y=train[:,0],train[:,1]  # x,yを取り出す
test_x,test_y=np.array([]),np.array([]) # テストデータ用
for i in range(int(len(train_x)*3/10)): # データの3割をテスト用データとする
    j=randint(0,train_x.shape[0]-1) # ランダムなインデックス
    test_x=np.append(test_x,train_x[j])
    test_y=np.append(test_y,train_y[j])
    train_x=np.delete(train_x,j)
    train_y=np.delete(train_y,j)
mu=train_x.mean() # 平均
sigma=train_x.std() # 標準偏差
standardize=lambda x:(x-mu)/sigma # z-score正規化を行う関数
train_z=standardize(train_x) # z-score正規化を通したx
print("最急降下法\nデータはdata.csvより(z-score正規化を通す)\n次数を入力:")
jisu=int(input()) # 次数を受け取る
t=[np.array([1]*(jisu+1)),np.array([1]*(jisu+1))] # Θ(正則化あり/なし)
f=lambda x,theta:np.dot(np.array([x**i for i in range(jisu+1)]).T,theta) # 曲線f(x)
E=lambda theta:0.5*np.sum((train_y-f(train_z,theta))**2) # 誤差E(Θ)
diff=1 # 前回の更新との誤差の差
error=E(t[0]) # 誤差
print("学習率を入力:")
ETA=float(input()) # 学習率μ
print("正則化の定数を入力")
LAMBDA=float(input()) # 正則化の定数λ
print("青:学習用データ,水:テスト用データ,赤:得られた関数,緑:正則化なしで得られた関数")
while diff>0.0001: # パラメータΘの更新
    t_f=[t[0],t[1]]
    for i in range(2):
        t[i]=t[i]-ETA*(np.dot(f(train_z,t[i])-train_y,np.array([train_z**i for i in range(jisu+1)]).T)+i*LAMBDA*np.hstack([0,t[i][1:]]))
    diff=max(E(t_f[0])-E(t[0]),E(t_f[1])-E(t[1]))
x=np.linspace(3,-3,100)
plt.plot(train_z,train_y,'o',color="b") # 学習データのプロット
plt.plot(standardize(test_x),test_y,'o',color="c") # テスト用データのプロット
plt.plot(x,f(x,t[0]),color="g") # 正則化なしの曲線
plt.plot(x,f(x,t[1]),color="r") # 正則化ありの曲線
MSE=lambda x,y,theta: np.sum((y-f(x,theta))**2)/x.shape[0] # MSEを計算する関数
MAE=lambda x,y,theta:np.sum(np.abs(y-f(x,theta)))/x.shape[0] # MAEを計算する関数
MAPE=lambda x,y,theta:np.sum(np.abs((f(x,theta)-y)/y))*100/x.shape[0]# MAPEを計算する関数
for i in range(2):
    print("\n正則化"+["なし","あり"][i])
    print(f"パラメータΘ={t[i].round(3).tolist()}")
    print(f"平均2乗誤差(MSE)={round(MSE(standardize(test_x),test_y,t[i]),2)}")
    print(f"2乗平均平方根誤差(RMSE)={round(MSE(standardize(test_x),test_y[1],t[i])**0.5,2)}") # RMSEはMSEを0.5乗(平方根)
    print(f"平均絶対値誤差(MAE)={round(MAE(standardize(test_x),test_y,t[i]),2)}")
    print(f"平均絶対値誤差率(MAPE)={round(MAPE(standardize(test_x),test_y,t[i]),2)}%")
plt.show()
while(True): # 入力からyを予測
    print("値を入力(x)")
    x_inp=float(input())
    print(f"y={f(standardize(x_inp),t[1])}")