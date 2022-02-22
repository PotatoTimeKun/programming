/**
 * @file vijuneru_ango.cpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief ヴィジュネル暗号の作成・解読を行います。
 * 必須:vij.hpp
 * 
 */
#include <iostream>
#include <string>
#include "vij.hpp"
using namespace std;
string get(string,string,string);
main(){
    string sa,k,m;
    while(true){
        cout<<"Write mode:make(m) or read(r)\nWrite word \"b\" to finish this."<<endl;
        cin>>m;
        cin.ignore();
        if(m=="b"||m=="\"b\"") break;
        cout<<"sentence:";
        getline(cin,sa);
        cout<<"key:";
        cin>>k;
        cout<<endl<<"->";
        cout<<get(m,sa,k)<<endl;
    }
}
/**
 * @brief 暗号・復号して返します。
 * 
 * @param m "r"で復号、"m"で暗号
 * @param sa 暗号・平文
 * @param k 鍵
 * @return string 変換結果
 */
string get(string m,string sa,string k){
    if(m[0]=='r') return readvij(sa,k);
    if(m[0]=='m') return vij(sa,k);
    return "Selecting mode error.";
}
