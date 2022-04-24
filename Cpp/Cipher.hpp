/**
 * @file Cipher.hpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 暗号を扱うクラスChipherが入っています。
 * 
 */
#ifndef CHIPHER_HPP_INCLUDED
#define CHIPHER_HPP_INCLUDED
#define SCYTALE_LENGTH 500
#include <iostream>
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
class Cipher{
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
            for(int i=0;i<sentence.length();i++){
                try
                {
                    ret[i]=key[abc.find(sentence[i])];
                }
                catch(const std::exception& e)
                {
                    ret[i]=sentence[i];
                }
                
            }
        }
        if(mode[0]=='r'){
            for(int i=0;i<sentence.length();i++){
                try
                {
                    ret[i]=abc[key.find(sentence[i])];
                }
                catch(const std::exception& e)
                {
                    ret[i]=sentence[i];
                }
                
            }
        }
        return ret;
    }
    /**
     * @brief ポリュビオスの暗号表(5*5)を扱います。
     * 5*5の方式ではjとiの暗号が同じ結果になります。そのため、復号結果ではiはiのままjをiとします。
     * 平文ではa-z以外の文字(空白も含む)は除いてください。
     * 暗号文では0と1以外の文字(空白も含む)は除いてください。
     * 
     * @param mode "m":暗号化モード，"r":復号化モード
     * @param sentence 変換する文字列
     * @return string 暗号文または平文
     */
    public:static string polybius_square(string mode,string sentence){
        string ret="";
        if(mode[0]=='m'){
            for(int i=0;i<sentence.length();i++){
                int c=sentence[i]-'a';
                if(c<'j'){
                    ret+=to_string(c/5+1);
                    ret+=to_string(c%5+1);
                }else{
                    c--;
                    ret+=to_string(c/5+1);
                    ret+=to_string(c%5+1);
                }
            }
        }
        if(mode[0]=='r'){
            for(int i=0;i<sentence.length()/2;i++){
                ret+='a'+(5*((int)sentence[2*i]-(int)'0'-1)+((int)sentence[2*i+1]-(int)'0'-1));
                if(ret[i]>='j'){
                    ret[i]+=1;
                }
            }
        }
        return ret;
    }
    /**
     * @brief スキュタレー暗号を扱います。
     * 5列に分けて暗号化します。
     * 言語の仕様上変数の値を配列の要素数の宣言に使用できなかったので、500個(499文字)までに対応させました。
     * Chipher.hppのマクロSCYTALE_LENGTHを書き換えることによって最大文字数を変更できます。
     * SCYTALE_LENGTHは5の倍数にしてください。
     * @param mode "m":暗号化モード，"r":復号化モード
     * @param sentence 変換する文字列
     * @return string 暗号文または平文
     */
    public:static string scytale(string mode,string sentence){
        string ret="";
        int sen_size=sentence.length();
        if(mode[0]=='m'){
            int table[5][int(SCYTALE_LENGTH)/5];
            for(int i=0;i<SCYTALE_LENGTH;i++)table[i%5][i/5]=0;
            for(int i=0;i<sen_size;i++){
                table[i%5][i/5]=sentence[i];
            }
            for(int i=0;i<5;i++){
                for(int j=0;table[i][j]!=0;j++){
                    if(j>=int(SCYTALE_LENGTH)/5)break;
                    ret+=table[i][j];
                }
            }
        }
        if(mode[0]=='r'){
            int table[5][int(SCYTALE_LENGTH)/5];
            for(int i=0;i<SCYTALE_LENGTH;i++)table[i%5][i/5]=0;
            for(int i=0;i<sen_size;i++){
                table[i%5][i/5]=sentence[i];
            }
            int k=0;
            for(int i=0;i<5;i++){
                for(int j=0;table[i][j]!=0;j++){
                    if(j>=int(SCYTALE_LENGTH)/5)break;
                    table[i][j]=sentence[k];
                    k++;
                }
            }
            for(int i=0;i<sen_size;i++){
                ret+=table[i%5][i/5];
            }
        }
        return ret;
    }
};

#endif // CHIPHER_HPP_INCLUDED
