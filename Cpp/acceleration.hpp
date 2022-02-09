#ifndef INCLUDE_ACC
#define INCLUDE_ACC
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
#endif