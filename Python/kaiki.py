import numpy as np
import matplotlib.pyplot as plt
from random import randint
train=np.loadtxt("data.csv",delimiter=",",skiprows=1)  # データの読み込み
train_x=train[:,0]  # xを取り出す
train_y=train[:,1]  # y 〃
train_x=train_x.tolist()
train_y=train_y.tolist()
test_x=[] # テストデータ用
test_y=[] # 〃
for i in range(int(len(train_x)*3/10)): # データの3割をテスト用データとする
     j=randint(0,len(train_x)-1) # ランダムなインデックス
     test_x.append(train_x[j])
     test_y.append(train_y[j])
     del train_x[j]
     del train_y[j]
train_x=np.array(train_x)
train_y=np.array(train_y)
test_x=np.array(test_x)
test_y=np.array(test_y)
mu=train_x.mean() # 平均
sigma=train_x.std() # 標準偏差
standardize=lambda x:(x-mu)/sigma # z-score正規化を行う関数
train_z=standardize(train_x) # z-score正規化を通したx
print("最急降下法\nデータはdata.csvより(z-score正規化を通す)\n次数を入力:")
jisu=int(input()) # 次数を受け取る
t=np.array([1]*(jisu+1)) # Θ
t2=np.array([1]*(jisu+1)) # Θ(正則化なし用)
f=lambda x:np.dot(np.array([x**i for i in range(jisu+1)]).T,t) # 曲線f(x)
f2=lambda x:np.dot(np.array([x**i for i in range(jisu+1)]).T,t2)
E=lambda:0.5*np.sum((train_y-f(train_z))**2) # 誤差E(Θ)
diff=1 # 前回の更新との誤差の差
error=E() # 誤差
print("学習率を入力:")
ETA=float(input()) # 学習率μ
print("正則化の定数を入力")
LAMBDA=float(input()) # 正則化の定数λ
print("青:学習用データ,オレンジ:テスト用データ,緑:得られた関数,赤:正則化なしで得られた関数")
while diff>0.000001: # パラメータΘの更新
    t=t-ETA*(np.dot(f(train_z)-train_y,np.array([train_z**i for i in range(jisu+1)]).T)+LAMBDA*np.hstack([0,t[1:]]))
    t2=t2-ETA*(np.dot(f(train_z)-train_y,np.array([train_z**i for i in range(jisu+1)]).T))
    currentError=E()
    diff=error-currentError
    error=currentError
x=np.linspace(3,-3,100)
plt.plot(train_z,train_y,'o') # 学習データのプロット
plt.plot(standardize(test_x),test_y,'o') # テスト用データのプロット
plt.plot(x,f(x)) # 正則化ありの曲線
plt.plot(x,f2(x)) # 正則化なしの曲線
print("\n正則化あり")
MSE=lambda x,y: np.sum((y-f(x))**2)/x.shape[0] # MSEを計算する関数
print(f"パラメータΘ={t.tolist()}")
print(f"平均2乗誤差(MSE)={round(MSE(standardize(test_x),test_y),2)}")
print(f"2乗平均平方根誤差(RMSE)={round(MSE(standardize(test_x),test_y)**0.5,2)}") # RMSEはMSEを0.5乗(平方根)
MAE=lambda x,y:np.sum(np.abs(y-f(x)))/x.shape[0] # MAEを計算する関数
MAPE=lambda x,y:np.sum(np.abs((f(x)-y)/y))*100/x.shape[0]# MAPEを計算する関数
print(f"平均絶対値誤差(MAE)={round(MAE(standardize(test_x),test_y),2)}")
print(f"平均絶対値誤差率(MAPE)={round(MAPE(standardize(test_x),test_y),2)}%")
print("\n正則化なし")
MSE2=lambda x,y: np.sum((y-f2(x))**2)/x.shape[0]
print(f"パラメータΘ={t2.tolist()}")
print(f"平均2乗誤差(MSE)={round(MSE2(standardize(test_x),test_y),2)}")
print(f"2乗平均平方根誤差(RMSE)={round(MSE2(standardize(test_x),test_y)**0.5,2)}")
MAE2=lambda x,y:np.sum(np.abs(y-f2(x)))/x.shape[0]
MAPE2=lambda x,y:np.sum(np.abs((f2(x)-y)/y))*100/x.shape[0]
print(f"平均絶対値誤差(MAE)={round(MAE2(standardize(test_x),test_y),2)}")
print(f"平均絶対値誤差率(MAPE)={round(MAPE2(standardize(test_x),test_y),2)}%")
plt.show()
while(True): # 入力からyを予測
    print("値を入力(x)")
    x_inp=float(input())
    print(f"y={f(standardize(x_inp))}")