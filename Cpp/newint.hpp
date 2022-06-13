/**
 * @file newint.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 多倍長整数を扱うnewintクラスが入っています。
 *
 *
 */
#ifndef Include_newint
#define Include_newint
#include <string>
#include <algorithm>
#include <iostream>
using namespace std;
/**
 * @brief 多倍長整数を扱います。
 * 演算子は四則演算子・比較演算子・単項演算子(++,--,-)・剰余演算子に対応しています。
 *
 */
class newint
{
private:
    /**
     * @brief インスタンスが表す絶対値(先頭が小さい桁)
     */
    string value = "";

    /**
     * @brief インスタンスが表す値の符号
     * True:負数 , False:正の数
     */
    bool minus = false;

    /**
     * @brief valueをi桁に0埋めします。
     * @param i
     */
    void keta(int i)
    {
        value += string(i - value.size(), '0'); // 差の分だけ0を追加
    }

public:
    /**
     * @brief 値が空のnewintインスタンスを作成します。
     */
    newint() {}

    /**
     * @brief 値渡しでコピーしたnewintインスタンスを作成します。
     * @param newint_inst newintインスタンス
     */
    newint(newint *newint_inst)
    {
        value = newint_inst->value;
        minus = newint_inst->minus;
    }

    /**
     * @brief 渡した値を表すnewintインスタンスを作成します。
     * @param newValue 値を表す文字列
     */
    newint(string newValue)
    {
        this->set(newValue); // setメソッドは下に記述してある
    }

    /**
     * @brief 渡した値でインスタンスが表す値を設定します。
     * @param newValue 値を表す文字列
     */
    void set(string newValue)
    {
        if (newValue == "-0")
        {
            value = "0";
            minus = false;
        }
        else if (newValue[0] == '-')
        {
            value = newValue.substr(1);
            minus = true;
        }
        else
        {
            value = newValue;
            minus = false;
        }
        reverse(value.begin(), value.end());
    }

    /**
     * @brief インスタンスが表す値を文字列で返します。
     * @param abs trueにすると絶対値を返します。
     * @return string インスタンスが表す値
     */
    string str(bool abs = false)
    {
        string copy_val(value);
        reverse(copy_val.begin(), copy_val.end()); // 逆順に保存していたのを戻す
        while ((copy_val[0] == '0') && (copy_val.size() != 1))
        {                                  // ゼロ埋めがなくなるまで、桁数が0にならない限り
            copy_val = copy_val.substr(1); // 先頭の文字(ゼロ埋め)を消す
        }
        if (minus && !abs) // マイナスなら(返り値が絶対値でなければ)
        {
            return "-" + copy_val; // マイナスを付けて返す
        }
        return copy_val;
    }

    /**
     * @brief インスタンスが表す値を2進数に変換して返します。
     * 値が負数の時は"-"をつけて返します。
     * @return string
     */
    string bin()
    {
        string ret;                     // 返り値
        newint copied(this->str(true)); // 自身のコピー
        newint kisu("2");               // 基数
        while (copied.str() != "0")
        {                                 // 0になるまで、2進数の筆算と同じ方法
            ret += (copied % kisu).str(); // 基数で割った余りを追加
            copied = copied / kisu;       // 基数で割る
        }
        reverse(ret.begin(), ret.end()); // 2進数の筆算は逆順に読む
        if (minus)
            return "-" + ret;
        return ret;
    }

