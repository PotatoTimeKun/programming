#ifndef SOINSUBUNKAI_HPP_INCLUDED
#define SOINSUBUNKAI_HPP_INCLUDED
#include <iostream>
using namespace std;
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
