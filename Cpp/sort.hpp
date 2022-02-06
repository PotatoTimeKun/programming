#ifndef SORT
#define SORT
#include <vector>
#include <algorithm>
#include <iostream>
using namespace std;
void bubble(int array[],int array_size){
    int sw;
    for(int i=array_size;i>1;i--){
        for(int j=0;j<i;j++){
            if(array[j]>array[j+1]){
                sw=array[j];
                array[j]=array[j+1];
                array[j+1]=sw;
            }
        }
    }
}
void select(int array[],int array_size){
    int sw,min;
    for(int i=0;i<array_size-1;i++){
        min=i;
        for(int j=i+1;j<array_size;j++){if(array[min]>array[j])min=j;}
        sw=array[i];
        array[i]=array[min];
        array[min]=sw;
    }
}
void insert(int array[],int array_size){
    int sw;
    for(int i=2;i<array_size;i++){
        for(int j=i;j>0;j--){
            if(array[j-1]<array[j])break;
            else{
                sw=array[j];
                array[j]=array[j-1];
                array[j-1]=sw;
            }
        }
    }
}
void shell(int array[],int array_size){
    int sw;
    for(int c=3;c>0;c--){
        for(int i=2;i<array_size;i+=c){
            for(int p=0;p<c;p++){
                for(int j=i;j>0;j-=c+p){
                    if(array[j-c]<array[j])break;
                    else{
                        sw=array[j];
                        array[j]=array[j-1];
                        array[j-1]=sw;
                    }
                }
            }
        }
    }
}
void quick(int array[],int array_size){
    struct func{
        int *array,array_size;
        void sort(int st,int en){
            int sw,pi,pip;
            if(st<en){
                pip=st;
                pi=array[(st+en)/2];
                array[(st+en)/2]=array[st];
                for(int i=st+1;i<=en;i++){
                    if(array[i]<pi){
                        pip++;
                        sw=array[pip];
                        array[pip]=array[i];
                        array[i]=sw;
                    }
                }
            array[st]=array[pip];
            array[pip]=pi;
            sort(st,pip-1);
            sort(pip+1,en);
            }
        }
    };
    struct func a;
    a.array=array;
    a.array_size=array_size;
    a.sort(0,a.array_size-1);
}
void heap(int array[],int array_size){
    vector<int> v(&array[0],&array[array_size]);
    make_heap(v.begin(),v.end());
    sort_heap(v.begin(),v.end());
    copy(v.begin(),v.end(),array);
}
void marge(int array[],int array_size){
    struct func{
        int *array,array_size;
        void marge(int st,int mid,int en){
            int sn=mid-st,enn=en-mid;
            int S[sn+1],E[enn+1];
            copy(&array[st],&array[mid+1],S);
            copy(&array[mid],&array[en+1],E);
            S[sn]=INT_MAX;
            E[enn]=INT_MAX;
            int i=0,j=0;
            for(int k=st;k<en;k++){
                if(S[i]<=E[j]){
                    array[k]=S[i];
                    i++;
                }else{
                    array[k]=E[j];
                    j++;
                }
            }
        }
        void sort(int st,int en){
            if(st+1<en){
                int mid=(st+en)/2;
                sort(st,mid);
                sort(mid,en);
                marge(st,mid,en);
            }
        }
    };
    struct func a;
    a.array=array;
    a.array_size=array_size;
    a.sort(0,array_size);
}
#endif