    /**
     * @brief インスタンスが表す値を16進数に変換して返します。
     * 値が負数の時は"-"をつけて返します。
     * @return string
     */
    string hex()
    {
        string ret;                     // 返り値
        newint copied(this->str(true)); // 自身のコピー(絶対値)
        newint kisu("16");              // 基数
        while (copied.str() != "0")
        { // 0になるまで、16進数の筆算と同じ方法
            string amari = (copied % kisu).str();
            if (amari.length() == 1)         // 余りが1桁(つまり9以下)なら
                ret += amari;                // そのまま追加
            else                             // それ以外(つまり10以上)なら
                ret += 'A' + amari[1] - '0'; // 文字コードを利用しA~Fに変換
            copied = copied / kisu;          // 基数で割る
        }
        reverse(ret.begin(), ret.end()); // 筆算の結果は逆に読む
        if (minus)
            return "-" + ret;
        return ret;
    }
    /**
     * @brief インスタンスが表す値を8進数に変換して返します。
     * 値が負数の時は"-"をつけて返します。
     *
     * @return string
     */
    string oct()
    {                                   // 基数以外2進数と同じ処理
        string ret;                     // 返り値
        newint copied(this->str(true)); // 自身のコピー
        newint kisu("8");               // 基数
        while (copied.str() != "0")
        {                                 // 0になるまで、8進数の筆算と同じ方法
            ret += (copied % kisu).str(); // 基数で割った余りを追加
            copied = copied / kisu;       // 基数で割る
        }
        reverse(ret.begin(), ret.end()); // 8進数の筆算は逆順に読む
        if (minus)
            return "-" + ret;
        return ret;
    }
    newint operator+(newint a); // 演算子の一覧を書く、処理は後で記述する
    newint operator-(newint a);
    newint operator*(newint a);
    newint operator/(newint a);
    newint operator%(newint a);
    newint operator-();
    newint operator++();      // ++a
    newint operator--();      // --a
    newint operator++(int n); // a++
    newint operator--(int n); // a--
    int operator[](int n);
    bool operator<(newint a);
    bool operator<=(newint a);
    bool operator>(newint a);
    bool operator>=(newint a);
    bool operator==(newint a);
    bool operator!=(newint a);
};

newint newint::operator+(newint a)
{                   // b + a (自身をbとする)
    newint ret;     // 返り値
    newint b(this); // 自身
    int carry = 0;  // キャリー
    (b.value.size() < a.value.size())
        ? (b.keta(a.value.size()))
        : (a.keta(b.value.size())); // 3項演算子、ゼロ埋めで桁数をa,b両方同じにする
    if ((b.minus) == (a.minus))
    {                        // 同符号での演算なら
        ret.minus = b.minus; // 符号は変化しない
        for (int i = 0; i < (a.value.size()); i++)
        {                                                                    //小さい桁から足していく
            int tmp = int(b.value[i] - '0') + int(a.value[i] - '0') + carry; // 単純に足した値
            carry = tmp / 10;                                                // 多い分をキャリーに
            tmp = tmp % 10;                                                  // キャリーの分をなくす
            ret.value += to_string(tmp);                                     // 結果
        }
        ret.value += to_string(carry); // 最上位桁へのキャリーを追加
    }
    else
    { // 異符号での演算なら
        (a.minus)
            ? (ret = b - -a)
            : (ret = a - -b);
        // 3項演算子、b+aを符号により b-(-a)(a<0のとき) もしくは a-(-b)(b<0のとき) に変更する
        // つまり、同符号での減算に変える
    }
    return ret;
}

newint newint::operator-(newint a)
{                   // b - a (自身をbとする)
    newint ret;     // 返り値
    newint b(this); // 自身
    int carry = 0;  // キャリー
    (b.value.size() < a.value.size())
        ? (b.keta(a.value.size()))
        : (a.keta(b.value.size())); // 3項演算子、ゼロ埋めで桁数をa,b両方同じにする
    if (!(b.minus) && !(a.minus))
    { // 正同士での演算なら
        if (a < b)
        { // 大きい方から小さい方を引くとき(符号は+のままになる)
            for (int i = 0; i < a.value.size(); i++)
            {                                                                    // 小さい桁から計算する
                int tmp = int(b.value[i] - '0') - int(a.value[i] - '0') - carry; // 単純に引いた値
                if (tmp < 0)
                {              // tmpが負なら
                    carry = 1; // キャリーを追加し
                    tmp += 10; // 正に直す
                }
                else
                    carry = 0; // 負でなければキャリーを0に戻す
                ret.value += to_string(tmp);
            }
        }
        else if (a == b)
            ret.set("0"); // a==bなら結果は0
        else
            ret = -(a - b); // b>aのときは b-a = -(a-b) として計算
    }
    else if((b.minus) && (a.minus))
    { // 負同士での演算なら
        ret = -(-b - -a); // 正同士での演算に変換
    }
    else
    {                 //異符号なら
        ret = b + -a; //同符号での加法に変換
    }
    return ret;
}

