#ifndef INCLUDE_MASS
#define INCLUDE_MASS
#include <string>
#include <map>
using namespace std;
const map<string,double> MASS_TANNI={{"g",1},{"kg",1000},{"t",1000000},{"gamma",0.000001},{"kt",0.2},{"oz",28.349523125},{"lb",0.00045359237},{"q",100000},{"mom",3.75},{"KAN",0.00375},{"RYOU",37.5},{"KIN",600}};
class mass{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*MASS_TANNI.at(kigou);
            to=to/MASS_TANNI.at(to_kigou);
            return to;
        }
};
#endif