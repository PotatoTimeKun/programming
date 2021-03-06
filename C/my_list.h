#ifndef INCLUDE_MYLIST
#define INCLUDE_MYLIST
#include <stdio.h>
#include <stdlib.h>
typedef struct mylist_0
{
    int value;
    struct mylist_0 *next;
} IntList;

/**
 * @brief 末尾に要素を追加します。
 * 
 * @param lis 要素を入れるリスト
 * @param val 追加する値
 */
void addInt(IntList *lis, int val)
{
    IntList *newInt = (IntList *)malloc(sizeof(IntList));
    newInt->value = val;
    newInt->next = NULL;
    IntList *index = lis;
    while (index->next != NULL)
        index = index->next;
    index->next = newInt;
}

/**
 * @brief 指定したインデックスに要素を追加します。
 * 指定したインデックス以降の要素はインデックスが1つずれます。
 * 
 * @param lis 要素を入れるリスト
 * @param val 追加する値
 * @param list_index 追加する要素のインデックス
 */
void addAtInt(IntList *lis, int val, int list_index)
{
    IntList *newInt = (IntList *)malloc(sizeof(IntList));
    newInt->value = val;
    IntList *index_for = lis;
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return;
        index_for = index_for->next;
    }
    IntList *index_back = index_for->next;
    index_for->next = newInt;
    newInt->next = index_back;
}

/**
 * @brief 新しいリストを作ります。
 * 一応使ったらプログラム終了時等でdelInt関数でメモリを解放させる方がいいかもしれないです。
 * 
 * @param val 初期化の値(インデックス0に入る値)
 * @return リスト
 */
IntList *mkIntList(int val)
{
    IntList *newInt = (IntList *)malloc(sizeof(IntList));
    newInt->value = val;
    newInt->next = NULL;
    return newInt;
}

/**
 * @brief 指定したインデックスの値を取り出します。
 * 関数の実行による要素の変更、削除等はないです。
 * 存在しないインデックスでは、
 * -2147483648
 * を返します。
 * 
 * @param lis リスト
 * @param list_index 指定するインデックス
 * @return 指定した要素の値
 */
int atInt(IntList *lis, int list_index)
{
    IntList *index = lis;
    for (int i = 0; i < list_index; i++)
    {
        if (index == NULL)
            return -2147483648;
        index = index->next;
    }
    return index->value;
}

/**
 * @brief 指定したインデックスの値を削除し、その値を返します。
 * 存在しないインデックスでは、
 * -2147483648
 * を返します。
 * 
 * @param lis リスト
 * @param list_index 指定するインデックス
 * @return 削除された要素の値
 */
int delAtInt(IntList *lis, int list_index)
{
    IntList *index_for = lis;
    if(list_index==0){
        index_for=lis->next;
        if(index_for==NULL)return 0;
        int ret=lis->value;
        lis->value=index_for->value;
        lis->next=index_for->next;
        free(index_for);
        return ret;
    }
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return -2147483648;
        index_for = index_for->next;
    }
    IntList *index = index_for->next;
    if (index == NULL)
        return -2147483648;
    index_for->next = index->next;
    int ret = index->value;
    free(index);
    return ret;
}

/**
 * @brief 全ての要素をメモリから解放します。
 * (つまり指定したリストを削除します。)
 * 
 * @param lis 
 */
void delInt(IntList *lis)
{
    IntList *index = lis;
    while (lis->next != NULL)
    {
        index = lis->next;
        lis->next = index->next;
        free(index);
    }
    free(lis);
}

/* IntListデバッグ用
void _printall(IntList *lis)
{
    IntList *index = lis;
    int i = 0;
    while (index->next != NULL)
    {
        printf("[%d]:%d ", i, index->value);
        index = index->next;
        i++;
    }
    printf("[%d]:%d\n", i, index->value);
}
*/

typedef struct mylist_1
{
    long long value;
    struct mylist_1 *next;
} LongList;

/**
 * @brief 末尾に要素を追加します。
 * 
 * @param lis 要素を入れるリスト
 * @param val 追加する値
 */
void addLong(LongList *lis, long long val)
{
    LongList *newLong = (LongList *)malloc(sizeof(LongList));
    newLong->value = val;
    newLong->next = NULL;
    LongList *index = lis;
    while (index->next != NULL)
        index = index->next;
    index->next = newLong;
}

