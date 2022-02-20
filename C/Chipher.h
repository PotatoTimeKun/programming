#ifndef CHIPHER_H_INCLUDE
#define CHIPHER_H_INCLUDE
#include <stdio.h>
#include <string.h>
#include <ctype.h>
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

#endif
