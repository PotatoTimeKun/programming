/**
 * @file volume.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 体積の単位を変換するためのvolumechange関数が入っています。
 * 
 */
#ifndef VOLUME_LENGTH
#define VOLUME_LENGTH
const double VOLUME_TANNI[] = {1, 0.001, 0.000005, 0.000015, 0.00025, 0.000000001, 1233.48183754752, 0.00000005, 0.000016387064, 0.028316846592, 0.764554857984, 4168.181825440579584, 0.18039, 0.0018039, 0.00018039, 0.018039, 0.000018039};
    /**
    @brief 体積の単位を変換します。
    対応単位一覧
    0番="m3":立方メートル(1m^3)
    1番="L":リットル(0.001m^3)
    2番="KOSAJI":小さじ(0.000005m^3)
    3番="OSAJI":大さじ(0.000015m^3)
    4番="c":カップ(0.00025m^3)
    5番="lambda":λ(0.000000001m^3)
    6番="acft":エーカー・フィート(1233.48183754752m^3)
    7番="drop":ドロップ(0.00000005m^3)
    8番="in3":立方インチ(0.000016387064m^3)
    9番="ft3":立方フィート(0.028316846592m^3)
    10番="yd3":立方ヤード(0.764554857984m^3)
    11番="mi3":立方マイル(4168.181825440579584m^3)
    12番="KOKU":石(0.18039m^3)
    13番="TO":斗(0.018039m^3)
    14番="SHOU":升(0.0018039m^3)
    15番="GOU":合(0.00018039m^3)
    16番="SHAKU":勺(0.000018039m^3)
    @param from 値
    @param kigou 値の単位(番号)
    @param to_kigou 変換後の単位(番号)
    @return double 変換後の値 
     */
double volumechange(double from, int kigou,int to_kigou)
{
    double to;
    to = from * VOLUME_TANNI[kigou];
    to = to / VOLUME_TANNI[to_kigou];
    return to;
}
#endif
