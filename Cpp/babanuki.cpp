/**
 * @file babanuki.cpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief CUI�Ńo�o�������ł��܂��B
 * 
 */
#include <iostream>
#include <random>
#include <ctime>
#include <string>
#include <windows.h>
using namespace std;
/**
 * @brief ��D�̐���
 * 
 * @param a ��D�̔z��
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
 * @brief ��D���S�ĂȂ��Ȃ������ǂ����̔��f
 * 
 * @param a ��D�̔z��
 * @return true ��D�Ȃ�
 * @return false ��D����
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
        cout<<"\nCPU�̓g�����v��"+to_string(cou)+"�������Ă���"<<endl;
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
        cout<<"\n���Ȃ��̓g�����v��"+to_string(cou)+"�������Ă���\n\n�����ڂ̃g�����v�������܂���"<<endl;
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
                if(get==0)cout<<endl<<"joker��������"<<endl;
                else cout<<endl<<get<<"��������"<<endl;
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
                if(get==0)cout<<"CPU��joker��������\n"<<endl;
                else cout<<"CPU��"<<get<<"��������\n"<<endl;
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
