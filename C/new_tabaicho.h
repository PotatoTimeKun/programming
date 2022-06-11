// This is writed using shift-jis
/**
 * @file new_tabaicho.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 
 * リストによって多倍長整数を扱います。
 * 多倍長整数はmkList関数によって返されたTabaicho*型の変数を使用します。
 * (多倍長整数間の)四則演算を行う関数はそれぞれsum,sub,mul,diviです。
 * inputTabaicho関数はキーボード入力によって得た多倍長整数を返します。
 * showTabaicho関数は引数の多倍長整数を表示します。
 * cmp関数は引数の多倍長整数同士の大きさを比較します。
 * この関数のテストはtabaicho.cで行えます。
 * 
 * @date 2022-06-11
 * 
 * @copyright Copyright (c) 2022 PotatoTimeKun
 * 
 */
#ifndef INCLUDE_NEW_TABAICHO
#define INCLUDE_NEW_TABAICHO
#include <stdlib.h>
#include <stdio.h>

/**
 * @brief 先頭以外はこの型を使う、要素の値と次要素へのポインタのみをもつ
 *
 */
typedef struct mylist_0
{
    int value;             // 要素の値
    struct mylist_0 *next; //次の要素
} Tabaicho_child;

/**
 * @brief 多倍長整数を扱う、先頭のみこの型を使う
 *
 */
typedef struct mylist_1
{
    int len;               // 多倍長整数の長さ(リストの長さ)
    int value;             // 先頭の値
    int minus;             // 値が負なら1を入れる
    struct mylist_0 *next; //次の要素
} Tabaicho;

/**
 * @brief リストの末尾に要素を追加します
 *
 * @param lis 多倍長整数
 * @param val 要素の値
 */
void add(Tabaicho *lis, int val)
{
    Tabaicho_child *newchild = (Tabaicho_child *)malloc(sizeof(Tabaicho_child));
    newchild->value = val;
    newchild->next = NULL;
    Tabaicho_child *index = lis->next;
    if (index == NULL)
    {
        lis->next = newchild;
        lis->len++;
        return;
    }
    while (index->next != NULL)
        index = index->next;
    index->next = newchild;
    lis->len++;
}

/**
 * @brief 指定したインデックスに要素を追加します
 *
 * @param lis 多倍長整数
 * @param val 値
 * @param list_index インデックス
 */
void addAt(Tabaicho *lis, int val, int list_index)
{
    if (lis->len == list_index)
    {
        add(lis, val);
        return;
    }
    Tabaicho_child *newchild = (Tabaicho_child *)malloc(sizeof(Tabaicho_child));
    if (list_index == 0)
    {
        newchild->value = lis->value;
        newchild->next = lis->next;
        lis->value = val;
        lis->next = newchild;
        lis->len++;
        return;
    }
    newchild->value = val;
    if (list_index == 1)
    {
        newchild->next = lis->next;
        lis->next = newchild;
        lis->len++;
        return;
    }
    Tabaicho_child *index_for = lis->next;
    for (int i = 1; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return;
        index_for = index_for->next;
    }
    Tabaicho_child *index_back = index_for->next;
    index_for->next = newchild;
    newchild->next = index_back;
    lis->len++;
}

/**
 * @brief 新しい多倍長整数を作ります
 *
 * @param val 値
 * @return 多倍長整数
 */
Tabaicho *mkList()
{
    Tabaicho *newList = (Tabaicho *)malloc(sizeof(Tabaicho));
    newList->value = 0;
    newList->next = NULL;
    newList->len = 1;
    newList->minus = 0;
    return newList;
}

/**
 * @brief 指定したインデックスの値を返します
 *
 * @param lis 多倍長整数
 * @param list_index インデックス
 * @return 値
 */
int numAt(Tabaicho *lis, int list_index)
{
    if (list_index == 0)
        return lis->value;
    Tabaicho_child *index = lis->next;
    for (int i = 1; i < list_index; i++)
    {
        if (index == NULL)
            return -2147483648;
        index = index->next;
    }
    return index->value;
}

/**
 * @brief 指定したインデックスの要素を削除します
 *
 * @param lis 多倍長整数
 * @param list_index インデックス
 * @return 削除した値
 */