/**
 * @brief 指定したインデックスに要素を追加します。
 * 指定したインデックス以降の要素はインデックスが1つずれます。
 * 
 * @param lis 要素を入れるリスト
 * @param val 追加する値
 * @param list_index 追加する要素のインデックス
 */
void addAtLong(LongList *lis, long long val, int list_index)
{
    LongList *newLong = (LongList *)malloc(sizeof(LongList));
    newLong->value = val;
    LongList *index_for = lis;
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return;
        index_for = index_for->next;
    }
    LongList *index_back = index_for->next;
    index_for->next = newLong;
    newLong->next = index_back;
}

/**
 * @brief 新しいリストを作ります。
 * 一応使ったらプログラム終了時等でdelLong関数でメモリを解放させる方がいいかもしれないです。
 * 
 * @param val 初期化の値(インデックス0に入る値)
 * @return リスト
 */
LongList *mkLongList(int val)
{
    LongList *newLong = (LongList *)malloc(sizeof(LongList));
    newLong->value = val;
    newLong->next = NULL;
    return newLong;
}

/**
 * @brief 指定したインデックスの値を取り出します。
 * 関数の実行による要素の変更、削除等はないです。
 * 存在しないインデックスでは、
 * -9223372036854775807
 * を返します。
 * 
 * @param lis リスト
 * @param list_index 指定するインデックス
 * @return 指定した要素の値
 */
long long atLong(LongList *lis, int list_index)
{
    LongList *index = lis;
    for (int i = 0; i < list_index; i++)
    {
        if (index == NULL)
            return -9223372036854775807;
        index = index->next;
    }
    return index->value;
}

/**
 * @brief 指定したインデックスの値を削除し、その値を返します。
 * 存在しないインデックスでは、
 * -9223372036854775807
 * を返します。
 * 
 * @param lis リスト
 * @param list_index 指定するインデックス
 * @return 削除された要素の値
 */
long long delAtLong(LongList *lis, int list_index)
{
    LongList *index_for = lis;
    if(list_index==0){
        index_for=lis->next;
        if(index_for==NULL)return 0;
        long long ret=lis->value;
        lis->value=index_for->value;
        lis->next=index_for->next;
        free(index_for);
        return ret;
    }
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return -9223372036854775807;
        index_for = index_for->next;
    }
    LongList *index = index_for->next;
    if (index == NULL)
        return -9223372036854775807;
    index_for->next = index->next;
    long long ret = index->value;
    free(index);
    return ret;
}

/**
 * @brief 全ての要素をメモリから解放します。
 * (つまり指定したリストを削除します。)
 * 
 * @param lis 
 */
void delLong(LongList *lis)
{
    LongList *index = lis;
    while (lis->next != NULL)
    {
        index = lis->next;
        lis->next = index->next;
        free(index);
    }
    free(lis);
}

typedef struct mylist_2
{
    char value;
    struct mylist_2 *next;
} CharList;

/**
 * @brief 末尾に要素を追加します。
 * 
 * @param lis 要素を入れるリスト
 * @param val 追加する値
 */
void addChar(CharList *lis, char val)
{
    CharList *newChar = (CharList *)malloc(sizeof(CharList));
    newChar->value = val;
    newChar->next = NULL;
    CharList *index = lis;
    while (index->next != NULL)
        index = index->next;
    index->next = newChar;
}

/**
 * @brief 指定したインデックスに要素を追加します。
 * 指定したインデックス以降の要素はインデックスが1つずれます。
 * 
 * @param lis 要素を入れるリスト
 * @param val 追加する値
 * @param list_index 追加する要素のインデックス
 */
void addAtChar(CharList *lis, char val, int list_index)
{
    CharList *newChar = (CharList *)malloc(sizeof(CharList));
    newChar->value = val;
    CharList *index_for = lis;
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return;
        index_for = index_for->next;
    }
    CharList *index_back = index_for->next;
    index_for->next = newChar;
    newChar->next = index_back;
}

/**
 * @brief 新しいリストを作ります。
 * 一応使ったらプログラム終了時等でdelChar関数でメモリを解放させる方がいいかもしれないです。
 * 
 * @param val 初期化の値(インデックス0に入る値)
 * @return リスト
 */
CharList *mkCharList(char val)
{
    CharList *newChar = (CharList *)malloc(sizeof(CharList));
    newChar->value = val;
    newChar->next = NULL;
    return newChar;
}

