#ifndef CHIPHER_HPP_INCLUDED
#define CHIPHER_HPP_INCLUDED
#include <algorithm>
#include <cctype>
#include <string>
using namespace std;
class Chipher{
    public:static string ceaser(string mode,string sentence,int shift){
        string ret(sentence);
        for(int i=0;i<sentence.length();i++)sentence[i]=tolower(sentence[i]);
        if(mode[0]=='m'){
            if(shift<0)return ceaser("r",sentence,-shift);
            for(int i=0;i<sentence.length();i++){
                if(sentence[i]>='A' && sentence[i]<='z')ret[i]='a'+(sentence[i]-'a'+shift)%26;
                else ret[i]=sentence[i];
            }
        }
        if(mode[0]=='r'){
            if(shift<0)return ceaser("m",sentence,-shift);
            for(int i=0;i<sentence.length();i++){
                if(sentence[i]>='a' && sentence[i]<='z'){
                        int p=((int)sentence[i]-(int)'a'+shift)%26;
                        if(p<0)p+=26;
                        ret[i]='a'+p;
                }
                else ret[i]=sentence[i];
            }
        }
        return ret;
    };
    public:static string vigenere(string mode,string sentence,string key){
        string ret(sentence);
        int i_k=0,sl=sentence.length(),kl=key.length();
        for(int i=0;i<sl;i++)sentence[i]=tolower(sentence[i]);
        for(int i=0;i<kl;i++)key[i]=tolower(key[i]);
        if(mode[0]=='m'){
            for(int i=0;i<sentence.length();i++){
                if(sentence[i]>='a' && sentence[i]<='z'){
                    ret[i]='A'+(sentence[i]+key[i_k]-2*'a')%26;
                    i_k++;
                }else{ret[i]=sentence[i];}
                if(i_k>=key.length())i_k=0;
            }
        }
        if(mode[0]=='r'){
            for(int i=0;i<sentence.length();i++){
                if(sentence[i]>='a' && sentence[i]<='z'){
                    int p=((int)sentence[i]-(int)key[i_k])%26;
                    if(p<0)p+=26;
                    ret[i]='a'+p;
                    i_k++;
                }else{ret[i]=sentence[i];}
                if(i_k>=key.length())i_k=0;
            }
        }
        return ret;
    };
    public:static string substitution(string mode,string sentence,string key){
        string abc="abcdefghijklmnopqrstuvwxyz";
        string ret(sentence);
        if(mode[0]=='m'){
            for(int i=0;i<sentence.length();i++)ret[i]=key[abc.find(sentence[i])];
        }
        if(mode[0]=='r'){
            for(int i=0;i<sentence.length();i++)ret[i]=abc[key.find(sentence[i])];
        }
        return ret;
    }
};

#endif // CHIPHER_HPP_INCLUDED
