import numpy as np
import matplotlib.pyplot as plt
from random import randint
train=np.loadtxt("data.csv",delimiter=",",skiprows=1)
train_x=train[:,0]
train_y=train[:,1]
train_x=train_x.tolist()
train_y=train_y.tolist()
test_x=[]
test_y=[]
print("最急降下法\nデータはdata.csvより\n次数を入力:")
jisu=int(input())
for i in range(int(len(train_x)*3/10)):
     j=randint(0,len(train_x)-1)
     test_x.append(train_x[j])
     test_y.append(train_y[j])
     del train_x[j]
     del train_y[j]
train_x=np.array(train_x)
train_y=np.array(train_y)
test_x=np.array(test_x)
test_y=np.array(test_y)
mu=train_x.mean()
sigma=train_x.std()
standardize=lambda x:(x-mu)/sigma
train_z=standardize(train_x)
t=np.array([1]*(jisu+1))
f=lambda x:np.dot(np.array([x**i for i in range(jisu+1)]).T,t)
E=lambda:0.5*np.sum((train_y-f(train_z))**2)
diff=1
error=E()
print("学習率を入力:")
ETA=float(input())
print("青:学習用データ,オレンジ:テスト用データ,緑:得られた関数")
while diff>0.0001:
    t=t-ETA*np.dot(f(train_z)-train_y,np.array([train_z**i for i in range(jisu+1)]).T)
    currentError=E()
    diff=error-currentError
    error=currentError
x=np.linspace(3,-3,100)
plt.plot(train_z,train_y,'o')
plt.plot(standardize(test_x),test_y,'o')
plt.plot(x,f(x))
MSE=lambda x,y: np.sum((y-f(x))**2)/x.shape[0]
print(f"パラメータΘ={t.tolist()}")
print(f"平均2乗誤差(MSE)={round(MSE(standardize(test_x),test_y),2)}")
print(f"2乗平均平方根誤差(RMSE)={round(MSE(standardize(test_x),test_y)**0.5,2)}")
MAE=lambda x,y:np.sum(np.abs(y-f(x)))/x.shape[0]
MAPE=lambda x,y:np.sum(np.abs((f(x)-y)/y))*100/x.shape[0]
print(f"平均絶対値誤差(MAE)={round(MAE(standardize(test_x),test_y),2)}")
print(f"平均絶対値誤差率(MAPE)={round(MAPE(standardize(test_x),test_y),2)}%")
plt.show()