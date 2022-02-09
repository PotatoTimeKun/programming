#include <math.h>
double heron(double a,double b,double c){
    double S,s;
    s=(a+b+c)/2;
    S=sqrt(s*(s-a)*(s-b)*(s-c));
    return S;
}
long long factorial(int n){
    long long ret=1;
    for(int i=0;i<=n;i++)ret*=i;
    return ret;
}
long long combination(int n,int r){
    long long ret;
    ret=factorial(n)/factorial(n-r);
    return ret;
}
long long permutation(int n,int r){
    long long ret;
    ret=combination(n,r)/factorial(r);
    return ret;
}
double GP_sum(double a1,double r,int n){
    if(r==1.0)return a1*n;
    return a1*(1-pow(r,n))/(1-r);
}
double GP_n(double a1,double r,int n){
    return a1*pow(r,n-1);
}
double AP_sum(double a1,double d,int n){
    return n*(2*a1+(n-1)*d)/2;
}
double AP_n(double a1,double d,int n){
    return a1+(n-1)*d;
}
const double MATH_PI=3.141592653589793;
const double MATH_E= 2.718281828459045;
double circle(double r){
    return MATH_PI*r;
}
double circle_s(double r){
    return MATH_PI*r*r;
}
double sphere(double r){
    return 4/3*MATH_PI*pow(r,3);
}
double sphere_s(double r){
    return 4*MATH_PI*pow(r,2);
}
double dintance(double x1,double y1,double x2,double y2){
    return sqrt(pow(x2-x1,2)+pow(y2-y1,2));
}
double* divide_point(double x1,double y1,double x2,double y2,double m,double n){
    double ret[2]={(n*x1+m*x2)/(m+n),(n*y1+m*y2)/(m+n)};
    return ret;
}
double* tri_cent(double x1,double y1,double x2,double y2,double x3,double y3){
    double ret[2]={(x1+x2+x3)/3,(y1+y2+y3)/3};
    return ret;
}
double* focus(double a,double b){
    double c;
    if(a>b){
        c=sqrt(a*a-b*b);
        double ret[4]={c,0,-c,0};
        return ret;
    }
    if(b>a){
        c=sqrt(b*b-a*a);
        double ret[4]={0,c,0,-c};
        return ret;
    }
    double ret[4]={0,0,0,0};
    return ret;
}
double* hyperbola_focus(double a,double b,int n){
    double c;
    if(n==1){
        c=sqrt(a*a+b*b);
        double ret[4]={c,0,-c,0};
        return ret;
    }
    if(n==-1){
        c=sqrt(a*a+b*b);
        double ret[4]={0,c,0,-c};
        return ret;
    }
    double ret[4]={0,0,0,0};
    return ret;
}