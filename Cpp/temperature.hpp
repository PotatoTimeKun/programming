/**
 * @file temperature.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 温度の単位を変換するためのtemperatureクラスのchange関数が入っています。
 * 
 */
#ifndef INCLUDE_TEMPERATURE
#define INCLUDE_TEMPERATURE
#include <string>
#include <map>
using namespace std;
const map<string, double> TEMP_TANNI_p = {{"K", 0}, {"C", 237.15}, {"F", 459.67}, {"Ra", 0}};
const map<string, double> TEMP_TANNI_m = {{"K", 1}, {"C", 1}, {"F", 5 / 9}, {"Ra", 5 / 9}};
/**
 * @brief 温度を扱うクラスです。
 * change関数が入っています。
 * 
 */
class temperature
{
    public:
        /**
         * @brief 温度の単位を変換します。
         * 対応単位一覧
         * "K":ケルビン
         * "C":セルシウス度
         * "F":ファーレンハイト度
         * "Ra":ランキン度
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static double change(double from, string kigou, string to_kigou)
    {
        double to;
        to = from + TEMP_TANNI_p.at(kigou);
        to = to * TEMP_TANNI_m.at(kigou);
        to = to / TEMP_TANNI_m.at(to_kigou);
        to = to - TEMP_TANNI_p.at(to_kigou);
        return to;
    }
};
#endif
