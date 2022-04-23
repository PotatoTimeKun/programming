/**
 * @file rnd.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 乱数を作成する関数をアルゴリズム別で用意しています。
 * 
 */
#ifndef INCLUDE_RND
#define INCLUDE_RND
/**
 * @brief 合同法乱数を計算します。
 * 漸化式は
 * x[0]=b ,
 * x[k+1]=(x[k]*a)%m
 * となります。
 * 
 * @param a 漸化式より
 * @param b 漸化式より
 * @param m 漸化式より
 * @param n n個計算する
 * @param return_array 計算結果を格納する配列
 */
void LCGs(int a,int b,int m,int n,int *return_array){
    return_array[0]=b;
    for(int i=0;i<n-2;i++)return_array[i+1]=(a*return_array[i])%m;
}
/**
 * @brief B.B.S.で疑似乱数を生成します。
 * 漸化式は
 * x[0]=a ,
 * x[n+1]=(x[n]^2)%(pq)
 * 
 * @param p 漸化式より
 * @param q 漸化式より
 * @param a 漸化式より
 * @param n n個計算する
 * @param return_array 計算結果を格納する配列
 */
void BBS(int p,int q,int a,int n,int *return_array){
    return_array[0]=a;
    for(int i=0;i<n-2;i++)return_array[i+1]=(return_array[i]*return_array[i])%(p*q);
}
#endif