int delAt(Tabaicho *lis, int list_index)
{
    if (list_index == 0)
    {
        int ret = lis->value;
        lis->value = (lis->next)->value;
        lis->next = (lis->next)->next;
        free(lis->next);
        lis->len--;
        return ret;
    }
    Tabaicho_child *index_for = lis->next;
    if (list_index == 1)
    {
        int ret = lis->next->value;
        lis->next = index_for->next;
        free(index_for);
        lis->len--;
        return ret;
    }
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return -2147483648;
        index_for = index_for->next;
    }
    Tabaicho_child *index = index_for->next;
    if (index == NULL)
        return -2147483648;
    index_for->next = index->next;
    int ret = index->value;
    free(index);
    lis->len--;
    return ret;
}

/**
 * @brief 多倍長整数を削除します
 *
 * @param lis 多倍長整数
 */
void delList(Tabaicho *lis)
{
    if (lis->next == NULL)
    {
        free(lis);
        return;
    }
    Tabaicho_child *index = lis->next;
    while (lis->next != NULL)
    {
        index = lis->next;
        lis->next = index->next;
        free(index);
    }
    free(lis);
}

/**
 * @brief 多倍長整数をキーボード入力で受け取ります
 *
 * @param list 多倍長整数
 */
Tabaicho* inputTabaicho()
{
    Tabaicho *list;
    list = mkList();
    while (1)
    {
        char c;
        scanf("%c", &c);
        if (c >= '0' && c <= '9')
        { // 0~9はリストに追加
            add(list, c - '0');
        }
        else if (c == '-')
        { // -が来たら負に(-が先頭でなくても負になる)
            list->minus = 1;
        }
        else
            break; // ホワイトスペース含むその他の文字は入力終了とする
    }
    return list;
}

/**
 * @brief 多倍長整数を出力します
 *
 * @param list 多倍長整数
 */
void showTabaicho(Tabaicho *list)
{
    int n = list->len;
    int not_zero = 0; // 0埋め非表示用
    if (list->minus)
        printf("-");
    for (int i = 0; i < n; i++)
    {
        if (numAt(list, i) != 0)
            not_zero = 1;
        if (not_zero || i == n - 1)
            printf("%d", numAt(list, i));
    }
    printf("\n");
}

Tabaicho *sub(Tabaicho *, Tabaicho *); //プロトタイプ宣言

/**
 * @brief 多倍長整数同士の足し算(a+b)
 *
 * @return Tabaicho* a+b
 */
Tabaicho *sum(Tabaicho *a, Tabaicho *b)
{
    Tabaicho *c;
    if (!a->minus && b->minus)
    { //異符号なら減法に
        b->minus = !b->minus;
        c = sub(a, b);
        b->minus = !b->minus;
        return c;
    }
    else if (a->minus && !b->minus)
    { //異符号なら減法に
        a->minus = !a->minus;
        c = sub(b, a);
        a->minus = !a->minus;
        return c;
    }
    c = mkList();
    while (a->len != b->len)
    {
        addAt((a->len < b->len) ? a : b, 0, 0);
    }
    int carry = 0;                        // キャリー
    for (int k = a->len - 1; k >= 0; k--) // 末尾から先頭まで
    {
        int tmp = numAt(a, k) + numAt(b, k) + carry; // 単純に足した値
        carry = tmp / 10;                            // 多い分はキャリーへ
        addAt(c, tmp % 10, 1);                       // 結果を入れる
    }
    addAt(c, carry, 1); //最後のキャリーを追加
    if (a->minus && b->minus)
        c->minus = 1; //マイナス同士なら結果もマイナス
    return c;
}

/**
 * @brief 多倍長整数同士の大きさの比較
 * @return 1(a>b) / 0(a==b) / -1(a<b)
 */
int cmp(Tabaicho *a, Tabaicho *b)
{
    if (a->minus && !b->minus)
        return -1; //符号が違うなら大小は明らか
    if (!a->minus && b->minus)
        return 1; //符号が違うなら大小は明らか
    while (a->len != b->len)
    { //桁数を揃える
        addAt((a->len < b->len) ? a : b, 0, 0);
    }
    for (int i = 0; i < a->len; i++)
    { // 先頭から1桁ずつ見る
        if (numAt(b, i) > numAt(a, i))
        { // b[i]>a[i]
            if (!a->minus && !b->minus)
                return -1; // 符号で返り値は逆になる
            else
                return 1;
        }
        if (numAt(a, i) > numAt(b, i))
        { // a[i]>b[i]
            if (!a->minus && !b->minus)
                return 1; // 符号で返り値は逆になる
            else
                return -1;
        }
    }         // 大小がなかったら
    return 0; // 0(a==b)
}

