/**
 * @file time_unit.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 時間の単位を変換するためのtime_unitchange関数が入っています。
 * 
 */
#ifndef INCLUDE_TIMEUNIT
#define INCLUDE_TIMEUNIT
const double TIME_TANNI[] = {1, 0.00000001, 0.001024, 1 / 50, 1 / 60, 60, 90, 900, 864, 60 * 60, 60 * 60 * 24, 60 * 60 * 24 * 7, 60 * 60 * 24 * 10, 60 * 60 * 24 * 14, 2551442.27, 60 * 60 * 24 * 30, 7776000, 10872000, 31536000, 31556952, 31557600, 31558149.764928, 3153600000};
    /**
    @brief 加速度の単位を変換します。
    対応単位一覧
    0番="s":秒(1s)
    1番="shake":シェイク(0.00000001s)
    2番="TU":Time Unit(0.001024s)
    3番="jiffy_e":ジフィ(電子工学,東日本)(1/50)
    4番="jiffy_w":ジフィ(電子工学,西日本)(1/60)
    5番="min":分(60s)
    6番="moment":モーメント(90s)
    7番="KOKU":刻(中国,100刻制)(900s)
    8番="KOKU_old":刻(中国,96刻制)(864s)
    9番="h":時(60*60s)
    10番="d":日(606024s)
    11番="wk":週(606024*7s)
    12番="JUN":旬(606024*10s)
    13番="fortnight":フォートナイト(半月)(606024*14s)
    14番="SAKUBO":朔望月(2551442.27s)
    15番="mo":月(30d)(606024*30s)
    16番="quarter":四半期(7776000s)
    17番="semester":セメスター(10872000s)
    18番="y":年(365d)(31536000s)
    19番="greg":グレゴリオ年(31556952s)
    20番="juli":ユリウス年(31557600s)
    21番="year":恒星年(31558149.764928s)
    22番="c":世紀(365d*100)(3153600000s)
    @param from 値
    @param kigou 値の単位(番号)
    @param to_kigou 変換後の単位(番号)
    @return double 変換後の値 
     */
double time_unitchange(double from, int kigou, int to_kigou)
{
    double to;
    to = from * TIME_TANNI[kigou];
    to = to / TIME_TANNI[to_kigou];
    return to;
}
#endif