/**
 * @brief 指定したインデックスの値を取り出します。
 * 関数の実行による要素の変更、削除等はないです。
 * 存在しないインデックスでは、
 * 0
 * を返します。
 * 
 * @param lis リスト
 * @param list_index 指定するインデックス
 * @return 指定した要素の値
 */
char atChar(CharList *lis, int list_index)
{
    CharList *index = lis;
    for (int i = 0; i < list_index; i++)
    {
        if (index == NULL)
            return 0;
        index = index->next;
    }
    return index->value;
}

/**
 * @brief 指定したインデックスの値を削除し、その値を返します。
 * 存在しないインデックスでは、
 * 0
 * を返します。
 * 
 * @param lis リスト
 * @param list_index 指定するインデックス
 * @return 削除された要素の値
 */
char delAtChar(CharList *lis, int list_index)
{
    CharList *index_for = lis;
    if(list_index==0){
        index_for=lis->next;
        if(index_for==NULL)return 0;
        char ret=lis->value;
        lis->value=index_for->value;
        lis->next=index_for->next;
        free(index_for);
        return ret;
    }
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return 0;
        index_for = index_for->next;
    }
    CharList *index = index_for->next;
    if (index == NULL)
        return 0;
    index_for->next = index->next;
    char ret = index->value;
    free(index);
    return ret;
}

/**
 * @brief 全ての要素をメモリから解放します。
 * (つまり指定したリストを削除します。)
 * 
 * @param lis 
 */
void delChar(CharList *lis)
{
    CharList *index = lis;
    while (lis->next != NULL)
    {
        index = lis->next;
        lis->next = index->next;
        free(index);
    }
    free(lis);
}

typedef struct mylist_3
{
    float value;
    struct mylist_3 *next;
} FloatList;

/**
 * @brief 末尾に要素を追加します。
 * 
 * @param lis 要素を入れるリスト
 * @param val 追加する値
 */
void addFloat(FloatList *lis, float val)
{
    FloatList *newFloat = (FloatList *)malloc(sizeof(FloatList));
    newFloat->value = val;
    newFloat->next = NULL;
    FloatList *index = lis;
    while (index->next != NULL)
        index = index->next;
    index->next = newFloat;
}

/**
 * @brief 指定したインデックスに要素を追加します。
 * 指定したインデックス以降の要素はインデックスが1つずれます。
 * 
 * @param lis 要素を入れるリスト
 * @param val 追加する値
 * @param list_index 追加する要素のインデックス
 */
void addAtFloat(FloatList *lis, float val, int list_index)
{
    FloatList *newFloat = (FloatList *)malloc(sizeof(FloatList));
    newFloat->value = val;
    FloatList *index_for = lis;
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return;
        index_for = index_for->next;
    }
    FloatList *index_back = index_for->next;
    index_for->next = newFloat;
    newFloat->next = index_back;
}

/**
 * @brief 新しいリストを作ります。
 * 一応使ったらプログラム終了時等でdelFloat関数でメモリを解放させる方がいいかもしれないです。
 * 
 * @param val 初期化の値(インデックス0に入る値)
 * @return リスト
 */
FloatList *mkFloatList(float val)
{
    FloatList *newFloat = (FloatList *)malloc(sizeof(FloatList));
    newFloat->value = val;
    newFloat->next = NULL;
    return newFloat;
}

/**
 * @brief 指定したインデックスの値を取り出します。
 * 関数の実行による要素の変更、削除等はないです。
 * 存在しないインデックスでは、
 * -3.402823e+38
 * を返します。
 * 
 * @param lis リスト
 * @param list_index 指定するインデックス
 * @return 指定した要素の値
 */
float atFloat(FloatList *lis, int list_index)
{
    FloatList *index = lis;
    for (int i = 0; i < list_index; i++)
    {
        if (index == NULL)
            return -3.402823e+38;
        index = index->next;
    }
    return index->value;
}

/**
 * @brief 指定したインデックスの値を削除し、その値を返します。
 * 存在しないインデックスでは、
 * -3.402823e+38
 * を返します。
 * 
 * @param lis リスト
 * @param list_index 指定するインデックス
 * @return 削除された要素の値
 */
