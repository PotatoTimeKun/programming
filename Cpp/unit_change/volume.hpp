/**
 * @file volume.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 体積の単位を変換するためのvolumeクラスのchange関数が入っています。
 * 
 */
#ifndef VOLUME_LENGTH
#define VOLUME_LENGTH
#include <string>
#include <map>
using namespace std;
const map<string, double> VOLUME_TANNI = {{"m3", 1}, {"L", 0.001}, {"KOSAJI", 0.000005}, {"OSAJI", 0.000015}, {"c", 0.00025}, {"lambda", 0.000000001}, {"acft", 1233.48183754752}, {"drop", 0.00000005}, {"in3", 0.000016387064}, {"ft3", 0.028316846592}, {"yd3", 0.764554857984}, {"mi3", 4168.181825440579584}, {"KOKU", 0.18039}, {"SHOU", 0.0018039}, {"GOU", 0.00018039}, {"TO", 0.018039}, {"SHAKU", 0.000018039}};
/**
 * @brief 体積を扱うクラスです。
 * change関数が入っています。
 * 
 */
class volume
{
public:
        /**
         * @brief 体積の単位を変換します。
         * 対応単位一覧
         * "m3":立方メートル(1m^3)
        "L":リットル(0.001m^3)
        "KOSAJI":小さじ(0.000005m^3)
        "OSAJI":大さじ(0.000015m^3)
        "c":カップ(0.00025m^3)
        "lambda":λ(0.000000001m^3)
        "acft":エーカー・フィート(1233.48183754752m^3)
        "drop":ドロップ(0.00000005m^3)
        "in3":立方インチ(0.000016387064m^3)
        "ft3":立方フィート(0.028316846592m^3)
        "yd3":立方ヤード(0.764554857984m^3)
        "mi3":立方マイル(4168.181825440579584m^3)
        "KOKU":石(0.18039m^3)
        "TO":斗(0.018039m^3)
        "SHOU":升(0.0018039m^3)
        "GOU":合(0.00018039m^3)
        "SHAKU":勺(0.000018039m^3)
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static double change(double from, string kigou, string to_kigou)
    {
        double to;
        to = from * VOLUME_TANNI.at(kigou);
        to = to / VOLUME_TANNI.at(to_kigou);
        return to;
    }
};
#endif
