/**
 * @file length.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 長さの単位を変換するためのlengthchange関数が入っています。
 * 
 */
#ifndef INCLUDE_LENGTH
#define INCLUDE_LENGTH
const double LENGTH_TANNI[]={1,149597870700,1852,0.0254,0.3048,0.9144,1604.344,3927.27,1.1818,1.1818,0.30303,0.030303,9460730472580800};
    /**
     * @brief 長さの単位を変換します。
     * 対応単位一覧  
     * 0番="m":メートル  
     * 1番="au":天文単位(149597870700m)  
     * 2番="KAIRI":海里(1852m)  
     * 3番="in":インチ(0.0254m)  
     * 4番="ft":フィート(0.3048m)  
     * 5番="yd":ヤード(0.9144m)  
     * 6番="mile":マイル(1604.344m)  
     * 7番="RI":里(3927.27m)  
     * 8番="HIRO":尋(1.1818m)  
     * 9番="KEN":間(1.1818m)  
     * 10番="SHAKU":尺(0.30303)  
     * 11番="SUN":寸(0.030303m)  
     * 12番="ly":光年(9460730472580800m)  
     * @param from 値
     * @param kigou 値の単位(番号)
     * @param to_kigou 変換後の単位(番号)
     * @return double 変換後の値
     */
double lengthchange(double from,int kigou,int to_kigou){
    double to;
    to=from*LENGTH_TANNI[kigou];
    to=to/LENGTH_TANNI[to_kigou];
    return to;
}
#endif