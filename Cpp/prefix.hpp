#ifndef PREFIX_LENGTH
#define PREFIX_LENGTH
#include <string>
#include <map>
using namespace std;
const map<string,double> PREFIX={{"nomal",1},{"Y",1000000000000000000000000},{"Z",1000000000000000000000},{"E",1000000000000000000},{"P",1000000000000000},{"T",1000000000000},{"G",1000000000},{"M",1000000},{"k",1000},{"h",100},{"da",10},{"d",0.1},{"c",0.01},{"m",0.001},{"micro",0.000001},{"n",0.000000001},{"p",0.000000000001},{"f",0.000000000000001},{"a",0.000000000000000001},{"z",0.000000000000000000001},{"y",0.000000000000000001}};
class volume{
    public:
        static double change(double from,string kigou,string to_kigou){
            double to;
            to=from*PREFIX.at(kigou);
            to=to/PREFIX.at(to_kigou);
            return to;
        }
};
#endif