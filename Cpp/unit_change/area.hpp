/**
 * @file area.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 面積の単位を変換するためのareaクラスのchange関数が入っています。
 * 
 */
#ifndef AREA_LENGTH
#define AREA_LENGTH
#include <string>
#include <map>
using namespace std;
const map<string, double> AREA_TANNI = {{"m2", 1}, {"a", 100}, {"ha", 10000}, {"km2", 1000000}, {"TUBO", 3.305785124}, {"BU", 3.305785124}, {"SE", 99.173554}, {"TAN", 991.736}, {"CHOU", 9917.35537}, {"ft2", 0.09290304}, {"in2", 0.00064516}, {"yd2", 0.83612736}};
/**
 * @brief 面積を扱うクラスです。
 * change関数が入っています。
 * 
 */
class area
{
public:
        /**
         * @brief 温度の単位を変換します。
         * 対応単位一覧
         * "m2":平方メートル(1m^2)
        "km2":平方キロメートル(1000000m^2)
        "a":アール(100m^2)
        "ha":ヘクタール(10000m^2)
        "TUBO":坪(3.305785124m^2)
        "BU":歩(3.305785124m^2)
        "SE":畝(99.173554m^2)
        "TAN":反(991.736m^2)
        "CHOU":町(9917.35537m^2)
        "ft2":平方フィート(0.09290304m^2)
        "in2":平方インチ(0.00064516m^2)
        "yd2":平方ヤード(0.83612736m^2)
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static double change(double from, string kigou, string to_kigou)
    {
        double to;
        to = from * AREA_TANNI.at(kigou);
        to = to / AREA_TANNI.at(to_kigou);
        return to;
    }
};
#endif