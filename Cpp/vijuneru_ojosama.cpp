#include <iostream>
#include <string>
using namespace std;
#define こちらの auto
#define 様は 
#define 引数に (
#define 何も受け取らず )
#define 代わりに ->
#define をお返しになる関数でして 
#define 以下のことをなさいます {
#define と ,
#define こちらstring型の string
#define ですわ ; 
#define このwhile文は while(
#define の間 )
#define 標準出力に cout<<
#define を表示して改行するの <<endl
#define キーボードからの値が入るのは cin>>
#define バッファは初期化しましてよ cin.clear();cin.ignore(1048576, '\n');
#define 改行が出るまで getline(cin,
#define にキーボード入力しますわ );
#define 以上ですの }
#define 関数に (
#define を渡した返り値 )
#define に加えて +

string vigenere(char,string,string); // ヴィジュネル暗号を返す関数ですわ

こちらの main 様は 引数に 何も受け取らず 代わりに int をお返しになる関数でして 以下のことをなさいます
    こちらstring型の str と key ですわ
    char mode;
    このwhile文は true の間 以下のことをなさいます
        標準出力に "モードを入力するのですわ。モードはmake(m)かread(r)でしてよ。" を表示して改行するの ですわ
        キーボードからの値が入るのは mode ですわ
        バッファは初期化しましてよ
        標準出力に "平文か暗号文を入力するのですわ。" を表示して改行するの ですわ
        改行が出るまで str にキーボード入力しますわ
        バッファは初期化しましてよ
        標準出力に "鍵を入力するのですわ。" を表示して改行するの ですわ
        キーボードからの値が入るのは key ですわ
        バッファは初期化しましてよ
        標準出力に "結果は以下のようになりますわ。\n" に加えて vigenere 関数に mode と str と key を渡した返り値 を表示して改行するの ですわ
    以上ですの
以上ですの

string vigenere(char mode, string sentence, string key)
{
    string ret(sentence);
    int i_k = 0, sl = sentence.length(), kl = key.length();
    for (int i = 0; i < sl; i++)
        sentence[i] = tolower(sentence[i]);
    for (int i = 0; i < kl; i++)
        key[i] = tolower(key[i]);
    if (mode == 'm')
    {
        for (int i = 0; i < sentence.length(); i++)
        {
            if (sentence[i] >= 'a' && sentence[i] <= 'z')
            {
                ret[i] = 'A' + (sentence[i] + key[i_k] - 2 * 'a') % 26;
                i_k++;
            }
            else
            {
                ret[i] = sentence[i];
            }
            if (i_k >= key.length())
                i_k = 0;
        }
    }
    if (mode == 'r')
    {
        for (int i = 0; i < sentence.length(); i++)
        {
            if (sentence[i] >= 'a' && sentence[i] <= 'z')
            {
                int p = ((int)sentence[i] - (int)key[i_k]) % 26;
                if (p < 0)
                    p += 26;
                ret[i] = 'a' + p;
                i_k++;
            }
            else
            {
                ret[i] = sentence[i];
            }
            if (i_k >= key.length())
                i_k = 0;
        }
    }
    return ret;
}