#ifndef INCLUDE_MYSTR
#define INCLUDE_MYSTR
#include <stdio.h>
#include "my_list.h"
#include <stdlib.h>

/**
 * @brief リストで文字列を扱う構造体です。
 * my_list.hを使用しています。
 * lenメンバは文字列の長さをint型で持ちます。
 */
typedef struct charslist
{
    CharList *chars;
    int len;
} string;

/**
 * @brief 空の文字列を作成します。
 * 
 * @return string* 
 */
string *makeStr()
{
    string* ret=(string *)malloc(sizeof(string));
    ret->chars=mkCharList('\0');
    ret->len=0;
    return ret;
}

/**
 * @brief 改行を受け取るまでキーボード入力を受け取ります。
 * 
 * @param str (string*)文字列を代入するリスト
 */
void scanStr(string *str)
{
    delChar(str->chars);
    str->chars=mkCharList('\0');
    while(1){
        char c;
        scanf("%c",&c);
        str->chars->value=c;
        if(c!='\n')break;
    }
    int length=1;
    while (1)
    {
        char c;
        scanf("%c", &c);
        if (c == '\n')
            break;
        addChar(str->chars, c);
        length++;
    }
    str->len=length;
    addChar(str->chars, '\0');
}

/**
 * @brief 文字列を表示します。
 * 
 * @param str (string*)表示するリスト
 */
void printStr(string *str)
{
    int index = 0;
    while (1)
    {
        char c = atChar(str->chars, index++);
        if (c == '\0')
            break;
        printf("%c", c);
    }
}

/**
 * @brief 2つの文字列を足し、新しい文字列を返します。
 * 
 * @param str1 string*
 * @param str2 string*
 * @return string* str1+str2
 */
string* sumStr(string* str1,string* str2){
    string* ret=makeStr();
    int length=0;
    for(int i=0;atChar(str1->chars,i)!='\0';i++){
        addChar(ret->chars,atChar(str1->chars,i));
        length++;
    }
    for(int i=0;atChar(str2->chars,i)!='\0';i++){
        addChar(ret->chars,atChar(str2->chars,i));
        length++;
    }
    if(length!=0)
        delAtChar(ret->chars,0);
    addChar(ret->chars,'\0');
    ret->len=length;
    return ret;
}

/**
 * @brief 2つの文字列を足し、addedに代入します。
 * added+=adding
 * @param added string*
 * @param adding string*
 */
void addStr(string* added,string* adding){
    string* ret=sumStr(added,adding);
    free(added->chars);
    added->chars=ret->chars;
    added->len=ret->len;
    free(ret);
}

/**
 * @brief start~end-1の文字列を取得します。
 * start,endの値が不適切な場合(文字列長を超える、負数値、大小が逆)、空の文字列を返します。
 * 
 * @param str string*
 * @param start 最初のインデックス
 * @param end 最後のインデックス-1
 * @return string* 
 */
string* subStr(string* str,int start,int end){
    string* ret=makeStr();
    if(start>=str->len || end>str->len || start>=end)return ret;
    for(int i=start;i<end;i++){
        addChar(ret->chars,atChar(str->chars,i));
    }
    delAtChar(ret->chars,0);
    addChar(ret->chars,'\0');
    ret->len=end-start;
    return ret;
}

/**
 * @brief charによる文字列をstring*に変換します。
 * 
 * @param str char*(char[])
 * @return string* 
 */
string* charsToStr(char* str){
    string* ret=makeStr();
    for(int i=0;str[i]!='\0';i++){
        addChar(ret->chars,str[i]);
        ret->len++;
    }
    delAtChar(ret->chars,0);
    addChar(ret->chars,'\0');
    return ret;
}

/**
 * @brief stringによる文字列をchar*に変換します。
 * 
 * @param str string*
 * @return char* 
 */
char* strToChars(string* str){
    char* ret=(char*)malloc(sizeof(char));
    for(int i=0;atChar(str->chars,i)!='\0';i++){
        ret[i]=atChar(str->chars,i);
        ret[i+1]='\0';
    }
    return ret;
}

/**
 * @brief 指定したインデックスの文字を取得します。
 * 
 * @param str string*
 * @param index インデックス
 * @return char 
 */
char atStr(string* str,int index){
    if(index<0 || index>=str->len)return '\0';
    return atChar(str->chars,index);
}

/**
 * @brief 指定したインデックスの文字を削除します。
 * 
 * @param str string*
 * @param index インデックス
 * @return char 
 */
char delAtStr(string* str,int index){
    if(index<0 || index>=str->len)return '\0';
    char ret=atChar(str->chars,index);
    delAtChar(str->chars,index);
    str->len--;
    return ret;
}

/**
 * @brief start~end-1の文字を削除します。
 * 
 * @param str string*
 * @param start 最初のインデックス
 * @param end 最後のインデックス-1
 */
void delStr(string* str,int start,int end){
    if(start>=str->len || end>str->len || start>=end)return;
    for(int i=end-1;i>=start;i--){
        delAtChar(str->chars,i);
    }
    str->len-=end-start;
}

#endif