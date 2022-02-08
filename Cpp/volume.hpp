#ifndef VOLUME_LENGTH
#define VOLUME_LENGTH
#include <string>
#include <map>
using namespace std;
const map<string,double> VOLUME_TANNI={{"m3",1},{"L",0.001},{"KOSAJI",0.000005},{"OSAJI",0.000015},{"c",0.00025},{"lambda",0.000000001},{"acft",1233.48183754752},{"drop",0.00000005},{"in3",0.000016387064},{"ft3",0.028316846592},{"yd3",0.764554857984},{"mi3",4168.181825440579584},{"SHOU",0.0018039},{"GOU",0.00018039},{"TO",0.018039},{"SHAKU",0.000180390684}};
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