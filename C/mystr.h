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

#endif