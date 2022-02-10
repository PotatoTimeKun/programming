import java.util.*;
class acc{
    static Map<String,Double> ACC_TANNI=new HashMap<>(){{put("m/s2",1.0);put("km/h/s",0.27777777);put("ft/h/s",0.00008466666666);put("in/min/s",0.000423333333);put("ft/min/s",0.00508);put("Gal",0.01);put("in/s2",0.0254);put("ft/s2",0.3048);put("mi/h/s",0.44704);put("kn/s",0.5144444);put("g",9.80665);put("mi/min/s",26.8224);put("mi/s2",1609.344);}};
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*ACC_TANNI.get(kigou);
        to=to/ACC_TANNI.get(to_kigou);
        return to;
    }
};
class area{
    static Map<String,Double> AREA_TANNI=new HashMap<>(){{put("m2",1.);put("a",100.);put("ha",10000.);put("km2",1000000.);put("TUBO",3.305785124);put("BU",3.305785124);put("SE",99.173554);put("TAN",991.736);put("CHOU",9917.35537);put("ft2",0.09290304);put("in2",0.00064516);put("yd2",0.83612736);}};
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*AREA_TANNI.get(kigou);
        to=to/AREA_TANNI.get(to_kigou);
        return to;
    }
};
class length{
    static Map<String,Double> LENGTH_TANNI=new HashMap<>(){{put("m",1.);put("au",149597870700.);put("KAIRI",1852.);put("in",0.0254);put("ft",0.3048);put("yd",0.9144);put("mile",1604.344);put("RI",3927.27);put("HIRO",1.1818);put("KEN",1.1818);put("SHAKU",0.30303);put("SUN",0.030303);put("ly",9460730472580800.);}};
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*LENGTH_TANNI.get(kigou);
        to=to/LENGTH_TANNI.get(to_kigou);
        return to;
    }
};
class mass{
    static public Map<String,Double> MASS_TANNI=new HashMap<>(){{put("g",1.);put("kg",1000.);put("t",1000000.);put("gamma",0.000001);put("kt",0.2);put("oz",28.349523125);put("lb",453.59237);put("q",100000.);put("mom",3.75);put("KAN",3750.);put("RYOU",37.5);put("KIN",600.);}};
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*MASS_TANNI.get(kigou);
        to=to/MASS_TANNI.get(to_kigou);
        return to;
    }
};
class prefix{
    static public Map<String,Double> PREFIX=new HashMap<>(){{put("nomal",1.);put("Y",1000000000000000000000000.);put("Z",1000000000000000000000.);put("E",1000000000000000000.);put("P",1000000000000000.);put("T",1000000000000.);put("G",1000000000.);put("M",1000000.);put("k",1000.);put("h",100.);put("da",10.);put("d",0.1);put("c",0.01);put("m",0.001);put("micro",0.000001);put("n",0.000000001);put("p",0.000000000001);put("f",0.000000000000001);put("a",0.000000000000000001);put("z",0.000000000000000000001);put("y",0.000000000000000001);}};
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*PREFIX.get(kigou);
        to=to/PREFIX.get(to_kigou);
        return to;
    }
};
class speed{
    static public Map<String,Double> SPEED_TANNI=new HashMap<>(){{put("m/s",1.);put("ft/h",0.00008466667);put("in/min",0.000423333);put("ft/min",0.00508);put("in/s",0.0254);put("km/h",0.2777778);put("ft/s",0.3048);put("mi/h",0.44704);put("kn",0.514444);put("mi/min",26.8224);put("mi/s",1.609344);put("c",299792458.);}};
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*SPEED_TANNI.get(kigou);
        to=to/SPEED_TANNI.get(to_kigou);
        return to;
    }
};
class temperature{
    static public Map<String,Double> TEMP_TANNI_p=new HashMap<>(){{put("K",0.0);put("C",237.15);put("F",459.67);put("Ra",0.);}};
    static public Map<String,Double> TEMP_TANNI_m=new HashMap<>(){{put("K",1.);put("C",1.);put("F",5/9.);put("Ra",5/9.);}};
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from+TEMP_TANNI_p.get(kigou);
        to=to*TEMP_TANNI_m.get(kigou);
        to=to/TEMP_TANNI_m.get(to_kigou);
        to=to-TEMP_TANNI_p.get(to_kigou);
        return to;
    }
};
class time_unit{
    static public Map<String,Double> TIME_TANNI=new HashMap<>(){{put("s",1.);put("shake",0.00000001);put("TU",0.001024);put("jiffy_e",1./50);put("jiffy_w",1./60);put("min",60.);put("moment",90.);put("KOKU",900.);put("KOKU_old",864.);put("h",60.*60);put("d",60.*60*24);put("wk",60.*60*24*7);put("JUN",60.*60*24*10);put("fortnight",60.*60*24*14);put("SAKUBO",2551442.27);put("mo",60.*60*24*30);put("quarter",7776000.);put("semester",10872000.);put("y",31536000.);put("greg",31556952.);put("juli",31557600.);put("year",31558149.764928);put("c",3153600000.);}};
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*TIME_TANNI.get(kigou);
        to=to/TIME_TANNI.get(to_kigou);
        return to;
    }
};
class volume{
    static public Map<String,Double> VOLUME_TANNI=new HashMap<>(){{put("m3",1.);put("L",0.001);put("KOSAJI",0.000005);put("OSAJI",0.000015);put("c",0.00025);put("lambda",0.000000001);put("acft",1233.48183754752);put("drop",0.00000005);put("in3",0.000016387064);put("ft3",0.028316846592);put("yd3",0.764554857984);put("mi3",4168.181825440579584);put("SHOU",0.0018039);put("KOKU",0.18039);put("GOU",0.00018039);put("TO",0.018039);put("SHAKU",0.000018039);}};
    static public double change(double from,String kigou,String to_kigou){
        double to;
        to=from*VOLUME_TANNI.get(kigou);
        to=to/VOLUME_TANNI.get(to_kigou);
        return to;
    }
};
