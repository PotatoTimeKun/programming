/**
 * @file mass.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 質量の単位を変換するためのmassクラスのchange関数が入っています。
 * 
 */
#ifndef INCLUDE_MASS
#define INCLUDE_MASS
#include <string>
#include <map>
using namespace std;
const map<string,double> MASS_TANNI={{"g",1},{"kg",1000},{"t",1000000},{"gamma",0.000001},{"kt",0.2},{"oz",28.349523125},{"lb",453.59237},{"q",100000},{"mom",3.75},{"KAN",3750},{"RYOU",37.5},{"KIN",600}};
/**
 * @brief 質量を扱うクラスです。
 * change関数が入っています。
 * 
 */
class mass{
    public:
        /**
         * @brief 質量の単位を変換します。
         * 対応単位一覧
         * "g":グラム
         * "kg":キログラム(1000g)
         * "t":トン(1000000g)
         * "gamma":γ(0.000001g)
         * "kt":カラット(0.2g)
         * "oz":オンス(28.349523125g)
         * "lb":ポンド(453.59237g)
         * "q":キンタル(100000g)
         * "mom":匁(3.75g)
         * "KAN":貫(3750g)
         * "RYOU":両(37.5g)
         * "KIN":斤(600g)
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*MASS_TANNI.at(kigou);
            to=to/MASS_TANNI.at(to_kigou);
            return to;
        }
};
#endif
