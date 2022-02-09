#ifndef INCLUDE_TIMEUNIT
#define INCLUDE_TIMEUNIT
#include <string>
#include <map>
using namespace std;
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
#endif