float delAtFloat(FloatList *lis, int list_index)
{
    FloatList *index_for = lis;
    if(list_index==0){
        index_for=lis->next;
        if(index_for==NULL)return 0;
        float ret=lis->value;
        lis->value=index_for->value;
        lis->next=index_for->next;
        free(index_for);
        return ret;
    }
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return -3.402823e+38;
        index_for = index_for->next;
    }
    FloatList *index = index_for->next;
    if (index == NULL)
        return -3.402823e+38;
    index_for->next = index->next;
    float ret = index->value;
    free(index);
    return ret;
}

/**
 * @brief 全ての要素をメモリから解放します。
 * (つまり指定したリストを削除します。)
 * 
 * @param lis 
 */
void delFloat(FloatList *lis)
{
    FloatList *index = lis;
    while (lis->next != NULL)
    {
        index = lis->next;
        lis->next = index->next;
        free(index);
    }
    free(lis);
}

typedef struct mylist_4
{
    double value;
    struct mylist_4 *next;
} DoubleList;

/**
 * @brief 末尾に要素を追加します。
 * 
 * @param lis 要素を入れるリスト
 * @param val 追加する値
 */
void addDouble(DoubleList *lis, double val)
{
    DoubleList *newDouble = (DoubleList *)malloc(sizeof(DoubleList));
    newDouble->value = val;
    newDouble->next = NULL;
    DoubleList *index = lis;
    while (index->next != NULL)
        index = index->next;
    index->next = newDouble;
}

/**
 * @brief 指定したインデックスに要素を追加します。
 * 指定したインデックス以降の要素はインデックスが1つずれます。
 * 
 * @param lis 要素を入れるリスト
 * @param val 追加する値
 * @param list_index 追加する要素のインデックス
 */
void addAtDouble(DoubleList *lis, double val, int list_index)
{
    DoubleList *newDouble = (DoubleList *)malloc(sizeof(DoubleList));
    newDouble->value = val;
    DoubleList *index_for = lis;
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return;
        index_for = index_for->next;
    }
    DoubleList *index_back = index_for->next;
    index_for->next = newDouble;
    newDouble->next = index_back;
}

/**
 * @brief 新しいリストを作ります。
 * 一応使ったらプログラム終了時等でdelDouble関数でメモリを解放させる方がいいかもしれないです。
 * 
 * @param val 初期化の値(インデックス0に入る値)
 * @return リスト
 */
DoubleList *mkDoubleList(double val)
{
    DoubleList *newDouble = (DoubleList *)malloc(sizeof(DoubleList));
    newDouble->value = val;
    newDouble->next = NULL;
    return newDouble;
}

/**
 * @brief 指定したインデックスの値を取り出します。
 * 関数の実行による要素の変更、削除等はないです。
 * 存在しないインデックスでは、
 * -1.797693e+308
 * を返します。
 * 
 * @param lis リスト
 * @param list_index 指定するインデックス
 * @return 指定した要素の値
 */
double atDouble(DoubleList *lis, int list_index)
{
    DoubleList *index = lis;
    for (int i = 0; i < list_index; i++)
    {
        if (index == NULL)
            return -1.797693e+308;
        index = index->next;
    }
    return index->value;
}

/**
 * @brief 指定したインデックスの値を削除し、その値を返します。
 * 存在しないインデックスでは、
 * -1.797693e+308
 * を返します。
 * 
 * @param lis リスト
 * @param list_index 指定するインデックス
 * @return 削除された要素の値
 */
double delAtDouble(DoubleList *lis, int list_index)
{
    DoubleList *index_for = lis;
    if(list_index==0){
        index_for=lis->next;
        if(index_for==NULL)return 0;
        double ret=lis->value;
        lis->value=index_for->value;
        lis->next=index_for->next;
        free(index_for);
        return ret;
    }
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return -1.797693e+308;
        index_for = index_for->next;
    }
    DoubleList *index = index_for->next;
    if (index == NULL)
        return -1.797693e+308;
    index_for->next = index->next;
    double ret = index->value;
    free(index);
    return ret;
}

/**
 * @brief 全ての要素をメモリから解放します。
 * (つまり指定したリストを削除します。)
 * 
 * @param lis 
 */
void delDouble(DoubleList *lis)
{
    DoubleList *index = lis;
    while (lis->next != NULL)
    {
        index = lis->next;
        lis->next = index->next;
        free(index);
    }
    free(lis);
}


#endif // INCLUDE_MYLIST