/** アクセス非推奨、大小関係なく引き算を行う*/
Tabaicho *_privatesub(Tabaicho *a, Tabaicho *b)
{
    Tabaicho *c = mkList();
    while (a->len != b->len)
    {
        addAt((a->len < b->len) ? a : b, 0, 0);
    }
    int carry = 0; // キャリー
    for (int i = a->len - 1; i >= 0; i--)
    {                                                // 末尾から先頭まで
        int tmp = numAt(a, i) - numAt(b, i) - carry; // 単純に引いた値
        if (tmp < 0)
        {              // 引いたものが負なら
            carry = 1; // キャリーを設定
            tmp += 10; // 10足して正にする
        }
        else
            carry = 0;
        addAt(c, tmp % 10, 1); // 結果を入れる
    }
}

/**
 * @brief 多倍長整数同士の引き算(a-b)
 *
 * @return Tabaicho* a-b
 */
Tabaicho *sub(Tabaicho *a, Tabaicho *b)
{
    Tabaicho *c;
    if (a->minus == !b->minus)
    { //異符号なら加法に
        b->minus = !b->minus;
        c = sum(a, b);
        b->minus = !b->minus;
        return c;
    }
    int size = cmp(a, b);
    if (size >= 0)
    { //大小で符号、a,bの符号で計算方法を変える(a,b同士は同符号しかありえない)
        if (!a->minus)
            c = _privatesub(a, b);
        else
            c = _privatesub(b, a);
        c->minus = 0;
    }
    else
    {
        if (!a->minus)
            c = _privatesub(b, a);
        else
            c = _privatesub(a, b);
        c->minus = 1;
    }
    return c;
}

/**
 * @brief 多倍長整数同士のかけ算(a*b)
 *
 * @return Tabaicho* a*b
 */
Tabaicho *mul(Tabaicho *a, Tabaicho *b)
{
    Tabaicho *c = mkList();
    for (int i = b->len - 1; i >= 0; i--)
    {                              //末尾から先頭まで
        Tabaicho *a_bi = mkList(); // a*b[i]
        int b_keta = numAt(b, i);  // b[i]
        int carry = 0;             //キャリー
        for (int j = b->len - 1; j >= 0; j--)
        {                                           // bの桁ごとにかけ算を行う
            int tmp = numAt(a, j) * b_keta + carry; // tmp=a[j]*b[i]+carry
            carry = tmp / 10;
            tmp = tmp % 10;
            addAt(a_bi, tmp, 1);
        }
        for (int j = b->len - 1; j > i; j--)
            add(a_bi, 0); // a*b[i]を適切な桁数にする
        c = sum(c, a_bi); // cにa*b[i]を足す
        delList(a_bi);
    }
    if (a->minus == !b->minus)
        c->minus = 1; //符号設定
    return c;
}

/**
 * @brief 多倍長整数同士の割り算(a/b)
 *
 * @return Tabaicho* a/b
 */
Tabaicho *divi(Tabaicho *a, Tabaicho *b)
{
    Tabaicho *c = mkList();
    Tabaicho *rem = mkList(); // 余り
    for (int i = 0; i < a->len; i++)
    {                                  // 先頭から末尾まで
        Tabaicho *keta_sum = mkList(); // bの和
        add(rem, 0);                   // 余りを*10
        for (int j = 0; j < 10; j++)
        {                             // 割り算
            Tabaicho *a_i = mkList(); // =a[i]
            add(a_i, numAt(a, i));
            keta_sum = sum(keta_sum, b); // keta_sum+=b
            if (cmp(sum(rem, a_i), keta_sum) == -1)
            {                                               // bを足していって、(rem*a[i])を超えたら
                add(c, j);                                  // cの末尾に(rem*a[i])/b(つまり、繰り返しの回数-1であるj)を追加
                rem = sub(sum(rem, a_i), sub(keta_sum, b)); // 余りとして、(rem*a[i])%b(つまり、rem*a[i]-(b*j))を追加
                break;
            }
        }
    }
    if (a->minus == !b->minus)
        c->minus = 1; //符号設定
    return c;
}

#endif // INCLUDE_NEW_TABAICHO
