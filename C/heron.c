#include <stdio.h>
#include <math.h>
int main(){
    double a,b,c,S,s;
    printf("三角形の3辺を記入\n有効数字は小数点以下4桁まで\n無理数(平方根等)は記号は付けずに途中まで記入\n");
    printf("a=");
    scanf("%lf",&a);
    printf("b=");
    scanf("%lf",&b);
    printf("c=");
    scanf("%lf",&c);
    s=(a+b+c)/2;
    S=sqrt(s*(s-a)*(s-b)*(s-c));
    printf("三角形ABCの面積は%.4g",a,b,c,S);
}