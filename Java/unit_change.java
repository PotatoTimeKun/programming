/**
 * 単位を変換するための各クラスのchange関数が入っています。
 * クラス一覧
 * acc:加速度
 * area:面積
 * length:長さ
 * mass:質量
 * prefix:接頭辞
 * speed:速度
 * temperature:温度
 * time_unit:時間
 * volume:体積
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * 
 */

import java.util.*;
/**
 * 加速度を扱うクラスです。
 * change関数が入っています。
 * 
 */
class acc{
    static Map<String,Double> ACC_TANNI=new HashMap<>(){{put("m/s2",1.0);put("km/h/s",0.27777777);put("ft/h/s",0.00008466666666);put("in/min/s",0.000423333333);put("ft/min/s",0.00508);put("Gal",0.01);put("in/s2",0.0254);put("ft/s2",0.3048);put("mi/h/s",0.44704);put("kn/s",0.5144444);put("g",9.80665);put("mi/min/s",26.8224);put("mi/s2",1609.344);}};
        /**
         * 加速度の単位を変換します。
         * 対応単位一覧
         * "m/s2":メートル毎秒毎秒(1m/s^2)
        "km/h/s":キロメートル毎時毎秒(0.27777777m/s^2)
        "ft/h/s":フィート毎時毎秒(0.00008466666666m/s^2)
        "ft/min/s":フィート毎分毎秒(0.00508m/s^2)
        "ft/s2":フィート毎秒毎秒(0.3048m/s^2)
        "in/min/s":インチ毎分毎秒(0.000423333333m/s^2)
        "in/s2":インチ毎秒毎秒(0.0254m/s^2)
        "mi/h/s":マイル毎時毎秒(0.44704m/s^2)
        "mi/min/s":マイル毎分毎秒(26.8224m/s^2)
        "mi/s2":マイル毎秒毎秒(1609.344m/s^2)
        "kn/s":ノット毎秒(0.5144444m/s^2)
        "Gal":ガル(0.01m/s^2)
        "g":標準重力加速度(9.80665m/s^2)
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*ACC_TANNI.get(kigou);
        to=to/ACC_TANNI.get(to_kigou);
        return to;
    }
};
/**
 * 面積を扱うクラスです。
 * change関数が入っています。
 * 
 */
class area{
    static Map<String,Double> AREA_TANNI=new HashMap<>(){{put("m2",1.);put("a",100.);put("ha",10000.);put("km2",1000000.);put("TUBO",3.305785124);put("BU",3.305785124);put("SE",99.173554);put("TAN",991.736);put("CHOU",9917.35537);put("ft2",0.09290304);put("in2",0.00064516);put("yd2",0.83612736);}};
        /**
         * 面積の単位を変換します。
         * 対応単位一覧
         * "m2":平方メートル(1m^2)
        "km2":平方キロメートル(1000000m^2)
        "a":アール(100m^2)
        "ha":ヘクタール(10000m^2)
        "TUBO":坪(3.305785124m^2)
        "BU":歩(3.305785124m^2)
        "SE":畝(99.173554m^2)
        "TAN":反(991.736m^2)
        "CHOU":町(9917.35537m^2)
        "ft2":平方フィート(0.09290304m^2)
        "in2":平方インチ(0.00064516m^2)
        "yd2":平方ヤード(0.83612736m^2)
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*AREA_TANNI.get(kigou);
        to=to/AREA_TANNI.get(to_kigou);
        return to;
    }
};
/**
 * 長さを扱うクラスです。
 * change関数が入っています。
 * 
 */
class length{
    static Map<String,Double> LENGTH_TANNI=new HashMap<>(){{put("m",1.);put("au",149597870700.);put("KAIRI",1852.);put("in",0.0254);put("ft",0.3048);put("yd",0.9144);put("mile",1604.344);put("RI",3927.27);put("HIRO",1.1818);put("KEN",1.1818);put("SHAKU",0.30303);put("SUN",0.030303);put("ly",9460730472580800.);}};
        /**
         * 長さの単位を変換します。
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
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*LENGTH_TANNI.get(kigou);
        to=to/LENGTH_TANNI.get(to_kigou);
        return to;
    }
};
/**
 * 質量を扱うクラスです。
 * change関数が入っています。
 * 
 */
class mass{
    static public Map<String,Double> MASS_TANNI=new HashMap<>(){{put("g",1.);put("kg",1000.);put("t",1000000.);put("gamma",0.000001);put("kt",0.2);put("oz",28.349523125);put("lb",453.59237);put("q",100000.);put("mom",3.75);put("KAN",3750.);put("RYOU",37.5);put("KIN",600.);}};
        /**
         * 質量の単位を変換します。
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
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*MASS_TANNI.get(kigou);
        to=to/MASS_TANNI.get(to_kigou);
        return to;
    }
};
/**
 * 接頭辞を扱うクラスです。
 * change関数が入っています。
 * 
 */
class prefix{
    static public Map<String,Double> PREFIX=new HashMap<>(){{put("nomal",1.);put("Y",1000000000000000000000000.);put("Z",1000000000000000000000.);put("E",1000000000000000000.);put("P",1000000000000000.);put("T",1000000000000.);put("G",1000000000.);put("M",1000000.);put("k",1000.);put("h",100.);put("da",10.);put("d",0.1);put("c",0.01);put("m",0.001);put("micro",0.000001);put("n",0.000000001);put("p",0.000000000001);put("f",0.000000000000001);put("a",0.000000000000000001);put("z",0.000000000000000000001);put("y",0.000000000000000001);}};
        /**
         * 接頭辞の単位を変換します。
         * 対応単位一覧
         * "Y":10^24
        "Z":10^21
        "E":10^18
        "P":10^15
        "T":10^12
        "G":10^9
        "M":10^6
        "k":10^3
        "h":10^2
        "da":10
        "normal":1
        "d":10^-1
        "c":10^-2
        "m":10^-3
        "micro":10^-6(μ)
        "n":10^-9
        "p":10^-12
        "f":10^-15
        "a":10^-18
        "z":10^-21
        "y":10^-24
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*PREFIX.get(kigou);
        to=to/PREFIX.get(to_kigou);
        return to;
    }
};
/**
 * 速度を扱うクラスです。
 * change関数が入っています。
 * 
 */
class speed{
    static public Map<String,Double> SPEED_TANNI=new HashMap<>(){{put("m/s",1.);put("ft/h",0.00008466667);put("in/min",0.000423333);put("ft/min",0.00508);put("in/s",0.0254);put("km/h",0.2777778);put("ft/s",0.3048);put("mi/h",0.44704);put("kn",0.514444);put("mi/min",26.8224);put("mi/s",1.609344);put("c",299792458.);}};
        /**
         * 速度の単位を変換します。
         * 対応単位一覧
         * "m/s":メートル毎秒(1m/s)
        "km/h":キロメートル毎時(0.2777778m/s)
        "ft/h":フィート毎時(0.00008466667m/s)
        "ft/min":フィート毎分(0.00508m/s)
        "ft/s":フィート毎秒(0.3048m/s)
        "in/min":インチ毎分(0.000423333m/s)
        "in/s":インチ毎秒(0.0254m/s)
        "mi/h":マイル毎時(0.44704m/s)
        "mi/min":マイル毎分(26.8224m/s)
        "mi/s":マイル毎秒(1.609344m/s)
        "kn":ノット(0.514444m/s)
        "c":真空中の光速度(299792458m/s)
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*SPEED_TANNI.get(kigou);
        to=to/SPEED_TANNI.get(to_kigou);
        return to;
    }
};
/**
 *  温度を扱うクラスです。
 * change関数が入っています。
 * 
 */
class temperature{
    static public Map<String,Double> TEMP_TANNI_p=new HashMap<>(){{put("K",0.0);put("C",237.15);put("F",459.67);put("Ra",0.);}};
    static public Map<String,Double> TEMP_TANNI_m=new HashMap<>(){{put("K",1.);put("C",1.);put("F",5/9.);put("Ra",5/9.);}};
    /**
         * 温度の単位を変換します。
         * 対応単位一覧
         * "K":ケルビン
         * "C":セルシウス度
         * "F":ファーレンハイト度
         * "Ra":ランキン度
         * 
         * @param from 値
         * @param kigou 値の単位
         * @param to_kigou 変換後の単位
         * @return double 変換後の値 
         */
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from+TEMP_TANNI_p.get(kigou);
        to=to*TEMP_TANNI_m.get(kigou);
        to=to/TEMP_TANNI_m.get(to_kigou);
        to=to-TEMP_TANNI_p.get(to_kigou);
        return to;
    }
};
/**
 * 時間を扱うクラスです。
 * change関数が入っています。
 * 
 */
class time_unit{
    static public Map<String,Double> TIME_TANNI=new HashMap<>(){{put("s",1.);put("shake",0.00000001);put("TU",0.001024);put("jiffy_e",1./50);put("jiffy_w",1./60);put("min",60.);put("moment",90.);put("KOKU",900.);put("KOKU_old",864.);put("h",60.*60);put("d",60.*60*24);put("wk",60.*60*24*7);put("JUN",60.*60*24*10);put("fortnight",60.*60*24*14);put("SAKUBO",2551442.27);put("mo",60.*60*24*30);put("quarter",7776000.);put("semester",10872000.);put("y",31536000.);put("greg",31556952.);put("juli",31557600.);put("year",31558149.764928);put("c",3153600000.);}};
        /**
         * 加速度の単位を変換します。
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
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*TIME_TANNI.get(kigou);
        to=to/TIME_TANNI.get(to_kigou);
        return to;
    }
};
/**
 * 体積を扱うクラスです。
 * change関数が入っています。
 * 
 */
class volume{
    static public Map<String,Double> VOLUME_TANNI=new HashMap<>(){{put("m3",1.);put("L",0.001);put("KOSAJI",0.000005);put("OSAJI",0.000015);put("c",0.00025);put("lambda",0.000000001);put("acft",1233.48183754752);put("drop",0.00000005);put("in3",0.000016387064);put("ft3",0.028316846592);put("yd3",0.764554857984);put("mi3",4168.181825440579584);put("SHOU",0.0018039);put("KOKU",0.18039);put("GOU",0.00018039);put("TO",0.018039);put("SHAKU",0.000018039);}};
    /**
         * 体積の単位を変換します。
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
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*VOLUME_TANNI.get(kigou);
        to=to/VOLUME_TANNI.get(to_kigou);
        return to;
    }
};
