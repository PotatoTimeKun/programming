/**
 * @file sort.hpp
 * @brief 整列を行う関数が入っています。
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * 
 * @details 関数一覧
 * void bubble(int array[],int array_size)
 * void select(int array[],int array_size)
 * void insert(int array[],int array_size)
 * void shell(int array[],int array_size)
 * void quick(int array[],int array_size)
 * void heap(int array[],int array_size)
 * void marge(int array[],int array_size)
 * 
 */
#ifndef SORT
#define SORT
#include <algorithm>
#include <iostream>
using namespace std;
/**
 * @brief バブルソート(基本交換法)で昇順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void bubble(int array[],int array_size){
    int sw;
    for(int i=array_size-1;i>1;i--){
        for(int j=0;j<i;j++){
            if(array[j]>array[j+1]){
                sw=array[j];
                array[j]=array[j+1];
                array[j+1]=sw;
            }
        }
    }
}
/**
 * @brief バブルソート(基本交換法)で降順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void bubble_down(int array[],int array_size){
    int sw;
    for(int i=array_size-1;i>1;i--){
        for(int j=0;j<i;j++){
            if(array[j]<array[j+1]){
                sw=array[j];
                array[j]=array[j+1];
                array[j+1]=sw;
            }
        }
    }
}
/**
 * @brief 基本選択法で昇順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
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
/**
 * @brief 基本選択法で降順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void select_down(int array[],int array_size){
    int sw,min;
    for(int i=0;i<array_size-1;i++){
        min=i;
        for(int j=i+1;j<array_size;j++){if(array[min]<array[j])min=j;}
        sw=array[i];
        array[i]=array[min];
        array[min]=sw;
    }
}
/**
 * @brief 基本挿入法で昇順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
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
/**
 * @brief 基本挿入法で降順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void insert_down(int array[],int array_size){
    int sw;
    for(int i=2;i<array_size;i++){
        for(int j=i;j>0;j--){
            if(array[j-1]>array[j])break;
            else{
                sw=array[j];
                array[j]=array[j-1];
                array[j-1]=sw;
            }
        }
    }
}
/**
 * @brief シェルソート(改良挿入法)で昇順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void shell(int array[],int array_size){
    int sw;
    for(int c=3;c>0;c--){
        for(int i=2;i<array_size;i+=c){
            for(int p=0;p<c;p++){
                if(i+p>=array_size)break;
                for(int j=i+p;j-c>=0;j-=c){
                    if(array[j-c]<array[j])break;
                    else{
                        sw=array[j];
                        array[j]=array[j-c];
                        array[j-c]=sw;
                    }
                }
            }
        }
    }
}
/**
 * @brief シェルソート(改良挿入法)で降順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void shell_down(int array[],int array_size){
    int sw;
    for(int c=3;c>0;c--){
        for(int i=2;i<array_size;i+=c){
            for(int p=0;p<c;p++){
                if(i+p>=array_size)break;
                for(int j=i+p;j-c>=0;j-=c){
                    if(array[j-c]>array[j])break;
                    else{
                        sw=array[j];
                        array[j]=array[j-c];
                        array[j-c]=sw;
                    }
                }
            }
        }
    }
}
/**
 * @brief クイックソートで昇順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
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
/**
 * @brief クイックソートで降順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void quick_down(int array[],int array_size){
    struct func{
        int *array,array_size;
        void sort(int st,int en){
            int sw,pi,pip;
            if(st<en){
                pip=st;
                pi=array[(st+en)/2];
                array[(st+en)/2]=array[st];
                for(int i=st+1;i<=en;i++){
                    if(array[i]>pi){
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

/**
 * @brief 最小値を根とするヒープを作成します。
 * 
 * @param array 目的の配列
 * @param array_size arrayの要素数
 */
void toHeap(int array[],int array_size){
    int howDeep=0;
    for(int volume=array_size;volume>0;volume>>=1)howDeep++;
    for(int i=howDeep-1;i>0;i--){
        int maxIndex=(1<<(i+1))-2;
        if(maxIndex>array_size-1)maxIndex=array_size-1;
        for(int j=0;j<(1<<i)-1;j++){
            if(2*j+1<=maxIndex){
                if(array[2*j+1]<array[j]){
                    int swap=array[2*j+1];
                    array[2*j+1]=array[j];
                    array[j]=swap;
                }
            }else break;
            if(2*j+2<=maxIndex){
                if(array[2*j+2]<array[j]){
                    int swap=array[2*j+2];
                    array[2*j+2]=array[j];
                    array[j]=swap;
                }
            }else break;
        }
    }
}/**
 * @brief 最大値を根とするヒープを作成します。
 * 
 * @param array 目的の配列
 * @param array_size arrayの要素数
 */
void toHeap_down(int array[],int array_size){
    int howDeep=0;
    for(int volume=array_size;volume>0;volume>>=1)howDeep++;
    for(int i=howDeep-1;i>0;i--){
        int maxIndex=(1<<(i+1))-2;
        if(maxIndex>array_size-1)maxIndex=array_size-1;
        for(int j=0;j<(1<<i)-1;j++){
            if(2*j+1<=maxIndex){
                if(array[2*j+1]>array[j]){
                    int swap=array[2*j+1];
                    array[2*j+1]=array[j];
                    array[j]=swap;
                }
            }else break;
            if(2*j+2<=maxIndex){
                if(array[2*j+2]>array[j]){
                    int swap=array[2*j+2];
                    array[2*j+2]=array[j];
                    array[j]=swap;
                }
            }else break;
        }
    }
}

/**
 * @brief ヒープソートで昇順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void heap(int array[],int array_size){
    for(int i=0;i<array_size-1;i++){
        toHeap(array,array_size-i);
        array++;
    }
}
/**
 * @brief ヒープソートで降順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void heap_down(int array[],int array_size){
    for(int i=0;i<array_size-1;i++){
        toHeap_down(array,array_size-i);
        array++;
    }
}

/**
 * @brief マージソートで昇順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void marge(int array[],int array_size){
    struct func{
        int *array,array_size;
        void marge(int st,int mid,int en){
            int sn=mid-st,enn=en-mid;
            int* S=new int[sn+1];
            int* E=new int[enn+1];
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
/**
 * @brief マージソートで降順に整列を行います。
 * 
 * @param array 整列を行う配列
 * @param array_size arrayの要素数
 */
void marge_down(int array[],int array_size){
    struct func{
        int *array,array_size;
        void marge(int st,int mid,int en){
            int sn=mid-st,enn=en-mid;
            int* S=new int[sn+1];
            int* E=new int[enn+1];
            copy(&array[st],&array[mid+1],S);
            copy(&array[mid],&array[en+1],E);
            S[sn]=-INT_MAX;
            E[enn]=-INT_MAX;
            int i=0,j=0;
            for(int k=st;k<en;k++){
                if(S[i]>=E[j]){
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