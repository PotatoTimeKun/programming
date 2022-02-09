#ifndef INCLUDE_TANNI
#define INCLUDE_TANNI
#include <string>
#include <map>
using namespace std;
const map<string,double> ACC_TANNI={{"m/s2",1},{"km/h/s",0.27777777},{"ft/h/s",0.00008466666666},{"in/min/s",0.000423333333},{"ft/min/s",0.00508},{"Gal",0.01},{"in/s2",0.0254},{"ft/s2",0.3048},{"mi/h/s",0.44704},{"kn/s",0.5144444},{"g",9.80665},{"mi/min/s",26.8224},{"mi/s2",1609.344}};
class acc{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*ACC_TANNI.at(kigou);
            to=to/ACC_TANNI.at(to_kigou);
            return to;
        }
};
const map<string,double> AREA_TANNI={{"m2",1},{"a",100},{"ha",10000},{"km2",1000000},{"TUBO",3.305785124},{"BU",3.305785124},{"SE",99.173554},{"TAN",991.736},{"CHOU",9917.35537},{"ft2",0.09290304},{"in2",0.00064516},{"yd2",0.83612736}};
class area{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*AREA_TANNI.at(kigou);
            to=to/AREA_TANNI.at(to_kigou);
            return to;
        }
};
const map<string,double> LENGTH_TANNI={{"m",1},{"au",149597870700},{"KAIRI",1852},{"in",0.0254},{"ft",0.3048},{"yd",0.9144},{"mile",1604.344},{"RI",3927.27},{"HIRO",1.1818},{"KEN",1.1818},{"SHAKU",0.30303},{"SUN",0.030303},{"ly",9460730472580800}};
class length{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*LENGTH_TANNI.at(kigou);
            to=to/LENGTH_TANNI.at(to_kigou);
            return to;
        }
};
const map<string,double> MASS_TANNI={{"g",1},{"kg",1000},{"t",1000000},{"gamma",0.000001},{"kt",0.2},{"oz",28.349523125},{"lb",453.59237},{"q",100000},{"mom",3.75},{"KAN",3750},{"RYOU",37.5},{"KIN",600}};
class mass{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*MASS_TANNI.at(kigou);
            to=to/MASS_TANNI.at(to_kigou);
            return to;
        }
};
const map<string,double> PREFIX={{"nomal",1},{"Y",1000000000000000000000000},{"Z",1000000000000000000000},{"E",1000000000000000000},{"P",1000000000000000},{"T",1000000000000},{"G",1000000000},{"M",1000000},{"k",1000},{"h",100},{"da",10},{"d",0.1},{"c",0.01},{"m",0.001},{"micro",0.000001},{"n",0.000000001},{"p",0.000000000001},{"f",0.000000000000001},{"a",0.000000000000000001},{"z",0.000000000000000000001},{"y",0.000000000000000001}};
class prefix{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*PREFIX.at(kigou);
            to=to/PREFIX.at(to_kigou);
            return to;
        }
};
const map<string,double> SPEED_TANNI={{"m/s",1},{"ft/h",0.00008466667},{"in/min",0.000423333},{"ft/min",0.00508},{"in/s",0.0254},{"km/h",0.2777778},{"ft/s",0.3048},{"mi/h",0.44704},{"kn",0.514444},{"mi/min",26.8224},{"mi/s",1.609344},{"c",299792458}};
class speed{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*SPEED_TANNI.at(kigou);
            to=to/SPEED_TANNI.at(to_kigou);
            return to;
        }
};
const map<string,double> TEMP_TANNI_p={{"K",0},{"C",237.15},{"F",459.67},{"Ra",0}};
const map<string,double> TEMP_TANNI_m={{"K",1},{"C",1},{"F",5/9},{"Ra",5/9}};
class mass{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from+TEMP_TANNI_p.at(kigou);
            to=to*TEMP_TANNI_m.at(kigou);
            to=to/TEMP_TANNI_m.at(to_kigou);
            to=to-TEMP_TANNI_p.at(to_kigou);
            return to;
        }
};
const map<string,double> TIME_TANNI={{"s",1},{"shake",0.00000001},{"TU",0.001024},{"jiffy_e",1/50},{"jiffy_w",1/60},{"min",60},{"moment",90},{"KOKU",900},{"KOKU_old",864},{"h",60*60},{"d",60*60*24},{"wk",60*60*24*7},{"JUN",60*60*24*10},{"fortnight",60*60*24*14},{"SAKUBO",2551442.27},{"mo",60*60*24*30},{"quarter",7776000},{"semester",10872000.},{"y",31536000.},{"greg",31556952.},{"juli",31557600.},{"year",31558149.764928},{"c",3153600000.}};
class time_unit{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*TIME_TANNI.at(kigou);
            to=to/TIME_TANNI.at(to_kigou);
            return to;
        }
};
const map<string,double> VOLUME_TANNI={{"m3",1},{"L",0.001},{"KOSAJI",0.000005},{"OSAJI",0.000015},{"c",0.00025},{"lambda",0.000000001},{"acft",1233.48183754752},{"drop",0.00000005},{"in3",0.000016387064},{"ft3",0.028316846592},{"yd3",0.764554857984},{"mi3",4168.181825440579584},{"SHOU",0.0018039},{"KOKU",0.18039},{"GOU",0.00018039},{"TO",0.018039},{"SHAKU",0.000018039}};
class volume{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*VOLUME_TANNI.at(kigou);
            to=to/VOLUME_TANNI.at(to_kigou);
            return to;
        }
};
#endif