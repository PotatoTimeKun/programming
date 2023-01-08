/**
 * @file time_unit.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 時間の単位を変換するためのtime_unitクラスのchange関数が入っています。
 * 
 */
#ifndef INCLUDE_TIMEUNIT
#define INCLUDE_TIMEUNIT
#include <string>
#include <map>
using namespace std;
const map<string, double> TIME_TANNI = {{"s", 1}, {"shake", 0.00000001}, {"TU", 0.001024}, {"jiffy_e", 1 / 50}, {"jiffy_w", 1 / 60}, {"min", 60}, {"moment", 90}, {"KOKU", 900}, {"KOKU_old", 864}, {"h", 60 * 60}, {"d", 60 * 60 * 24}, {"wk", 60 * 60 * 24 * 7}, {"JUN", 60 * 60 * 24 * 10}, {"fortnight", 60 * 60 * 24 * 14}, {"SAKUBO", 2551442.27}, {"mo", 60 * 60 * 24 * 30}, {"quarter", 7776000}, {"semester", 10872000.}, {"y", 31536000.}, {"greg", 31556952.}, {"juli", 31557600.}, {"year", 31558149.764928}, {"c", 3153600000.}};
/**
 * @brief 時間を扱うクラスです。
 * change関数が入っています。
 * 
 */
class time_unit
{
public:
        /**
         * @brief 加速度の単位を変換します。
         * 対応単位一覧
         * "s":秒(1s)
        "shake":シェイク(0.00000001s)
        "TU":Time Unit(0.001024s)
        "jiffy_e":ジフィ(電子工学,東日本)(1/50)
        "jiffy_w":ジフィ(電子工学,西日本)(1/60)
        "min":分(60s)
        "moment":モーメント(90s)
        "KOKU":刻(中国,100刻制)(900s)
        "KOKU_old":刻(中国,96刻制)(864s)
        "h":時(60*60s)
        "d":日(606024s)
        "wk":週(606024*7s)
        "JUN":旬(606024*10s)
        "fortnight":フォートナイト(半月)(606024*14s)
        "SAKUBO":朔望月(2551442.27s)
        "mo":月(30d)(606024*30s)
        "quarter":四半期(7776000s)
        "semester":セメスター(10872000s)
        "y":年(365d)(31536000s)
        "greg":グレゴリオ年(31556952s)
        "juli":ユリウス年(31557600s)
        "year":恒星年(31558149.764928s)
        "c":世紀(365d*100)(3153600000s)
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static double change(double from, string kigou, string to_kigou)
    {
        double to;
        to = from * TIME_TANNI.at(kigou);
        to = to / TIME_TANNI.at(to_kigou);
        return to;
    }
};
#endif