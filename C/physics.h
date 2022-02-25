/**
 * @file physics.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 物理関係の公式を使った関数が入っています。
 * 
 */
#ifndef INCLUDE_PHYSICS_H
#define INCLUDE_PHYSICS_H
#include <math.h>
/**
 * @brief 等速直線運動の変位を返します。
 * @param v 速さ
 * @param t 経過時間
 * @return double 移動距離(変位)
 */
double uniform_linear_x(double v,double t){
    return v*t;
}
/**
 * @brief 等速直線運動の速さを返します。
 * @param x 移動距離(変位)
 * @param t 経過時間
 * @return double 速さ
 */
double uniform_linear_v(double x,double t){
    return x/t;
}
/**
 * @brief 等速直線運動の経過時間を返します。
 * @param x 移動距離(変位)
 * @param v 速さ
 * @return double 経過時間
 */
double uniform_linear_t(double x,double v){
    return x/v;
}
/**
 * @brief 等加速度直線運動の変位xを返します。
 * @param v0 初速度
 * @param t 経過時間
 * @param a 加速度
 * @return double 変位
 */
double uniform_acceleration_linear_x(double v0,double t,double a){
    return v0*t+1/2*a*t*t;
}
/**
 * @brief 等加速度直線運動の変位xを返します。
 * @param v0 初速度
 * @param v 変位xの時の速度
 * @param a 加速度
 * @return double 変位
 */
double uniform_acceleration_linear_x_2(double v0,double v,double a){
    return (v*v-v0*v0)/2*a;
}
/**
 * @brief 等加速度直線運動の速度vを返します。
 * @param v0 初速度
 * @param t 経過時間
 * @param a 加速度
 * @return double 速度
 */
double uniform_acceleration_linear_v(double v0,double t,double a){
    return v0+a*t;
}
/**
 * @brief 等加速度直線運動の速度vを返します。
 * @param v0 初速度
 * @param x 速度vの時の変位
 * @param a 加速度
 * @return double 速度
 */
double uniform_acceleration_linear_v_2(double v0,double x,double a){
    return sqrt(2*a*x-v0*v0);
}
/**
 * @brief 等加速度直線運動の加速度aを返します。
 * @param v0 初速度
 * @param v 変位xの時の速度
 * @param x 速度vの時の変位
 * @return double 加速度
 */
double uniform_acceleration_linear_a(double v0,double v,double x){
    return (v*v-v0*v0)/(2*x);
}
/**
 * @brief 等加速度直線運動の加速度aを返します。
 * @param v0 初速度
 * @param v 経過時間tの時の速度
 * @param t 速度vの時の経過時間
 * @return double 加速度
 */
double uniform_acceleration_linear_a_2(double v0,double v,double t){
    return (v-v0)/t;
}
/**
 * @brief 等加速度直線運動の加速度aを返します。
 * @param v0 初速度
 * @param t 変位xの時の経過時間
 * @param x 経過時間tの時の変位
 * @return double 加速度
 */
double uniform_acceleration_linear_a_3(double v0,double t,double x){
    return (x-v0*t)*2/t/t;
}
/**
 * @brief 標準重力加速度
 */
const double _g_=9.80665;
/**
 * @brief 自由落下運動で経過時間tの時の速度を返します。
 * @param t 経過時間
 * @param g 重力加速度(デフォルト : _g_ )
 * @return double 速度
 */
double free_fall_v(double t,double g=_g_){
    return g*t;
}
/**
 * @brief 自由落下運動で変位yの時の速度を返します。
 * @param y 変位
 * @param g 重力加速度(デフォルト : _g_ )
 * @return double 速度
 */
double free_fall_v_2(double y,double g=_g_){
    return sqrt(2*g*y);
}
/**
 * @brief 自由落下運動で経過時間tの時の変位を返します。
 * @param t 経過時間
 * @param g 重力加速度(デフォルト : _g_ )
 * @return double 変位
 */
double free_fall_y(double t,double g=_g_){
    return 1/2*g*t*t;
}
/**
 * @brief 自由落下運動で速度vの時の変位を返します。
 * @param v 速度
 * @param g 重力加速度(デフォルト : _g_ )
 * @return double 変位
 */
double free_fall_y_2(double v,double g=_g_){
    return v*v/2/g;
}
#endif