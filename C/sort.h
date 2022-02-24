/**
 * @file sort.h
 * @brief 整列を行う関数が入っています。
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * 
 * @details 関数一覧
 * void bubble(int array[],int array_size)
 * void select(int array[],int array_size)
 * void insert(int array[],int array_size)
 * void shell(int array[],int array_size)
 * void quick(int array[],int array_size)
 * void marge(int array[],int array_size)
 * 
 */
#ifndef INCLUDE_SORT_H
#define INCLUDE_SORT_H
/**
 * @brief バブルソート(基本交換法)で昇順に整列を行います。
 * 
 * @param array 整列を行う変数
 * @param array_size arrayの要素数
 */
void bubble(int *array, int array_size)
{
    int sw;
    for (int i = array_size; i > 1; i--)
    {
        for (int j = 0; j < i; j++)
        {
            if (array[j] < array[j + 1])
            {
                sw = array[j];
                array[j] = array[j + 1];
                array[j + 1] = sw;
            }
        }
    }
}
/**
 * @brief 基本選択法で昇順に整列を行います。
 * 
 * @param array 整列を行う変数
 * @param array_size arrayの要素数
 */
void select(int *array, int array_size)
{
    int sw, min;
    for (int i = 0; i < array_size - 1; i++)
    {
        min = i;
        for (int j = i + 1; j < array_size; j++)
        {
            if (array[min] > array[j])
                min = j;
        }
        sw = array[i];
        array[i] = array[min];
        array[min] = sw;
    }
}
/**
 * @brief 基本挿入法で昇順に整列を行います。
 * 
 * @param array 整列を行う変数
 * @param array_size arrayの要素数
 */
void insert(int *array, int array_size)
{
    int sw;
    for (int i = 2; i < array_size; i++)
    {
        for (int j = i; j > 0; j--)
        {
            if (array[j - 1] < array[j])
                break;
            else
            {
                sw = array[j];
                array[j] = array[j - 1];
                array[j - 1] = sw;
            }
        }
    }
}
/**
 * @brief シェルソート(改良挿入法)で昇順に整列を行います。
 * 
 * @param array 整列を行う変数
 * @param array_size arrayの要素数
 */
void shell(int *array, int array_size)
{
    int sw;
    for (int c = 3; c > 0; c--)
    {
        for (int i = 2; i < array_size; i += c)
        {
            for (int p = 0; p < c; p++)
            {
                for (int j = i; j > 0; j -= c + p)
                {
                    if (array[j - c] < array[j])
                        break;
                    else
                    {
                        sw = array[j];
                        array[j] = array[j - 1];
                        array[j - 1] = sw;
                    }
                }
            }
        }
    }
}
/**
 * @brief クイックソートで昇順に整列を行います。
 * 
 * @param array 整列を行う変数
 * @param array_size arrayの要素数
 */
void quick(int array[], int array_size)
{
    private_function_for_shell(array, array_size, 0, array_size - 1);
}
void private_function_for_shell(int *array, int array_size, int st, int en)
{
    int sw, pi, pip;
    if (st < en)
    {
        pip = st;
        pi = array[(st + en) / 2];
        array[(st + en) / 2] = array[st];
        for (int i = st + 1; i <= en; i++)
        {
            if (array[i] < pi)
            {
                pip++;
                sw = array[pip];
                array[pip] = array[i];
                array[i] = sw;
            }
        }
        array[st] = array[pip];
        array[pip] = pi;
        private_function_for_shell(array, array_size, st, pip - 1);
        private_function_for_shell(array, array_size, pip + 1, en);
    }
}
void private_function_marge(int *array, int array_size, int st, int mid, int en)
{
    int sn = mid - st, enn = en - mid;
    int S[sn + 1], E[enn + 1];
    for (int i = 0; i < mid + 1 - st; i++)
        S[i] = array[i];
    for (int i = 0; i < en + 1 - mid; i++)
        E[i] = array[mid + i];
    S[sn] = __INT32_MAX__;
    E[enn] = __INT32_MAX__;
    int i = 0, j = 0;
    for (int k = st; k < en; k++)
    {
        if (S[i] <= E[j])
        {
            array[k] = S[i];
            i++;
        }
        else
        {
            array[k] = E[j];
            j++;
        }
    }
}
void private_function_sort(int *array, int array_size, int st, int en)
{
    if (st + 1 < en)
    {
        int mid = (st + en) / 2;
        private_function_sort(array, array_size, st, mid);
        private_function_sort(array, array_size, mid, en);
        private_function_marge(array, array_size, st, mid, en);
    }
}
/**
 * @brief マージソートで昇順に整列を行います。
 * 
 * @param array 整列を行う変数
 * @param array_size arrayの要素数
 */
void marge(int *array,int array_size){
    private_function_sort(array,array_size,0,array_size);
}
#endif