/**
 * @file BrainPotato_language.cpp
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief ブレインポテトをC++で実行するためのプログラムです。
 *
 */
#include <iostream>
#include <string>
#include <cstdio>
using namespace std;
/**
 * @brief BrainPotato言語のコードを扱うためのクラスです。
 *
 */
class BrainPotato
{
public:
    BrainPotato();
    /**
     * @brief BrainPotatoのソースコードをクラスに設定します。
     *
     * @param BRcode BrainPotatoプログラムのソースコード
     */
    void setCode(string BRcode);
    /**
     * @brief 設定したコードを実行し、出力する文字列を返します。
     *
     * @return string
     */
    wstring runCode();
    wchar_t* ret=new wchar_t[100];
private:
    int* ptr;
    int l;
    bool iftrue;
    string code="";
};
BrainPotato::BrainPotato() {}
void BrainPotato::setCode(string BRcode)
{
    code=BRcode;
}
wstring BrainPotato::runCode()
{
    int a[10000];
    for(int i=0; i<1000; i++)
    {
        a[i]=0;
    }
    ptr=a;
    l=0;
    iftrue=false;
    string inp=code;
    int retIndex=0;
    wchar_t wc[3];
    for(int i=0; i<inp.length(); i++)
    {
        char c=inp[i];
        switch (c)
        {
        case 'p':
            ptr++;
            break;
        case 'o':
            ptr--;
            break;
        case 't':
            *ptr+=1;
            break;
        case 'm':
            *ptr-=1;
            break;
        case 'k':
            if(int((*ptr)/0x100)!=0)
            {
                ret[retIndex++]=int((*ptr)/0x100);
                ret[retIndex++]=(*ptr)%0x100;
            }
            else
            {
                ret[retIndex++]=(*ptr)%0x100;
            }
            ret[retIndex]='\0';
            break;
        case 'u':
            if((int)*ptr==0)
            {
                l=1;
                for(int j=i+1; j<inp.length(); j++)
                {
                    char c2=inp[j];
                    switch (c2)
                    {
                    case 'u':
                        l++;
                        break;
                    case 'n':
                        l--;
                        break;
                    default:
                        break;
                    }
                    if(l==0)
                    {
                        i=j;
                        break;
                    }
                }
            }
            break;
        case 'n':
            if((int)*ptr!=0)
            {
                l=1;
                for(int j=i-1; j>=0; j--)
                {
                    char c2=inp[j];
                    switch (c2)
                    {
                    case 'u':
                        l--;
                        break;
                    case 'n':
                        l++;
                        break;
                    default:
                        break;
                    }
                    if(l==0)
                    {
                        i=j;
                        break;
                    }
                }
            }
            break;
        case 'i':
            if((int)*ptr>0)
            {
                iftrue=true;
            }
            else
            {
                iftrue=false;
                l=1;
                for(int j=i+1; j<inp.length(); j++)
                {
                    char c2=inp[j];
                    switch (c2)
                    {
                    case 'a':
                        l--;
                        break;
                    case 'e':
                        l--;
                        break;
                    default:
                        break;
                    }
                    if(l==0)
                    {
                        i=j;
                        break;
                    }
                }
            }
            break;
        case 'a':
            break;
        case 'e':
            if(iftrue)
            {
                l=1;
                for(int j=i+1; j<inp.length(); j++)
                {
                    char c2=inp[j];
                    switch (c2)
                    {
                    case 'a':
                        l--;
                        break;
                    default:
                        break;
                    }
                    if(l==0)
                    {
                        i=j;
                        break;
                    }
                }
            }
            break;
        case 'c':
            *ptr*=2;
            break;
        case 'h':
            *ptr/=2;
            break;
        case 's':
            wchar_t a[3];
            wscanf(L" %s",&a);
            if(a[1]!=0)
            {
                *ptr=a[1];
                *ptr+=a[0]*0x100;
            }
            else
            {
                *ptr=a[0];
            }
            break;
        default:
            break;
        }
    }
}
main()
{
    cout<<"helpでヘルプを表示"<<endl;
    string code="";
    while(true)
    {
        string inp;
        getline(cin,inp);
        if(inp=="help")
        {
            cout<<"Created by PotatoTimeKun https://github.com/PotatoTimeKun/programming \n最初のポインタのアドレスより前のアドレスは使用しないことを勧めます\n命令一覧:\np:ポインタのアドレスをインクリメント(ptr++)\no:ポインタのアドレスをデクリメント(ptr--)\nt:ポインタの値をインクリメント(*ptr+=1)\nm:ポインタの値をデクリメント(*ptr-=1)\nk:ポインタの値をASCII文字として出力\nu:ポインタの値が0ならnまで飛ばす\nn:ポインタの値が0以外ならuまで戻る\ni:ポインタの値が0ならaかe(eはaで閉じる)まで飛ばす\ne:iで飛ばされた場合のみaまで実行する\nc:ポインタの値を2倍する(*ptr*=2)\nh:ポインタの値を1/2倍する(*ptr/=2)\ns:キーボード入力を1文字受け取りポインタに格納する\n.endでコードを実行";
            break;
        }
        if(inp==".end")break;
        code+=inp;
    }
    BrainPotato br;
    br.setCode(code);
    br.runCode();
    wprintf(L"%s",br.ret);
    cout<<endl<<endl;
    main();
}
