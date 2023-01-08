/**
 * @file acceleration.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 加速度の単位を変換するためのaccクラスのchange関数が入っています。
 * 
 */
#ifndef INCLUDE_ACC
#define INCLUDE_ACC
#include <string>
#include <map>
using namespace std;
const map<string, double> ACC_TANNI = {{"m/s2", 1}, {"km/h/s", 0.27777777}, {"ft/h/s", 0.00008466666666}, {"in/min/s", 0.000423333333}, {"ft/min/s", 0.00508}, {"Gal", 0.01}, {"in/s2", 0.0254}, {"ft/s2", 0.3048}, {"mi/h/s", 0.44704}, {"kn/s", 0.5144444}, {"g", 9.80665}, {"mi/min/s", 26.8224}, {"mi/s2", 1609.344}};
/**
 * @brief 加速度を扱うクラスです。
 * change関数が入っています。
 * 
 */
class acc
{
public:
        /**
         * @brief 加速度の単位を変換します。
         * 対応単位一覧
         * "m/s2":メートル毎秒毎秒(1m/s^2)
        "km/h/s":キロメートル毎時毎秒(0.27777777m/s^2)
        "ft/h/s":フィート毎時毎秒(0.00008466666666m/s^2)
        "ft/min/s":フィート毎分毎秒(0.00508m/s^2)
        "ft/s2":フィート毎秒毎秒(0.3048m/s^2)
        "in/min/s":インチ毎分毎秒(0.000423333333m/s^2)
        "in/s2":インチ毎秒毎秒(0.0254m/s^2)
        "mi/h/s":マイル毎時毎秒(0.44704m/s^2)
        "mi/min/s":マイル毎分毎秒(26.8224m/s^2)
        "mi/s2":マイル毎秒毎秒(1609.344m/s^2)
        "kn/s":ノット毎秒(0.5144444m/s^2)
        "Gal":ガル(0.01m/s^2)
        "g":標準重力加速度(9.80665m/s^2)
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static double change(double from, string kigou, string to_kigou)
    {
        double to;
        to = from * ACC_TANNI.at(kigou);
        to = to / ACC_TANNI.at(to_kigou);
        return to;
    }
};
#endif