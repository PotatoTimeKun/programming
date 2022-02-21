/**
 * @file Chipher.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 暗号を扱うクラスChipherが入っています。
 * 
 */
#ifndef CHIPHER_HPP_INCLUDED
#define CHIPHER_HPP_INCLUDED
#include <algorithm>
#include <cctype>
#include <string>
using namespace std;
/**
 * 暗号を扱うstaticな関数が入っています。
 * 関数一覧
 * string ceaser(string mode,string sentence,int shift)
 * string vigenere(string mode,string sentence,string key)
 * string substitution(string mode,string sentence,string key)
 */
class Chipher{
    /**
     * シーザー暗号を扱います。
     * 
     * @param mode "m":暗号化モード，"r":復号化モード
     * @param sentence 変換する文字列
     * @param shift シフトする数
     * @return string 暗号文または平文
     */
    public:static string ceaser(string mode,string sentence,int shift){
        string ret(sentence);
        for(int i=0;i<sentence.length();i++)sentence[i]=tolower(sentence[i]);
        if(mode[0]=='m'){
            if(shift<0)return ceaser("r",sentence,-shift);
            for(int i=0;i<sentence.length();i++){
                if(sentence[i]>='a' && sentence[i]<='z')ret[i]='A'+(sentence[i]-'a'+shift)%26;
                else ret[i]=sentence[i];
            }
        }
        if(mode[0]=='r'){
            if(shift<0)return ceaser("m",sentence,-shift);
            for(int i=0;i<sentence.length();i++){
                if(sentence[i]>='a' && sentence[i]<='z'){
                        int p=((int)sentence[i]-(int)'a'-shift)%26;
                        if(p<0)p+=26;
                        ret[i]='a'+p;
                }
                else ret[i]=sentence[i];
            }
        }
        return ret;
    };
    /**
     * ヴィジュネル暗号を扱います。
     * 
     * @param mode "m":暗号化モード，"r":復号化モード
     * @param sentence 変換する文字列
     * @param key 鍵
     * @return string 暗号文または平文
     */
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
    /**
     * 単一換字式暗号を扱います。
     * 
     * @param mode "m":暗号化モード，"r":復号化モード
     * @param sentence 変換する文字列
     * @param key 鍵(a-zに対応した文字列)
     * @return string 暗号文または平文
     */
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
