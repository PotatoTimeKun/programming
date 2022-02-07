#ifndef INCLUDE_LENGTH
#define INCLUDE_LENGTH
#include <string>
#include <map>
using namespace std;
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
#endif