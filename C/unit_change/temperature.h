/**
 * @file temperature.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 温度の単位を変換するためのtemperaturechange関数が入っています。
 * 
 */
#ifndef INCLUDE_TEMPERATURE
#define INCLUDE_TEMPERATURE
const double TEMP_TANNI_p[] = {0,237.15,459.67,0};
const double TEMP_TANNI_m[] = {1,1, 5 / 9, 5 / 9};
    /**
     * @brief 温度の単位を変換します。
     * 対応単位一覧
     * 0番="K":ケルビン
     * 1番="C":セルシウス度
     * 2番="F":ファーレンハイト度
     * 3番="Ra":ランキン度
     * @param from 値
     * @param kigou 値の単位(番号)
     * @param to_kigou 変換後の単位(番号)
     * @return double 変換後の値 
     */
double remperaturechange(double from, int kigou, int to_kigou)
{
    double to;
    to = from + TEMP_TANNI_p[kigou];
    to = to * TEMP_TANNI_m[kigou];
    to = to / TEMP_TANNI_m[to_kigou];
    to = to - TEMP_TANNI_p[to_kigou];
    return to;
}
#endif
