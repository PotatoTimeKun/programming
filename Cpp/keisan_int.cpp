#include <iostream>
#include <string>
#include <regex>
#include "newint.h"
using namespace std;
string kei(string);
main(){
    string inp;
    cin>>inp;
    inp=kei(inp);
    newint cou(inp);
    cout<<"="<<cou.str()<<endl<<endl;
    main();
}
string kei(string si){
    bool fin=false;
    regex kam("\\((-?+?\\d+)\\)");
    while(fin==false){
        smatch km;
        if(regex_search(si,km,kam)){
            si=si.substr(0,km.position())+km[1].str()+si.substr(km.position()+km[0].length());
        }else{fin=true;}
    }
    fin=false;
    regex kak("\\((-?\\d+[-\\+\\*/]-?\\d+[^\\(\\)]*?)\\)");
    while(fin==false){
        smatch ka;
        if(regex_search(si,ka,kak)){
            si=si.substr(0,ka.position())+kei(ka[1].str())+si.substr(ka.position()+ka[0].length());
        }else{fin=true;}
    }
    regex k1("\\[?(-?\\d+)\\]?([\\*/])\\[?(-?\\d+)\\]?");
    smatch kr1;
    newint res("0");
    fin=false;
    while(fin==false){
        if(regex_search(si,kr1,k1)){
            if(kr1[2]=="*"){
                newint ks1(kr1[1].str());
                newint ks2(kr1[3].str());
                res=ks1*ks2;
                si=si.substr(0,kr1.position())+res.str()+si.substr(kr1.position()+kr1[0].length());
            }
            if(kr1[2]=="/"){
                newint ks1(kr1[1].str());
                newint ks2(kr1[3].str());
                res=ks1/ks2;
                si=si.substr(0,kr1.position())+res.str()+si.substr(kr1.position()+kr1[0].length());
            }
        }else{fin=true;}
    }
    regex k2("\\[?(-?\\d+)\\]?([\\+-])\\[?(-?\\d+)\\]?");
    smatch kr2;
    fin=false;
    while(fin==false){
        if(regex_search(si,kr2,k2)){
            if(kr2[2]=="+"){
                newint ks1(kr2[1].str());
                newint ks2(kr2[3].str());
                res=ks1+ks2;
                si=si.substr(0,kr2.position())+res.str()+si.substr(kr2.position()+kr2[0].length());
            }
            if(kr2[2]=="-"){
                newint ks1(kr2[1].str());
                newint ks2(kr2[3].str());
                res=ks1-ks2;
                si=si.substr(0,kr2.position())+res.str()+si.substr(kr2.position()+kr2[0].length());
            }
        }else{fin=true;}
    }
    return si;
}