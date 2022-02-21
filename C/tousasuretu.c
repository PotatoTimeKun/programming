/**
 * @file tousasuretu.c
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 標準入出力で等差数列を扱います。
 * 
 */
#include <stdio.h>
int sum_tousa(int a1,int d,int n){
    return n*(2*a1+(n-1)*d)/2;
}
int tousa_kou(int a1,int d,int n){
    return a1+(n-1)*d;
}
int main(){
    int a1,d,n;
    char bunki;
    while(1){
        printf("a1(初項)=");
        scanf(" %d",&a1);
        printf("d(公差)=");
        scanf(" %d",&d);
        printf("総和を求める:s\n第n項を求める:n\n");
        scanf(" %c",&bunki);
        if(bunki=='s'){
            printf("n(項数)=");
            scanf(" %d",&n);
            printf("%d\n\n",sum_tousa(a1,d,n));
        }
        if(bunki=='n'){
            printf("n(項数)=");
            scanf(" %d",&n);
            printf("%d\n\n",tousa_kou(a1,d,n));
        }
    }
}