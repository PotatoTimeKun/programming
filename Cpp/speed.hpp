#ifndef SPEED_LENGTH
#define SPEED_LENGTH
#include <string>
#include <map>
using namespace std;
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
#endif