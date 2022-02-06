#include <iostream>
#include <string>
using namespace std;
long long kaij(int n){
    long long ret=1;
    if(n>0){
        ret=n*kaij(n-1);
    }
    return ret;
}
long long per(int n,int r){
    long long ret=1;
    for(int i=n;i>n-r;i--){
        ret*=i;
    }
    return ret;
}
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