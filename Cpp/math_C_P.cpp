/**
 * @file math_C_P.cpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 数学の順列・組み合わせの計算を行います。
 * 
 */
#include <iostream>
#include <string>
using namespace std;
/**
 * @brief 階乗を返します。
 * 
 * @param n 値
 * @return long long 演算結果
 */
long long kaij(int n){
    long long ret=1;
    if(n>0){
        ret=n*kaij(n-1);
    }
    return ret;
}
/**
 * @brief n個からr個選んだ順列の総数を返します。
 * 
 * @param n nPrのn
 * @param r nPrのr
 * @return long long 演算結果
 */
long long per(int n,int r){
    long long ret=1;
    for(int i=n;i>n-r;i--){
        ret*=i;
    }
    return ret;
}
/**
 * @brief n個からr個選んだ組み合わせの総数を返します。
 * 
 * @param n nCrのn
 * @param r nCrのr
 * @return long long 演算結果
 */
long long com(int n,int r){
    long long ret=1;
    if(n==r){return 1;}
    if(r>n/2){r=n-r;}
    ret=per(n,r)/kaij(r);
    return ret;
}
int main() {
    int a,b;
    string inp;
    cout<<"nCrかnPrを、n,rを整数値にして渡してください。\nまた、n,C||P,rは1つずつ入力してください。";
    cin>>a;
    cin>>inp;
    cin>>b;
    if(inp=="C"||inp=="c")cout<<com(a,b);
    if(inp=="P"||inp=="p")cout<<per(a,b);
    return 0;
}