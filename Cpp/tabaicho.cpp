#include "newint.hpp"
#include <iostream>
#include <string>
int main(){
    string a_s,b_s;
    cout<<"a=";
    cin>>a_s;
    cout<<"b=";
    cin>>b_s;
    newint a(a_s);
    newint b(b_s);
    newint c=a+b;
    cout<<"a+b="+c.str()<<endl;
    c=a-b;
    cout<<"a-b="+c.str()<<endl;
    c=a*b;
    cout<<"a*b="+c.str()<<endl;
    c=a/b;
    cout<<"a/b="+c.str()<<endl;
    c=a%b;
    cout<<"a%b="+c.str()<<endl;
    cout<<"a>b="+to_string(a>b)<<endl;
}