newint newint::operator*(newint a)
{                              // b*a (自身をbとする)
    this->set(this->str());    // 無駄な0埋めを消す(計算量削減)
    a.set(a.str());            // 同じく
    newint ret = new newint(); // 返り値
    newint b(this);            // 自身
    for (int i = 0; i < a.value.size(); i++)
    {                              // i:小さい桁から(aの桁数まで)
        newint sum = new newint(); // b*a[i]
        int carry = 0;             // キャリー
        for (int j = 0; j < b.value.size(); j++)
        {                                                              // j:小さい桁から(bの桁数まで)
            int tmp = (b.value[j] - '0') * (a.value[i] - '0') + carry; // その桁のかけた値(キャリーあり)
            carry = tmp / 10;                                          // 多い分をキャリーに
            tmp = tmp % 10;                                            // キャリーの分を消す
            sum.value += to_string(tmp);
        }
        sum.value += to_string(carry); // 最上位桁へのキャリー
        for (int j = 0; j < i; j++)
            sum.set(sum.str() + "0"); // 足すためにb*a[i]の桁を直す
        ret = ret + sum;              // 結果にb*a[i]を足す
    }
    ret.minus = (a.minus) ^ (b.minus); // 同じならFalse,違うならTrue → xor
    return ret;
}

newint newint::operator/(newint a)
{                              // b/a
    this->set(this->str());    // 無駄な0埋めを消す(計算量削減)
    a.set(a.str());            // 同じく
    newint ret = new newint(); // 返り値
    newint b(this);            // 自身
    newint rem;                // 余り
    bool a_minus = a.minus;    // a.minusを保存しておく
    a.minus = false;
    for (int i = b.value.length() - 1; i >= 0; i--)
    {
        newint sum;                  // aを足した和
        rem.value = "0" + rem.value; //余りを10倍
        for (int j = 0; j < 10; j++)
        {
            newint b_i(to_string(b.value[i] - '0')); // b[i]
            sum = sum + a;
            if ((rem + b_i) < sum)
            {                                         // bを足していってその桁の数(rem+b_i)を超えたら
                ret.value = to_string(j) + ret.value; // 繰り返し回数-1であるjを足す
                rem = (rem + b_i) - (sum - a);        // 余りとして(rem*b[i])%aに等価な値を設定
                break;
            }
        }
    }
    a.minus = a_minus;
    ret.minus = (a.minus) ^ (b.minus); // 同じならFalse,違うならTrue → xor
    return ret;
}

newint newint::operator%(newint a)
{ // b/a
    // やってることは割り算と同じ、最後の余りだけを取り出す
    this->set(this->str());    // 無駄な0埋めを消す(計算量削減)
    a.set(a.str());            // 同じく
    newint ret = new newint(); // 返り値
    newint b(this);            // 自身
    newint rem;                // 余り
    bool a_minus = a.minus;    // a.minusを保存しておく
    a.minus = false;
    for (int i = b.value.length() - 1; i >= 0; i--)
    {
        newint sum;                  // aを足した和
        rem.value = "0" + rem.value; //余りを10倍
        for (int j = 0; j < 10; j++)
        {
            newint b_i(to_string(b.value[i] - '0')); // b[i]
            sum = sum + a;
            if ((rem + b_i) < sum)
            {                                         // bを足していってその桁の数(rem+b_i)を超えたら
                ret.value = to_string(j) + ret.value; // 繰り返し回数-1であるjを足す
                rem = (rem + b_i) - (sum - a);        // 余りとして(rem*b[i])%aに等価な値を設定
                break;
            }
        }
    }
    a.minus = a_minus;
    if (rem != (new newint("0")))
        rem.minus = (a.minus) ^ (b.minus); // 同じならFalse,違うならTrue → xor
    return rem;
}

newint newint::operator-()
{ // 単項演算子の- (-xの-)
    newint ret(this);
    ret.minus = !ret.minus; // not演算子で反転
    return ret;
}

newint newint::operator++()
{ // 単項演算子の++ (++x)
    newint b(this);
    if (b.minus)
    { // 絶対値で演算を行うため
        b.minus=false; // 符号が負のままだと無限にループする
        --b;
        this->set((-b).str());
        return *this;
    }
    b.value += "0"; // 桁数が1つ大きくなる可能性があるため、桁設定
    for (int i = 0; i < b.value.size(); i++)
    {
        if (b.value[i] != '9')
        { // 9が続いたらそれまでの桁の数は0になる
            b.value[i] += 1;
            b.value = string(i, '0') + b.value.substr(i);
            break;
        }
    }
    this->set(b.str());
    return *this;
}

