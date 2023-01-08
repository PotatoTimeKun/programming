/**
 * @file speed.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 速度の単位を変換するためのspeedクラスのchange関数が入っています。
 * 
 */
#ifndef SPEED_LENGTH
#define SPEED_LENGTH
#include <string>
#include <map>
using namespace std;
const map<string, double> SPEED_TANNI = {{"m/s", 1}, {"ft/h", 0.00008466667}, {"in/min", 0.000423333}, {"ft/min", 0.00508}, {"in/s", 0.0254}, {"km/h", 0.2777778}, {"ft/s", 0.3048}, {"mi/h", 0.44704}, {"kn", 0.514444}, {"mi/min", 26.8224}, {"mi/s", 1.609344}, {"c", 299792458}};
/**
 * @brief 速度を扱うクラスです。
 * change関数が入っています。
 * 
 */
class speed
{
public:
        /**
         * @brief 速度の単位を変換します。
         * 対応単位一覧
         * "m/s":メートル毎秒(1m/s)
        "km/h":キロメートル毎時(0.2777778m/s)
        "ft/h":フィート毎時(0.00008466667m/s)
        "ft/min":フィート毎分(0.00508m/s)
        "ft/s":フィート毎秒(0.3048m/s)
        "in/min":インチ毎分(0.000423333m/s)
        "in/s":インチ毎秒(0.0254m/s)
        "mi/h":マイル毎時(0.44704m/s)
        "mi/min":マイル毎分(26.8224m/s)
        "mi/s":マイル毎秒(1.609344m/s)
        "kn":ノット(0.514444m/s)
        "c":真空中の光速度(299792458m/s)
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static double change(double from, string kigou, string to_kigou)
    {
        double to;
        to = from * SPEED_TANNI.at(kigou);
        to = to / SPEED_TANNI.at(to_kigou);
        return to;
    }
};
#endif