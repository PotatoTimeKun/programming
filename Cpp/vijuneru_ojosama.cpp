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

#define を受け取り )
#define こちらint型の int
#define の長さ .length()
#define こちらのfor文は for
#define 初期化として (
#define 条件として ;
#define 増分として ;
#define を行いますわ )
#define 配列のインデックス [
#define の要素 ]
#define は =
#define が代入されましてよ ;
#define もしも if(
#define が ==
#define でしたら )
#define を行い )
#define でして ,
#define の上 &&
#define をインクリメント ++
#define そうでなければ else
#define 次の文を実行しますの
#define に追加されるのは +=
#define 返り値は return

こちらの vigenere 様は 引数に char mode と string sentence と string key を受け取り 代わりに string をお返しになる関数でして 以下のことをなさいます
    こちらstring型の ret(sentence) ですわ
    こちらint型の i_k は 0 でして sl は sentence の長さ でして kl は key の長さ ですわ
    こちらのfor文は 初期化として int i は 0 条件として i < sl 増分として i++ を行いますわ
        sentence 配列のインデックス i の要素 は tolower(sentence[i]) が代入されましてよ
    こちらのfor文は 初期化として int i は 0 条件として i < kl 増分として i++ を行いますわ
        key 配列のインデックス i の要素 は tolower(key[i]) が代入されましてよ
    もしも mode が 'm' でしたら 以下のことをなさいます
        こちらのfor文は 初期化として int i = 0 条件として i < sentence の長さ 増分として i++ を行い 以下のことをなさいます
            もしも sentence 配列のインデックス i の要素 >= 'a' の上 sentence[i] <= 'z' でしたら 以下のことをなさいます
                ret 配列のインデックス i の要素 は 'A' + (sentence [i] + key [i_k] - 2 * 'a') % 26 が代入されましてよ
                i_k をインクリメント ですわ
            以上ですの
            そうでなければ 以下のことをなさいます
                ret 配列のインデックス i の要素 は sentence 配列のインデックス i の要素 が代入されましてよ
            以上ですの
            もしも i_k >= key.length() でしたら 次の文を実行しますの
                i_k は 0 が代入されましてよ
        以上ですの
    以上ですの
    もしも mode が 'r' でしたら 以下のことをなさいます
        こちらのfor文は 初期化として int i = 0 条件として i < sentence の長さ 増分として i++ を行い 以下のことをなさいます
            もしも sentence[i] >= 'a' の上 sentence[i] <= 'z' でしたら 以下のことをなさいます
                こちらint型の p = ((int)sentence[i] - (int)key[i_k]) % 26 ですわ
                もしも p < 0 でしたら 次の文を実行しますの
                    p に追加されるのは 26 ですわ
                ret 配列のインデックス i の要素 は 'a' + p が代入されましてよ
                i_k をインクリメント ですわ
            以上ですの
            そうでなければ 以下のことをなさいます
                ret 配列のインデックス i の要素 は sentence 配列のインデックス i の要素 が代入されましてよ
            以上ですの
            もしも i_k >= key.length() でしたら 次の文を実行しますの
                i_k は 0 が代入されましてよ
        以上ですの
    以上ですの
    返り値は ret ですわ
以上ですの