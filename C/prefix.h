/**
 * @file prefix.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 接頭辞の単位を変換するためのprefixchange関数が入っています。
 * 
 */
#ifndef PREFIX_LENGTH
#define PREFIX_LENGTH
const double PREFIX[] = {1,1000000000000000000000000,1000000000000000000000,1000000000000000000,1000000000000000,1000000000000,1000000000,1000000,1000,100,10,0.1,0.01,0.001,0.000001,0.000000001,0.000000000001,0.000000000000001,0.000000000000000001,0.000000000000000000001,0.000000000000000001};
    /**
    @brief 接頭辞の単位を変換します。
    対応単位一覧
    0番="normal":1
    1番="Y":10^24
    2番="Z":10^21
    3番="E":10^18
    4番="P":10^15
    5番="T":10^12
    6番="G":10^9
    7番="M":10^6
    8番="k":10^3
    9番="h":10^2
    10番="da":10
    11番="d":10^-1
    12番="c":10^-2
    13番="m":10^-3
    14番="micro":10^-6(μ)
    15番="n":10^-9
    16番="p":10^-12
    17番="f":10^-15
    18番="a":10^-18
    19番="z":10^-21
    20番="y":10^-24
    @param from 値
    @param kigou 値の単位(番号)
    @param to_kigou 変換後の単位(番号)
    @return double 変換後の値 
     */
double prefixchange(double from, int kigou, int to_kigou)
{
    double to;
    to = from * PREFIX[kigou];
    to = to / PREFIX[to_kigou];
    return to;
}
#endif
