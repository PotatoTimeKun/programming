#ifndef AREA_LENGTH
#define AREA_LENGTH
#include <string>
#include <map>
using namespace std;
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
#endif