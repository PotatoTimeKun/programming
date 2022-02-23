/**
 * @file soinsubunkai.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 素因数分解を行うprime_fact関数が入っています。
 * 
 */
#ifndef SOINSUBUNKAI_HPP_INCLUDED
#define SOINSUBUNKAI_HPP_INCLUDED
#include <iostream>
using namespace std;
/**
 * @brief valueの値を素因数分解してreturn_arrayに代入します(重複あり・昇順)
 * 先頭から素因数を代入し、使用されてない要素は-1で埋められます。
 * 代入する素因数は最大100個までで、インデックス100(101個目)の要素は必ず-1となります。
 * 
 * @param value 素因数分解を行う値
 * @param return_array 要素数101のint型配列
 */
void prime_fact(int value,int *return_array){
    int check[2],index=0;
    for(int i=0;i<101;i++)return_array[i]=-1;
    if(value<2)return;
    bool doing=true;
    while(doing){
        doing=false;
        int n=2;
        while(!doing && n<value){
            check[0]=value/n;
            check[1]=value%n;
            if(check[1]==0){
                value=check[0];
                if(index<100)return_array[index]=n;
                index++;
                doing=true;
            }
            n++;
        }
    }
    return_array[index]=value;
    return;
}

#endif // SOINSUBUNKAI_HPP_INCLUDED
