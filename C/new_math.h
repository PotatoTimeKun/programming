/**
 * @file newmath.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 数学関係の関数が入っています。
 * @details 関数一覧
 * double heron(double a, double b, double c)
 * long long factorial(int n)
 * long long combination(int n, int r)
 * long long permutation(int n, int r)
 * double GP_sum(double a1, double r, int n)
 * double GP_n(double a1, double r, int n)
 * double AP_sum(double a1, double d, int n)
 * double AP_n(double a1, double d, int n)
 * const double MATH_PI
 * const double MATH_E
 * double circle(double r)
 * double circle_s(double r)
 * double sphere(double r)
 * double sphere_s(double r)
 * double dintance(double x1, double y1, double x2, double y2)
 * void divide_point(double x1, double y1, double x2, double y2, double m, double n, double *return_array)
 * void tri_cent(double x1, double y1, double x2, double y2, double x3, double y3, double *return_array)
 * void focus(double a, double b, double *return_array)
 * void hyperbola_focus(double a, double b, int n, double *return_array)
 * 
 */
#include <math.h>
/**
 * @brief ヘロンの公式より面積を返します。
 * 
 * @param a 辺aの長さ
 * @param b 辺bの長さ
 * @param c 辺cの長さ
 * @return double 三角形の面積
 */
double heron(double a, double b, double c)
{
    double S, s;
    s = (a + b + c) / 2;
    S = sqrt(s * (s - a) * (s - b) * (s - c));
    return S;
}
/**
 * @brief nの階乗を返します。
 * 
 * @param n 
 * @return long long n!
 */
long long factorial(int n)
{
    long long ret = 1;
    for (int i = 1; i <= n; i++)
        ret *= i;
    return ret;
}
/**
 * @brief nからr個選んだ組み合わせ(nCr)を返します。
 * 
 * @param n 
 * @param r 
 * @return long long nCr
 */
long long combination(int n, int r)
{
    long long ret;
    ret = factorial(n) / factorial(n - r);
    return ret;
}
/**
 * @brief nからr個選んだ順列(nPr)を返します。
 * 
 * @param n 
 * @param r 
 * @return long long nPr
 */
long long permutation(int n, int r)
{
    long long ret;
    ret = combination(n, r) / factorial(r);
    return ret;
}
/**
 * @brief 等比数列の第n項までの総和を返します。
 * 
 * @param a1 初項
 * @param r 公比
 * @param n 第n項
 * @return double 総和
 */
double GP_sum(double a1, double r, int n)
{
    if (r == 1.0)
        return a1 * n;
    return a1 * (1 - pow(r, n)) / (1 - r);
}
/**
 * @brief 等比数列の第n項を返します。
 * 
 * @param a1 初項
 * @param r 公比
 * @param n 第n項
 * @return double 第n項の値
 */
double GP_n(double a1, double r, int n)
{
    return a1 * pow(r, n - 1);
}
/**
 * @brief 等差数列の第n項までの総和を返します。
 * 
 * @param a1 初項
 * @param d 公差
 * @param n 第n項
 * @return double 総和
 */
double AP_sum(double a1, double d, int n)
{
    return n * (2 * a1 + (n - 1) * d) / 2;
}
/**
 * @brief 等差数列の第n項を返します。
 * 
 * @param a1 初項
 * @param d 公差
 * @param n 第n項
 * @return double 第n項の値
 */
double AP_n(double a1, double d, int n)
{
    return a1 + (n - 1) * d;
}
/**
 * @brief 円周率(3.141592653589793)
 * 
 */
const double MATH_PI = 3.141592653589793;
/**
 * @brief ネイピア数(2.718281828459045)
 * 
 */
const double MATH_E = 2.718281828459045;
/**
 * @brief 円周を返します。
 * 
 * @param r 半径
 * @return double 円周
 */
double circle(double r)
{
    return 2 * MATH_PI * r;
}
/**
 * @brief 円の面積を返します。
 * 
 * @param r 半径
 * @return double 面積
 */
double circle_s(double r)
{
    return MATH_PI * r * r;
}
/**
 * @brief 球の体積を返します。
 * 
 * @param r 半径
 * @return double 体積
 */
double sphere(double r)
{
    return 4 / 3 * MATH_PI * pow(r, 3);
}
/**
 * @brief 球の表面積を返します。
 * 
 * @param r 半径
 * @return double 表面積
 */
double sphere_s(double r)
{
    return 4 * MATH_PI * pow(r, 2);
}
/**
 * @brief (x1,y1)と(x2,y2)の間の直線距離を返します。
 * 
 * @param x1 
 * @param y1 
 * @param x2 
 * @param y2 
 * @return double 距離
 */
