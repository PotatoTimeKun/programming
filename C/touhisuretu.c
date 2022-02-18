#include <stdio.h>
#include <math.h>
int sum_touhi(int a1,int r,int n){
    if(r==1)return a1*n;
    return a1*(1-pow(r,n))/(1-r);
}
int touhi_kou(int a1,int r,int n){
    return a1*pow(r,n-1);
}
int main(){
    int a1,d,n;
    char bunki;
    while(1){
        printf("a1(初項)=");
        scanf(" %d",&a1);
        printf("r(公比)=");
        scanf(" %d",&d);
        printf("総和を求める:s\n第n項を求める:n\n");
        scanf(" %c",&bunki);
        if(bunki=='s'){
            printf("n(項数)=");
            scanf(" %d",&n);
            printf("%d\n\n",sum_touhi(a1,d,n));
        }
        if(bunki=='n'){
            printf("n(項数)=");
            scanf(" %d",&n);
            printf("%d\n\n",touhi_kou(a1,d,n));
        }
    }
}