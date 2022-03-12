/**
 * @file Chipher.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 暗号を扱う関数が入っています。
 * @details 関数一覧
 * void ceaser(char mode, char *sentence, int sen_size, int shift)
 * void vegenere(char mode, char *sentence, int sen_size, char *key, int key_size)
 * void substitution(char mode, char *sentence, int sen_size, char *key)
 */
#ifndef CHIPHER_H_INCLUDE
#define CHIPHER_H_INCLUDE
#include <stdio.h>
#include <string.h>
#include <ctype.h>
/**
 * シーザー暗号を扱います。
 * @param mode "m":暗号化モード，"r":復号化モード
 * @param sentence 変換する文字列(かつ変換後の文字列を格納する配列)
 * @param sen_size sentenceの要素数
 * @param shift シフトする数
 */
void ceaser(char mode, char *sentence, int sen_size, int shift)
{
    for (int i = 0; i < sen_size; i++)
        sentence[i] = tolower(sentence[i]);
    if (mode == 'm')
    {
        if (shift < 0)
        {
            ceaser('r', sentence, sen_size, -shift);
            return;
        }
        for (int i = 0; i < sen_size; i++)
        {
            if (sentence[i] >= 'a' && sentence[i] <= 'z')
            {
                sentence[i] = 'A' + (sentence[i] - 'a' + shift) % 26;
            }
        }
    }
    if (mode == 'r')
    {
        if (shift < 0)
        {
            ceaser('m', sentence, sen_size, -shift);
            return;
        }
        for (int i = 0; i < sen_size; i++)
        {
            if (sentence[i] >= 'a' && sentence[i] <= 'z')
            {
                int p = (sentence[i] - 'a' - shift) % 26;
                if (p < 0)
                    p += 26;
                sentence[i] = 'a' + p;
            }
        }
    }
}
/**
 * ヴィジュネル暗号を扱います。
 * @param mode "m":暗号化モード，"r":復号化モード
 * @param sentence 変換する文字列(かつ変換後の文字列を格納する配列)
 * @param sen_size sentenceの要素数
 * @param key 鍵
 * @param key_size 鍵の文字数(keyの要素数ではない)
 */
void vegenere(char mode, char *sentence, int sen_size, char *key, int key_size)
{
    int key_index = 0, i;
    for (i = 0; i < sen_size; i++)
        sentence[i] = tolower(sentence[i]);
    for (i = 0; i < key_size; i++)
        key[i] = tolower(key[i]);
    if (mode == 'm')
    {
        for (i = 0; i < sen_size; i++)
        {
            if (sentence[i] >= 'a' && sentence[i] <= 'z')
            {
                sentence[i] = 'A' + (sentence[i] + key[key_index] - 2 * 'a') % 26;
                key_index++;
            }
            if (key_index >= key_size)
                key_index = 0;
        }
    }
    if (mode == 'r')
    {
        for (i = 0; i < sen_size; i++)
        {
            if (sentence[i] >= 'a' && sentence[i] <= 'z')
            {
                int p = (sentence[i] - key[key_index]) % 26;
                if (p < 0)
                    p += 26;
                sentence[i] = 'a' + p;
                key_index++;
            }
            if (key_index >= key_size)
                key_index = 0;
        }
    }
}
/**
 * 単一換字式暗号を扱います。
 * @param mode "m":暗号化モード，"r":復号化モード
 * @param sentence 変換する文字列(かつ変換後の文字列を格納する配列)
 * @param sen_size sentenceの要素数
 * @param key 鍵(a-zに対応した文字列)
 */
void substitution(char mode, char *sentence, int sen_size, char *key)
{
    char abc[] = "abcdefghijklmnopqrstuvwxyz", *p;
    if (mode == 'm')
    {
        for (int i = 0; i < sen_size; i++)
        {
            if (sentence[i] >= 'a' && sentence[i] <= 'z')
            {
                p = strchr(abc, (int)sentence[i]);
                sentence[i] = key[p - abc];
            }
        }
    }
    if (mode == 'r')
    {
        for (int i = 0; i < sen_size; i++)
        {
            char keystr[26];
            for (int i = 0; i < 26; i++)
                keystr[i] = key[i];
            p = strchr(keystr, (int)sentence[i]);
            if (p - keystr < 26)
                sentence[i] = abc[p - keystr];
        }
    }
}
/**
 * @brief ポリュビオスの暗号表(5*5)を扱います。
 * 5*5の方式ではjとiの暗号が同じ結果になります。そのため、復号結果ではiはiのままjをiとします。
 * 平文ではa-z以外の文字(空白も含む)は除いてください。
 * 暗号文では0と1以外の文字(空白も含む)は除いてください。
 * 
 * @param mode "m":暗号化モード，"r":復号化モード
 * @param sentence 変換する文字列
 * @param sen_size sentenceの要素数
 * @param return_array 変換後の文字列を格納する配列
 */
void polybius_square(char mode,char* sentence,int sen_size,char* return_array){
    if(mode=='m'){
        for(int i=0;i<sen_size;i++){
            int c=sentence[i]-'a';
            if(c<'j'){
                return_array[2*i]='0'+(i/5+1);
                return_array[2*i+1]='0'+(i%5+1);
            }else{
                c--;
                return_array[2*i]='0'+(i/5+1);
                return_array[2*i+1]='0'+(i%5+1);
            }
        }
        return_array[sen_size*2]='\0';
    }
    if(mode=='r'){
        for(int i=0;i<sen_size/2;i++){
            return_array[i]='a'+(5*((int)sentence[2*i]-(int)'0'-1)+((int)sentence[2*i+1]-(int)'0'-1));
            if(return_array[i]>='j'){
                return_array[i]+=1;
            }
        }
        return_array[sen_size/2]='\0';
    }
}
#endif
