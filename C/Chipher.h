#ifndef CHIPHER_H_INCLUDE
#define CHIPHER_H_INCLUDE
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

#endif