double distance(double x1, double y1, double x2, double y2)
{
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
}
/**
 * @brief (x1,y1)と(x2,y2)を結ぶ線分のm:nの内分点を返します。
 * 
 * @param x1 
 * @param y1 
 * @param x2 
 * @param y2 
 * @param m 
 * @param n 
 * @param return_array 内分点{x,y}
 */
void divide_point(double x1, double y1, double x2, double y2, double m, double n, double *return_array)
{
    return_array[0] = (n * x1 + m * x2) / (m + n);
    return_array[1] = (n * y1 + m * y2) / (m + n);
}
/**
 * @brief 三角形abcの重心を返します。
 * 
 * @param x1 頂点aのx
 * @param y1 頂点aのy
 * @param x2 頂点bのx
 * @param y2 頂点bのy
 * @param x3 頂点cのx
 * @param y3 頂点cのy
 * @param return_array 重心{x,y}
 */
void tri_cent(double x1, double y1, double x2, double y2, double x3, double y3, double *return_array)
{
    return_array[0] = (x1 + x2 + x3) / 3;
    return_array[1] = (y1 + y2 + y3) / 3;
}
/**
 * @brief 楕円(x^2/a^2 + y^2/b^2 = 1)の焦点を返します。
 * 
 * @param a 
 * @param b 
 * @param return_array 焦点(2点){x1,y1,x2,y2}
 */
void focus(double a, double b, double *return_array)
{
    double c;
    if (a > b)
    {
        c = sqrt(a * a - b * b);
        double ret[4] = {c, 0, -c, 0};
        for (int i = 0; i < 4; i++)
            return_array[i] = ret[i];
        return;
    }
    if (b > a)
    {
        c = sqrt(b * b - a * a);
        double ret[4] = {0, c, 0, -c};
        for (int i = 0; i < 4; i++)
            return_array[i] = ret[i];
        return;
    }
    double ret[4] = {0, 0, 0, 0};
    for (int i = 0; i < 4; i++)
        return_array[i] = ret[i];
    return;
}
/**
 * @brief 双曲線(x^2/a^2 + y^2/b^2 = n)の焦点を返します。
 * 
 * @param a 
 * @param b 
 * @param n 1 or -1
 * @param return_array 焦点(2点){x1,y1,x2,y2}
 */
void hyperbola_focus(double a, double b, int n, double *return_array)
{
    double c;
    if (n == 1)
    {
        c = sqrt(a * a + b * b);
        double ret[4] = {c, 0, -c, 0};
        for (int i = 0; i < 4; i++)
            return_array[i] = ret[i];
        return;
    }
    if (n == -1)
    {
        c = sqrt(a * a + b * b);
        double ret[4] = {0, c, 0, -c};
        for (int i = 0; i < 4; i++)
            return_array[i] = ret[i];
        return;
    }
    double ret[4] = {0, 0, 0, 0};
    for (int i = 0; i < 4; i++)
        return_array[i] = ret[i];
    return;
}
/**
 * @brief 三角形の2辺とその間の角から、余剰定理により残りの1辺を求めます。
 * 
 * @param b 辺1
 * @param c 辺2
 * @param A その間の角(ラジアン値)
 * @return double 辺3
 */
double cos_theorem(double b,double c,double A){
    return pow(b,2)+pow(c,2)-2*b*c*cos(A);
}
/**
 * @brief 三角形ABC(角A,B,Cに対する位置の辺をa,b,cとする)のaとA,Bから、正弦定理によりbを求めます。
 * 
 * @param A 角A(ラジアン値)
 * @param B 角B(ラジアン値)
 * @param a 辺a
 * @return double 辺b
 */
double sin_theorem(double A,double B,double a){
    return a/sin(A)*sin(B);
}
/**
 * @brief MATH_PIを使って60分法の角度をラジアンに変換します。
 * 
 * @param arc 
 * @return double 
 */
double rad(double arc){
    return arc/180*MATH_PI;
}
/**
 * @brief MATH_PIを使ってラジアンを60分法に変換します。
 * 
 * @param rad 
 * @return double 
 */
double arc(double rad){
    return rad*180/MATH_PI
}
/**
 * @brief 三角形の2辺とその間の角から三角形の面積を求めます。
 * 
 * @param b 辺1
 * @param c 辺2
 * @param A その間の角(ラジアン値)
 * @return double 面積S
 */
double tri_S(double b,double c,double A){
    return 1/2*b*c*sin(A);
}