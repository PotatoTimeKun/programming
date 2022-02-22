/**
 * @file babanuki.cpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief CUIでババ抜きができます。
 * 
 */
#include <iostream>
#include <random>
#include <ctime>
#include <string>
#include <windows.h>
using namespace std;
/**
 * @brief 手札の整理
 * 
 * @param a 手札の配列
 */
void drop(int *a){
    for(int i=0;i<11;i++){
        for(int j=i+1;j<12;j++){
            if(a[i]==a[j]){
                a[i]=-1;
                a[j]=-1;
            }
        }
    }
}
/**
 * @brief 手札が全てなくなったかどうかの判断
 * 
 * @param a 手札の配列
 * @return true 手札なし
 * @return false 手札あり
 */
bool win(int *a){
    bool res=true;
    for(int i=0;i<12;i++){
        if(a[i]>=0)res=false;
    }
    return res;
}
int main(){
    int cpu[12],pla[12];
    srand(time(nullptr));
    for(int i=0;i<10;i++){
        cpu[i]=i+1;
        pla[i]=i+1;
    }
    for(int i=10;i<12;i++){
        cpu[i]=-1;
        pla[i]=-1;
    }
    rand()%2==0?cpu[10]=0:pla[10]=0;
    int sw,a,b,c=rand()%10+15;
    for(int i=0;i<c;i++){
        a=rand()%12;
        b=rand()%12;
        sw=cpu[a];
        cpu[a]=pla[b];
        pla[b]=sw;
    }
    drop(cpu);
    drop(pla);
    while(!win(cpu)&&!win(pla)){
        int cou=0,cp=0,pp=0,dr=0,get;
        for(int i=0;i<12;i++){
            if(cpu[i]!=-1){
                cout<<"[]";
                cou++;
            }
        }
        cout<<"\nCPUはトランプを"+to_string(cou)+"枚持っている"<<endl;
        cp=cou;
        cou=0;
        for(int i=0;i<12;i++){
            if(pla[i]!=-1){
                cout<<"[";
                if(pla[i]==0)cout<<"joker";
                else cout<<pla[i];
                cout<<"]";
                cou++;
            }
        }
        cout<<"\nあなたはトランプを"+to_string(cou)+"枚持っている\n\n何枚目のトランプを引きますか"<<endl;
        while(dr>cp||dr<=0)cin>>dr;
        cou=0;
        for(int i=0;i<12;i++){
            if(cpu[i]>=0){
                cou++;
                if(cou==dr){
                    get=cpu[i];
                    cpu[i]=-1;
                }
            }
        }
        for(int i=0;i<12;i++){
            if(pla[i]==-1){
                pla[i]=get;
                if(get==0)cout<<endl<<"jokerを引いた"<<endl;
                else cout<<endl<<get<<"を引いた"<<endl;
                break;
            }
        }
        drop(pla);
        drop(cpu);
        if(win(pla))break;
        if(win(cpu))break;
        for(int i=0;i<12;i++){
            if(pla[i]!=-1)pp++;
        }
        dr=rand()%pp;
        dr++;
        cou=0;
        for(int i=0;i<12;i++){
            if(pla[i]>=0){
                cou++;
                if(cou==dr){
                    get=pla[i];
                    pla[i]=-1;
                }
            }
        }
        for(int i=0;i<12;i++){
            if(cpu[i]==-1){
                cpu[i]=get;
                if(get==0)cout<<"CPUはjokerを引いた\n"<<endl;
                else cout<<"CPUは"<<get<<"を引いた\n"<<endl;
                break;
            }
        }
        drop(pla);
        drop(cpu);
    }
    if(win(pla)&&!win(cpu))cout<<"win!";
    if(win(pla)&&win(cpu))cout<<"draw";
    if(!win(pla)&&win(cpu))cout<<"lose...";
}
