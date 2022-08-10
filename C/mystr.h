#ifndef INCLUDE_MYSTR
#define INCLUDE_MYSTR
#include <stdio.h>
#include "my_list.h"
#include <stdlib.h>
#include <stdarg.h>

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
    string *ret = (string *)malloc(sizeof(string));
    ret->chars = mkCharList('\0');
    ret->len = 0;
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
    str->chars = mkCharList('\0');
    while (1)
    {
        char c;
        scanf("%c", &c);
        str->chars->value = c;
        if (c != '\n')
            break;
    }
    int length = 1;
    while (1)
    {
        char c;
        scanf("%c", &c);
        if (c == '\n')
            break;
        addChar(str->chars, c);
        length++;
    }
    str->len = length;
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
string *sumStr(string *str1, string *str2)
{
    string *ret = makeStr();
    int length = 0;
    for (int i = 0; atChar(str1->chars, i) != '\0'; i++)
    {
        addChar(ret->chars, atChar(str1->chars, i));
        length++;
    }
    for (int i = 0; atChar(str2->chars, i) != '\0'; i++)
    {
        addChar(ret->chars, atChar(str2->chars, i));
        length++;
    }
    if (length != 0)
        delAtChar(ret->chars, 0);
    addChar(ret->chars, '\0');
    ret->len = length;
    return ret;
}

/**
 * @brief 2つの文字列を足し、addedに代入します。
 * added+=adding
 * @param added string*
 * @param adding string*
 */
void addStr(string *added, string *adding)
{
    string *ret = sumStr(added, adding);
    free(added->chars);
    added->chars = ret->chars;
    added->len = ret->len;
    free(ret);
}

/**
 * @brief 指定したインデックスに文字列を挿入します。
 * added(0~index-1)+adding+added(index~adding->len)
 *
 * @param added string*
 * @param adding string*
 * @param index int
*/
void addAtStr(string* added,string* adding,int index){
    for(int i=0;i<adding->len;i++){
        addAtChar(added->chars,atChar(adding->chars,i),index++);
        added->len++;
    }
}

/**
 * @brief 文字列の最後に文字を追加します。
 *
 * @param added
 * @param adding
 */
