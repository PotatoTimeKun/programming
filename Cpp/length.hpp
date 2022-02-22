/**
 * @file length.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 長さの単位を変換するためのlengthクラスのchange関数が入っています。
 * 
 */
#ifndef INCLUDE_LENGTH
#define INCLUDE_LENGTH
#include <string>
#include <map>
using namespace std;
const map<string,double> LENGTH_TANNI={{"m",1},{"au",149597870700},{"KAIRI",1852},{"in",0.0254},{"ft",0.3048},{"yd",0.9144},{"mile",1604.344},{"RI",3927.27},{"HIRO",1.1818},{"KEN",1.1818},{"SHAKU",0.30303},{"SUN",0.030303},{"ly",9460730472580800}};
/**
 * @brief 長さを扱うクラスです。
 * change関数が入っています。
 * 
 */
class length{
    public:
        /**
         * @brief 長さの単位を変換します。
         * 対応単位一覧  
         * "m":メートル  
         * "au":天文単位(149597870700m)  
         * "KAIRI":海里(1852m)  
         * "in":インチ(0.0254m)  
         * "ft":フィート(0.3048m)  
         * "yd":ヤード(0.9144m)  
         * "mile":マイル(1604.344m)  
         * "RI":里(3927.27m)  
         * "HIRO":尋(1.1818m)  
         * "KEN":間(1.1818m)  
         * "SHAKU":尺(0.30303)  
         * "SUN":寸(0.030303m)  
         * "ly":光年(9460730472580800m)  
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値
         */
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*LENGTH_TANNI.at(kigou);
            to=to/LENGTH_TANNI.at(to_kigou);
            return to;
        }
};
#endif