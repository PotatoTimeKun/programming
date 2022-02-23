/**
 * @file vij.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief ヴィジュネル暗号を扱う関数vijとreadvijが入っています。
 * 
 */
#ifndef VIJ_HPP_INCLUDED
#define VIJ_HPP_INCLUDED
#include <iostream>
#include <algorithm>
#include <cctype>
#include <string>
using namespace std;
/**
 * @brief 平文をヴィジュネル暗号に変換します。
 * 
 * @param sen 平文
 * @param key 鍵
 * @return string 暗号
 */
string vij(string sen,string key){
    string ang(sen);
    int s=0,k=0,sl=sen.length(),kl=key.length();
    for(int i=0;i<sl;i++)sen[i]=tolower(sen[i]);
    for(int i=0;i<kl;i++)key[i]=tolower(key[i]);
    while(s<sl){
        if(sen[s]>='a' && sen[s]<='z'){
            ang[s]='A'+(sen[s]+key[k]-2*'a')%26;
            s++;
            k++;
        }else{
            ang[s]=sen[s];
            s++;
        }
        if(k>=kl)k=0;
    }
    return ang;
}
/**
 * @brief ヴィジュネル暗号を平文に変換します。
 * 
 * @param ang 暗号
 * @param key 鍵
 * @return string 平文
 */
string readvij(string ang,string key){
    string sen(ang);
    int a=0,k=0,al=ang.length(),kl=key.length();
    for(int i=0;i<al;i++)ang[i]=tolower(ang[i]);
    for(int i=0;i<kl;i++)key[i]=tolower(key[i]);
    while(a<al){
        if(sen[a]>='a' && ang[a]<='z'){
            sen[a]='A'+((ang[a]-'a')-(key[k]-'a'))%26;
            a++;
            k++;
        }else{
            sen[a]=ang[a];
            a++;
        }
        if(k>=kl)k=0;
    }
    return sen;
}
#endif // VIJ_HPP_INCLUDED
