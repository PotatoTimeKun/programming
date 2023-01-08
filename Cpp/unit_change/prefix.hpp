/**
 * @file prefix.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 接頭辞の単位を変換するためのprefixクラスのchange関数が入っています。
 * 
 */
#ifndef PREFIX_LENGTH
#define PREFIX_LENGTH
#include <string>
#include <map>
using namespace std;
const map<string, double> PREFIX = {{"nomal", 1}, {"Y", 1000000000000000000000000}, {"Z", 1000000000000000000000}, {"E", 1000000000000000000}, {"P", 1000000000000000}, {"T", 1000000000000}, {"G", 1000000000}, {"M", 1000000}, {"k", 1000}, {"h", 100}, {"da", 10}, {"d", 0.1}, {"c", 0.01}, {"m", 0.001}, {"micro", 0.000001}, {"n", 0.000000001}, {"p", 0.000000000001}, {"f", 0.000000000000001}, {"a", 0.000000000000000001}, {"z", 0.000000000000000000001}, {"y", 0.000000000000000001}};
/**
 * @brief 接頭辞を扱うクラスです。
 * change関数が入っています。
 * 
 */
class prefix
{
public:
        /**
         * @brief 接頭辞の単位を変換します。
         * 対応単位一覧
         * "Y":10^24
        "Z":10^21
        "E":10^18
        "P":10^15
        "T":10^12
        "G":10^9
        "M":10^6
        "k":10^3
        "h":10^2
        "da":10
        "normal":1
        "d":10^-1
        "c":10^-2
        "m":10^-3
        "micro":10^-6(μ)
        "n":10^-9
        "p":10^-12
        "f":10^-15
        "a":10^-18
        "z":10^-21
        "y":10^-24
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static double change(double from, string kigou, string to_kigou)
    {
        double to;
        to = from * PREFIX.at(kigou);
        to = to / PREFIX.at(to_kigou);
        return to;
    }
};
#endif
