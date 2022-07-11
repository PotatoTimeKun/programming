#include <stdio.h>
#include <wchar.h>
void _printC(char c)
{ // 1バイト分の文字を表示
    for(int j=0; j<8; j++)
    {
        int b=(c&0x80)>>7; // MSBを取得
        c<<=1; // 1左シフト
        printf("%s",b==0?"ポ":"テ");
    }
}
/* 引数のwchar_t配列による文字列をポテ語で表示します */
void printJPPote(wchar_t* str)
{
    for(int i=0; str[i]!='\0'; i++)
    { // ヌル文字が出るまで
        _printC(str[i]);
        if((str[i]&0x80)!=0) // 2バイト文字のとき、続けて表示
            _printC(str[++i]);
        printf("\n");
    }
}
int main()
{
    wchar_t str[200];
    wscanf(L"%[^\n]",str);
    printJPPote(str);
}
