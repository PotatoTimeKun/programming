/**
 * @file newfloat.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief newint.hを小数に対応させました。
 * 必須:newint.h
 * 
 */
#ifndef   A_HPP
#define   A_HPP
#include <string>
#include <algorithm>
#include <regex>
#include "newint.h"
using namespace std;
/**
 * @brief 多倍長小数?を扱います。
 * 演算子は四則演算子・比較演算子・単項演算子(++,--,-)・剰余演算子に対応しています。
 * 
 */
class newfloat
{
private:
    string val = "";
    string under = "";
    bool mi = false;
    void keta(int i,int j=0)
    {
        int cou = i - val.size();
        for (int l = 0; l< cou + 1; l++)
        {
            val += "0";
        }
        cou = j - under.size();
        for (int l = 0; l< cou + 1; l++)
        {
            under = "0" + under;
        }
    }

public:
    /**
     * @brief 値が空のnewfloatインスタンスを作成します。
     * 
     */
    newfloat() {}
    /**
     * @brief 値渡しでコピーしたnewfloatインスタンスを作成します。
     * 
     * @param a newfloatインスタンス
     */
    newfloat(newfloat *a)
    {
        val = a->val;
        under = a->under;
        mi = a->mi;
    }
    /**
     * @brief 渡した値を表すnewfloatインスタンスを作成します。
     * 
     * @param newv 値を表す文字列
     */
    newfloat(string newv)
    {
        newv+=".0";
        if(newv[0]=='-'){
            mi=true;
            newv=newv.substr(1);
        }
        regex v("-?(\\d+).?(\\d*)");
        smatch vma;
        if(regex_search(newv,vma,v)){
            val=vma[1].str();
            under=vma[2].str();
        }
        reverse(val.begin(), val.end());
        reverse(under.begin(), under.end());
    }
    /**
     * @brief 渡した値でインスタンスが表す値を設定します。
     * 
     * @param newv 値を表す文字列
     */
    void set(string newv)
    {
        newv+=".0";
        if(newv[0]=='-'){
            mi=true;
            newv=newv.substr(1);
        }
        regex v("-?(\\d+).?(\\d*)");
        smatch vma;
        if(regex_search(newv,vma,v)){
            val=vma[1].str();
            under=vma[2].str();
        }
        reverse(val.begin(), val.end());
        reverse(under.begin(), under.end());
    }
    /**
     * @brief インスタンスが表す値を文字列で返します。
     * 
     * @param z trueにすると絶対値を返します。
     * @return string インスタンスが表す値
     */
    string str(bool z = false)
    {
        string v(val);
        reverse(v.begin(), v.end());
        while ((v[0] == '0') && (v.size() != 1))
        {
            v = v.substr(1);
        }
        string u(under);
        while ((u[0] == '0') && (u.size() != 1))
        {
            u = u.substr(1);
        }
        reverse(u.begin(),u.end());
        if (mi && !z)
        {
            return "-" + v;
        }
        if (u!="0"){
            v+="."+u;
        }
        return v;
    }
    /**
     * @brief インスタンスが表す値を2進数に変換して返します。
     * 値が負数の時は"-"をつけて返します。
     * 
     * @return string 
     */
    string bin()
    {
        string v;
        newfloat b(str(true)), a("0"), w("2"), c;
        while (b > a)
        {
            c = b % w;
            v += c.str();
            b = b / w;
        }
        reverse(v.begin(), v.end());
        if (mi)
        {
            return "-" + v;
        }
        return v;
    }
    /**
     * @brief インスタンスが表す値を16進数に変換して返します。
     * 値が負数の時は"-"をつけて返します。
     * 
     * @return string 
     */
    string hex()
    {
        string v;
        newfloat b(str(true)), a("0"), w("16"), c;
        while (b > a)
        {
            c = b % w;
            switch (stoi(c.str()))
            {
            case 10:
                c.val = "a";
                break;
            case 11:
                c.val = "b";
                break;
            case 12:
                c.val = "c";
                break;
            case 13:
                c.val = "d";
                break;
            case 14:
                c.val = "e";
                break;
            case 15:
                c.val = "f";
                break;
            default:
                break;
            }
            v += c.str();
            b = b / w;
        }
        reverse(v.begin(), v.end());
        if (mi)
        {
            return "-" + v;
        }
        return v;
    }
    /**
     * @brief インスタンスが表す値を8進数に変換して返します。
     * 値が負数の時は"-"をつけて返します。
     * 
     * @return string 
     */
    string oct()
    {
        string v;
        newfloat b(str(true)), a("0"), w("8"), c;
        while (b > a)
        {
            c = b % w;
            v += c.str();
            b = b / w;
        }
        reverse(v.begin(), v.end());
        if (mi)
        {
            return "-" + v;
        }
        return v;
    }
    newfloat operator+(newfloat a);
    newfloat operator-(newfloat a);
    newfloat operator*(newfloat a);
    newfloat operator/(newfloat a);
    newfloat operator%(newfloat a);
    newfloat operator-();
    newfloat operator++();
    newfloat operator--();
    bool operator<(newfloat a);
    bool operator<=(newfloat a);
    bool operator>(newfloat a);
    bool operator>=(newfloat a);
    bool operator==(newfloat a);
    bool operator!=(newfloat a);
};
newfloat newfloat::operator+(newfloat a)
{
    newfloat ret, b(this);
    int c = 0, v, max,umax;
    (b.val.size() < a.val.size()) ? (max = a.val.size()) : (max = b.val.size());
    max++;
    (b.under.size() < a.under.size()) ? (umax = a.under.size()) : (umax = b.under.size());
    umax++;
    a.keta(max,umax);
    b.keta(max,umax);
    if (!b.mi && !a.mi || b.mi && a.mi)
    {
        int us=a.under.size();
        a.val=a.under+a.val;
        b.val=b.under+b.val;
        ret.mi = b.mi;
        for (int i = 0; i < max+umax; i++)
        {
            v = int(b.val[i] - '0') + int(a.val[i] - '0') + c;
            c = 0;
            if (v >= 10)
            {
                c = 1;
                v -= 10;
            }
            ret.val += to_string(v);
        }
        ret.under=ret.val.substr(0,us);
        ret.val=ret.val.substr(us);
    }
    if (!b.mi && a.mi)
    {
        newfloat ap(a.str(true));
        ret = b - ap;
    }
    if (b.mi && !a.mi)
    {
        newfloat bp(b.str(true));
        ret = a - bp;
    }
    return ret;
}
newfloat newfloat::operator-(newfloat a)
{
    newfloat ret, b(this);
    int c = 0, v, max,umax;
    (b.val.size() < a.val.size()) ? (max = a.val.size()) : (max = b.val.size());
    max++;
    (b.under.size() < a.under.size()) ? (umax = a.under.size()) : (umax = b.under.size());
    umax++;
    a.keta(max,umax);
    b.keta(max,umax);
    if (!b.mi && a.mi || b.mi && !a.mi)
    {
        ret = b + -a;
    }
    if (!b.mi && !a.mi)
    {
        if (a < b)
        {
            ret.mi = b.mi;
            int us=a.under.size();
            a.val=a.under+a.val;
            b.val=b.under+b.val;
            for (int i = 0; i < max+umax; i++)
            {
                v = int(b.val[i] - '0') - int(a.val[i] - '0') - c;
                c = 0;
                if (v < 0)
                {
                    c = 1;
                    v += 10;
                }
                ret.val += to_string(v);
            }
            ret.under=ret.val.substr(0,us);
            ret.val=ret.val.substr(us);
        }
        else if (a.str() == b.str())
        {
            ret.set("0");
        }
        else
        {
            ret = a - b;
            (ret.mi) ? (ret.mi = false) : (ret.mi = true);
        }
    }
    if (mi && a.mi)
    {
        ret = -a + b;
    }
    return ret;
}
newfloat newfloat::operator*(newfloat a)
{
    set(str());
    a.set(a.str());
    newfloat ret, b(this);
    int bs = b.val.size()+b.under.size(), as = a.val.size()+a.under.size(), v = 0;
    int n[as + bs];
    for (int i = 0; i < as + bs; i++)
    {
        n[i] = 0;
    }
    int us=a.under.size()+b.under.size();
    a.val=a.under+a.val;
    b.val=b.under+b.val;
    for (int i = 0; i < as; i++)
    {
        for (int j = 0; j < bs; j++)
        {
            v = int(a.val[i] - '0') * int(b.val[j] - '0');
            n[i + j] += v;
        }
    }
    int c = 0, ni = 0;
    for (int i = 0; i < as + bs; i++)
    {
        n[i] += c;
        ni = n[i];
        n[i] = (n[i]) % 10;
        c = ni / 10;
    }
    string r;
    for (int i = 0; i < as + bs; i++)
    {
        r += to_string(n[i]);
    }
    reverse(r.begin(), r.end());
    ret.set(r);
    ret.under=ret.val.substr(0,us);
    ret.val=ret.val.substr(us);
    if (!a.mi && !b.mi || a.mi && b.mi)
    {
        ret.mi = false;
    }
    if (!a.mi && b.mi || a.mi && !b.mi)
    {
        ret.mi = true;
    }
    return ret;
}
newfloat newfloat::operator/(newfloat a)
{
    set(str());
    a.set(a.str());
    newfloat ret, b(this);
    int us=a.under.size()-b.under.size()-10;
    b=b*new newfloat("10000000000000000000000000000000000000000");
    a=a*new newfloat("1000000000000000000000000000000");
    reverse(a.val.begin(), a.val.end());
    reverse(b.val.begin(), b.val.end());
    if(a.mi)a.val="-"+a.val;
    if(b.mi)b.val="-"+b.val;
    newint ai(a.val),bi(b.val);
    ret.set((bi/ai).str());
    if(us>0){
        while(us!=0){
            ret=ret*new newfloat("10");
            us--;
        }
    }else if(us<0){
        while(us!=0){
            ret=ret*new newfloat("0.1");
            us++;
        }
    }
    return ret;
}
newfloat newfloat::operator%(newfloat a)
{
    if(mi||a.mi){return new newfloat("0");}
    newfloat b(this), v, ret;
    v = b / a;
    reverse(v.val.begin(),v.val.end());
    newfloat vi(v.val);
    v = vi * a;
    ret = b - vi;
    return ret;
}
newfloat newfloat::operator-()
{
    newfloat ret(this);
    (ret.mi) ? (ret.mi = false) : (ret.mi = true);
    return ret;
};
bool newfloat::operator<(newfloat a)
{
    newfloat b(this);
    if (b.mi && !a.mi)
    {
        return true;
    }
    if (!b.mi && a.mi)
    {
        return false;
    }
    string ava,bva,aun,bun,ast=a.str(),bst=b.str();
    int umax;
    regex v("-?(\\d+).?(\\d*)");
    smatch ama,bma;
    if(regex_search(ast,ama,v)){
        ava=ama[1].str();
        aun=ama[2].str();
    }
    if(regex_search(bst,bma,v)){
        bva=bma[1].str();
        bun=bma[2].str();
    }
    (bun.size() < aun.size()) ? (umax = aun.size()-bun.size()) : (umax = bun.size()-aun.size());
    for (int l = 0; l< umax ; l++)
    {
        aun+="0";
        bun+="0";
    }
    if (!b.mi && !a.mi)
    {
        if (ava.size() > bva.size())
        {
            return true;
        }
        if (ava.size() < bva.size())
        {
            return false;
        }
        if (ast == bst)
        {
            return false;
        }
        for (int i = 0; i < ava.size(); i++)
        {
            int ai = int(ava[i] - '0');
            int bi = int(bva[i] - '0');
            if (ai > bi)
            {
                return true;
            }
            if (ai < bi)
            {
                return false;
            }
        }
        for (int i = 0; i < aun.size(); i++)
        {
            int ai = int(aun[i] - '0');
            int bi = int(bun[i] - '0');
            if (ai > bi)
            {
                return true;
            }
            if (ai < bi)
            {
                return false;
            }
        }
    }
    if (b.mi && a.mi)
    {
        return -a < -b;
    }
    return false;
}
bool newfloat::operator<=(newfloat a)
{
    newfloat b(this);
    if (b.str() == a.str())
    {
        return true;
    }
    return b < a;
}
bool newfloat::operator>(newfloat a)
{
    newfloat b(this);
    if (b.str() == a.str())
    {
        return false;
    }
    return a < b;
}
bool newfloat::operator>=(newfloat a)
{
    newfloat b(this);
    if (b.str() == a.str())
    {
        return true;
    }
    return b > a;
}
bool newfloat::operator==(newfloat a)
{
    newfloat b(this);
    if (b.str() == a.str())
    {
        return true;
    }
    return false;
}
bool newfloat::operator!=(newfloat a)
{
    newfloat b(this);
    if (b.str() == a.str())
    {
        return false;
    }
    return true;
}
#endif