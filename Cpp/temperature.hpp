#ifndef INCLUDE_TEMPERATURE
#define INCLUDE_TEMPERATURE
#include <string>
#include <map>
using namespace std;
const map<string,double> TEMP_TANNI_p={{"K",0},{"C",237.15},{"F",459.67},{"Ra",0}};
const map<string,double> TEMP_TANNI_m={{"K",1},{"C",1},{"F",5/9},{"Ra",5/9}};
class temperature{
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
#endif