void addStrC(string *added, char adding)
{
    addChar(added->chars, adding);
    delAtChar(added->chars, added->len);
    addChar(added->chars, '\0');
    added->len++;
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
string *subStr(string *str, int start, int end)
{
    string *ret = makeStr();
    if (start >= str->len || end > str->len || start >= end)
        return ret;
    for (int i = start; i < end; i++)
    {
        addChar(ret->chars, atChar(str->chars, i));
    }
    delAtChar(ret->chars, 0);
    addChar(ret->chars, '\0');
    ret->len = end - start;
    return ret;
}

/**
 * @brief charによる文字列をstring*に変換します。
 *
 * @param str char*(char[])
 * @return string*
 */
string *charsToStr(char *str)
{
    string *ret = makeStr();
    for (int i = 0; str[i] != '\0'; i++)
    {
        addChar(ret->chars, str[i]);
        ret->len++;
    }
    delAtChar(ret->chars, 0);
    addChar(ret->chars, '\0');
    return ret;
}

/**
 * @brief stringによる文字列をchar*に変換します。
 *
 * @param str string*
 * @return char*
 */
char *strToChars(string *str)
{
    char *ret = (char *)malloc(sizeof(char));
    for (int i = 0; atChar(str->chars, i) != '\0'; i++)
    {
        ret[i] = atChar(str->chars, i);
        ret[i + 1] = '\0';
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
char atStr(string *str, int index)
{
    if (index < 0 || index >= str->len)
        return '\0';
    return atChar(str->chars, index);
}

/**
 * @brief 指定したインデックスの文字を削除します。
 *
 * @param str string*
 * @param index インデックス
 * @return char
 */
char delAtStr(string *str, int index)
{
    if (index < 0 || index >= str->len)
        return '\0';
    char ret = atChar(str->chars, index);
    delAtChar(str->chars, index);
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
void delStr(string *str, int start, int end)
{
    if (start >= str->len || end > str->len || start >= end)
        return;
    for (int i = end - 1; i >= start; i--)
    {
        delAtChar(str->chars, i);
    }
    str->len -= end - start;
}

/**
 * @brief ホワイトスペースがでるまでキーボード入力を受け取ります。
 * scanfでいう%sです。
 *
 * @param str string* 文字列を入れるリスト
 */
void scanStrPs(string *str)
{
    delChar(str->chars);
    str->chars = mkCharList('\0');
    while (1)
    { // 最低でも1文字目が入るまでループ
        char c;
        scanf("%c", &c);
        str->chars->value = c;
        if (c > 0x20)
            break;
    }
    int length = 1;
    while (1)
    { // ホワイトスペースがでるまでループ
        char c;
        scanf("%c", &c);
        if (c <= 0x20)
            break;
        addChar(str->chars, c);
        length++;
    }
    str->len = length;
    addChar(str->chars, '\0');
}

/**
 * @brief string*をintに変換します。
 * +,-,0~9以外の文字があっても動きますが、おすすめはしません。
 *
 * @param str string*
 * @return int
 */
int strToInt(string *str)
{
    int ret = 0, start = 0, sign = 1;
    if (atChar(str->chars, 0) == '-')
    {
        sign = -1;
        start++;
    }
    if (atChar(str->chars, 0) == '+')
        start++;
    for (int i = start; i < str->len; i++)
    {
        ret *= 10;
        ret += atChar(str->chars, i) - '0';
    }
    return ret * sign;
}

/**
 * @brief string*をlong longに変換します。
 * +,-,0~9以外の文字があっても動きますが、おすすめはしません。
 *
 * @param str string*
 * @return long long
 */
long long strToLong(string *str)
{
    long long ret = 0, start = 0, sign = 1;
    if (atChar(str->chars, 0) == '-')
    {
        sign = -1;
        start++;
    }
    if (atChar(str->chars, 0) == '+')
        start++;
    for (int i = start; i < str->len; i++)
    {
        ret *= 10;
        ret += atChar(str->chars, i) - '0';
    }
    return ret * sign;
}

/**
 * @brief string*をfloatに変換します。
 * +,-,.,0~9以外の文字があっても動きますが、おすすめはしません。
 *
 * @param str string*
 * @return float
 */
float strToFloat(string *str)
{
    float ret = 0, start = 0, sign = 1;
    int point = str->len;
    if (atChar(str->chars, 0) == '-')
    {
        sign = -1;
        start++;
    }
    if (atChar(str->chars, 0) == '+')
        start++;
    for (int i = start; i < str->len; i++)
    {
        ret *= 10;
        int c = atChar(str->chars, i);
        if (c == '.')
        {
            point = i;
            ret /= 10;
            continue;
        }
        ret += c - '0';
    }
    for (int i = 0; i < str->len - point - 1; i++)
        ret /= 10;
    return ret * sign;
}

/**
 * @brief string*をdoubleに変換します。
 * +,-,.,0~9以外の文字があっても動きますが、おすすめはしません。
 *
 * @param str string*
 * @return double
 */
double strToDouble(string *str)
{
    double ret = 0, start = 0, sign = 1;
    int point = str->len;
    if (atChar(str->chars, 0) == '-')
    {
        sign = -1;
        start++;
    }
    if (atChar(str->chars, 0) == '+')
        start++;
    for (int i = start; i < str->len; i++)
    {
        ret *= 10;
        int c = atChar(str->chars, i);
        if (c == '.')
        {
            point = i;
            ret /= 10;
            continue;
        }
        ret += c - '0';
    }
    for (int i = 0; i < str->len - point - 1; i++)
        ret /= 10;
    return ret * sign;
}

/**
 * @brief 文字列中で一致する場所を探し、最初のインデックスを返します。
 *
 * @param str string* 探される文字列
 * @param searched string* 探す文字列
 * @return int
 */
int indexStr(string *str, string *searched)
{
    if (searched->len > str->len)
        return -1;
    for (int i = 0; i < str->len - searched->len + 1; i++)
    {
        int matched = 1;
        for (int j = 0; j < searched->len; j++)
        {
            if (atChar(str->chars, i + j) != atChar(searched->chars, j))
            {
                matched = 0;
                break;
            }
        }
        if (matched)
            return i;
    }
    return -1;
}

/**
 * @brief 文字列中で一致する場所を探し、最初のインデックスを返します。
 *
 * @param str string* 探される文字列
 * @param searched char* 探す文字列
 * @return int
 */
int indexStrC(string *str, char *searched)
{
    return indexStr(str, charsToStr(searched));
}

/**
 * @brief printf関数のように、%Sをstringの値に書き換えて表示します。
 *
 * @param arg char*
 * @param ... string*
 */
void printfStr(char *arg, ...)
{
    va_list lis;
    va_start(lis, arg);
    string *str = charsToStr(arg);
    string *per = charsToStr("%S");
    while (indexStr(str, per) != -1)
    {
        printStr(subStr(str, 0, indexStr(str, per)));
        printStr(va_arg(lis, string *));
        str = subStr(str, indexStr(str, per) + 2, str->len);
    }
    printStr(str);
    va_end(lis);
}

/**
 * @brief printf関数の形式で文字列を表示します。
 * string*型は%Sで変換可能です。
 *
 * @param arg char*
 * @param ... 各変換指定子に対応した型
 */
void printfs(char *arg, ...)
{
    va_list lis;
    va_start(lis, arg);
    string *str = charsToStr(arg);
    string *per;
    while (1)
    {
        per = makeStr();
        while (atStr(str, 0) != '%')
        {
            if (str->len == 0)
                break;
            printf("%c", delAtStr(str, 0));
        }
        if (str->len == 0)
            break;
        addStrC(per, delAtStr(str, 0));
        while (atStr(str, 0) < 'A')
            addStrC(per, delAtStr(str, 0));
        char c = delAtStr(str, 0);
        addStrC(per, c);
        if (c != 'l')
        {
            switch (c)
            {
            case 'c':
                printf(strToChars(per), va_arg(lis, int));
                break;
            case 's':
                printf(strToChars(per), va_arg(lis, char *));
                break;
            case 'd':
                printf(strToChars(per), va_arg(lis, int));
                break;
            case 'u':
                printf(strToChars(per), va_arg(lis, int));
                break;
            case 'o':
                printf(strToChars(per), va_arg(lis, int));
                break;
            case 'x':
                printf(strToChars(per), va_arg(lis, int));
                break;
            case 'f':
                printf(strToChars(per), va_arg(lis, double));
                break;
            case 'e':
                printf(strToChars(per), va_arg(lis, double));
                break;
            case 'g':
                printf(strToChars(per), va_arg(lis, double));
                break;
            case 'S':
                printStr(va_arg(lis, string *));
                break;
            }
        }
        else
        {
            c = delAtStr(str, 0);
            addStrC(per, c);
            switch (c)
            {
            case 'd':
                printf(strToChars(per), va_arg(lis, long));
                break;
            case 'u':
                printf(strToChars(per), va_arg(lis, long));
                break;
            case 'o':
                printf(strToChars(per), va_arg(lis, long));
                break;
            case 'x':
                printf(strToChars(per), va_arg(lis, long));
                break;
            case 'f':
                printf(strToChars(per), va_arg(lis, double));
                break;
            }
        }
    }
    va_end(lis);
}

/**
 * @brief 渡された文字列を逆順にします。
 *
 * @param str string*
 */
void reverseStr(string* str){
    for(int i=0;i<(str->len)/2;i++){
        char swap=atChar(str->chars,i);
        setChar(str->chars,atChar(str->chars,str->len-1-i),i);
        setChar(str->chars,swap,str->len-1-i);
    }
}

/**
 * @brief 指定したインデックスの値を書き換えます。
 *
 * @param str string*
 * @param value char
 * @param index int
 */
void setStr(string* str,char value,int index){
    if(index>=0 && index<str->len){
        setChar(str->chars,value,index);
    }
}

/**
 * @brief 文字列の中身の値をコピーした文字列を作成します。
 * コピー元とコピー先のアドレスは干渉しません。
 * 
 * @param str string*
 * @return string* 
 */
string* copyStr(string* str){
    string* ret=makeStr();
    for(int i=0;i<str->len;i++){
        addChar(ret->chars,atChar(str->len,i));
    }
    delAtChar(ret->chars,0);
    addChar(ret->chars,'\0');
    ret->len=str->len;
    return ret;
}

#endif
