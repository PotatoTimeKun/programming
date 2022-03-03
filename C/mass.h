/**
 * @file mass.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 質量の単位を変換するためのmasschange関数が入っています。
 * 
 */
#ifndef INCLUDE_MASS
#define INCLUDE_MASS
const double MASS_TANNI[]={1,1000,1000000,0.000001,0.2,28.349523125,453.59237,100000,3.75,3750,37.5,600};
    /**
     * @brief 質量の単位を変換します。
     * 対応単位一覧
     * 0番="g":グラム
     * 1番="kg":キログラム(1000g)
     * 2番="t":トン(1000000g)
     * 3番="gamma":γ(0.000001g)
     * 4番="kt":カラット(0.2g)
     * 5番="oz":オンス(28.349523125g)
     * 6番="lb":ポンド(453.59237g)
     * 7番="q":キンタル(100000g)
     * 8番="mom":匁(3.75g)
     * 9番="KAN":貫(3750g)
     * 10番="RYOU":両(37.5g)
     * 11番="KIN":斤(600g)
     * 
     * @param from 値
     * @param kigou 値の単位(番号)
     * @param to_kigou 変換後の単位(番号)
     * @return double 変換後の値 
     */
double masschange(double from,int kigou,int to_kigou){
    double to;
    to=from*MASS_TANNI[kigou];
    to=to/MASS_TANNI[to_kigou];
    return to;
}
#endif