newint newint::operator++(int n)
{ // 単項演算子の++(x++)
    newint b(this);
    newint ret(this); // 返り値、これは変化させない
    if (b.minus)
    { // 絶対値で演算を行うため
        b.minus=false; // 符号が負のままだと無限にループする
        b--;
        this->set((-b).str());
        return ret;
    }
    b.value += "0"; // 桁数が1つ大きくなる可能性があるため、桁設定
    for (int i = 0; i < b.value.size(); i++)
    {
        if (b.value[i] != '9')
        { // 9が続いたらそれまでの桁の数は0になる
            b.value[i] += 1;
            b.value = string(i, '0') + b.value.substr(i);
            break;
        }
    }
    this->set(b.str());
    return ret;
}

newint newint::operator--()
{ // 単項演算子の-- (--x)
    newint b(this);
    if (b.str() == "0")
    {
        b.set("-1"); // ハグるため
        this->set(b.str());
        return *this;
    }
    if (b.minus)
    { // 絶対値で演算を行うため
        b.minus=false; // 符号が負のままだと無限にループする
        ++b;
        this->set((-b).str());
        return *this;
    }
    for (int i = 0; i < b.value.size(); i++)
    {
        if (b.value[i] != '0')
        { // 9が続いたらそれまでの桁の数は0になる
            b.value[i] -= 1;
            b.value = string(i, '9') + b.value.substr(i);
            this->set(b.str());
            return *this;
        }
    }
    this->set("0"); // 処理が完了しないー＞0
    return *this;
}

newint newint::operator--(int n)
{ // 単項演算子の--(x--)
    newint b(this);
    newint ret(this); // 返り値、これは変化させない
    if (b.str() == "0")
    {
        b.set("-1"); // ハグるため
        this->set(b.str());
        return ret;
    }
    if (b.minus)
    { // 絶対値で演算を行うため
        b.minus=false; // 符号が負のままだと無限にループする
        b++;
        this->set((-b).str());
        return ret;
    }
    for (int i = 0; i < b.value.size(); i++)
    {
        if (b.value[i] != '0')
        { // 9が続いたらそれまでの桁の数は0になる
            b.value[i] -= 1;
            b.value = string(i, '9') + b.value.substr(i);
            this->set(b.str());
            return ret;
        }
    }
    this->set("0"); // 処理が完了しないー＞0
    return ret;
}

int newint::operator[](int n)
{ // a[n]、値の絶対値におけるn番目の数値を返す
    return (this->str(true))[n] - '0';
}

bool newint::operator<(newint a)
{ // b<a
    newint b(this);
    if (b.minus == !a.minus) // 異符号なら大小は明らか
        return b.minus;
    string a_str, b_str;
    a_str = a.str();
    b_str = b.str();
    if (!b.minus && !a.minus) // 同符号なら
    {
        if (a_str.size() > b_str.size()) // 文字数で比べる
            return true;
        if (a_str.size() < b_str.size())
            return false;
        for (int i = 0; i < a_str.size(); i++) // 各桁を比べる(valueではないので先頭の方が大きい桁)
        {
            if (a_str[i] > b_str[i])
                return true;
            if (a_str[i] < b_str[i])
                return false;
        }
    }
    if (b.minus && a.minus) // 負同士なら、正の結果の逆になる
        return -a < -b;     // b<a = -b>-a = -a<-b
    return false;
}

bool newint::operator<=(newint a)
{ // b<=a
    newint b(this);
    return (b == a || b < a);
}

bool newint::operator>(newint a)
{ // b>a
    newint b(this);
    return a < b;
}

bool newint::operator>=(newint a)
{ // b>=a
    newint b(this);
    return a <= b;
}

bool newint::operator==(newint a)
{ // b==a
    newint b(this);
    return (b.str() == a.str());
}

bool newint::operator!=(newint a)
{ // b!=a
    newint b(this);
    return !(b == a);
}

#endif
