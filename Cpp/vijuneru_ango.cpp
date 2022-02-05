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
string get(string m,string sa,string k){
    if(m[0]=='r') return readvij(sa,k);
    if(m[0]=='m') return vij(sa,k);
    return "Selecting mode error.";
}
