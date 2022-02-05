#ifndef Include_newint
#define Include_newint
#include <string>
#include <algorithm>
using namespace std;
class newint
{
private:
    string val = "";
    bool mi = false;
    void keta(int i)
    {
        int cou = i - val.size();
        for (int j = 0; j < cou + 1; j++)
        {
            val += "0";
        }
    }

public:
    newint() {}
    newint(newint *a)
    {
        val = a->val;
        mi = a->mi;
    }
    newint(string newv)
    {
        if (newv[0] == '-')
        {
            val = newv.substr(1);
            mi = true;
        }
        else
        {
            val = newv;
        }
        reverse(val.begin(), val.end());
    }
    void set(string newv)
    {
        if (newv[0] == '-')
        {
            val = newv.substr(1);
            mi = true;
        }
        else
        {
            val = newv;
        }
        reverse(val.begin(), val.end());
    }
    string str(bool z = false)
    {
        string v(val);
        reverse(v.begin(), v.end());
        while ((v[0] == '0') && (v.size() != 1))
        {
            v = v.substr(1);
        }
        if (mi && !z)
        {
            return "-" + v;
        }
        return v;
    }
    string bin()
    {
        string v;
        newint b(str(true)), a("0"), w("2"), c;
        while (b > a)
        {
            c = b % w;
            v += c.str();
            b = b / w;
        }
        reverse(v.begin(), v.end());
        if (mi) return "-" + v;
        return v;
    }
    string hex()
    {
        string v;
        newint b(str(true)), a("0"), w("16"), c;
        while (b > a)
        {
            c = b % w;
            switch (stoi(c.str()))
            {
            case 10:
                c.val = "A";
                break;
            case 11:
                c.val = "B";
                break;
            case 12:
                c.val = "C";
                break;
            case 13:
                c.val = "D";
                break;
            case 14:
                c.val = "E";
                break;
            case 15:
                c.val = "F";
                break;
            default:
                break;
            }
            v += c.str();
            b = b / w;
        }
        reverse(v.begin(), v.end());
        if (mi) return "-" + v;
        return v;
    }
    string oct()
    {
        string v;
        newint b(str(true)), a("0"), w("8"), c;
        while (b > a)
        {
            c = b % w;
            v += c.str();
            b = b / w;
        }
        reverse(v.begin(), v.end());
        if (mi) return "-" + v;
        return v;
    }
    newint operator+(newint a);
    newint operator-(newint a);
    newint operator*(newint a);
    newint operator/(newint a);
    newint operator%(newint a);
    newint operator-();
    newint operator++();
    newint operator--();
    bool operator<(newint a);
    bool operator<=(newint a);
    bool operator>(newint a);
    bool operator>=(newint a);
    bool operator==(newint a);
    bool operator!=(newint a);
};
newint newint::operator+(newint a)
{
    newint ret, b(this);
    int c = 0, v, max;
    (b.val.size() < a.val.size()) ? (max = a.val.size()) : (max = b.val.size());
    max++;
    a.keta(max);
    b.keta(max);
    if (!b.mi && !a.mi || b.mi && a.mi)
    {
        ret.mi = b.mi;
        for (int i = 0; i < max; i++)
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
    }
    if (!b.mi && a.mi)
    {
        newint ap(a.str(true));
        ret = b - ap;
    }
    if (b.mi && !a.mi)
    {
        newint bp(b.str(true));
        ret = a - bp;
    }
    return ret;
}
newint newint::operator-(newint a)
{
    newint ret, b(this);
    int c = 0, v, max;
    (b.val.size() < a.val.size()) ? (max = a.val.size()) : (max = b.val.size());
    max++;
    a.keta(max);
    b.keta(max);
    if (!b.mi && a.mi || b.mi && !a.mi) ret = b + -a;
    if (!b.mi && !a.mi)
    {
        if (a < b)
        {
            ret.mi = b.mi;
            for (int i = 0; i < max; i++)
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
        }
        else if (a.str() == b.str()) ret.set("0");
        else
        {
            ret = -a - -b;
            ret.mi = true;
        }
    }
    if (mi && a.mi) ret = -a + b;
    return ret;
}
newint newint::operator*(newint a)
{
    set(str());
    a.set(a.str());
    newint ret, b(this);
    int bs = b.val.size(), as = a.val.size(), v = 0;
    int n[as + bs];
    for (int i = 0; i < as + bs; i++) n[i] = 0;
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
    for (int i = 0; i < as + bs; i++) ret.val += to_string(n[i]);
    if (!a.mi && !b.mi || a.mi && b.mi) ret.mi = false;
    if (!a.mi && b.mi || a.mi && !b.mi) ret.mi = true;
    return ret;
}
newint newint::operator/(newint a)
{
    set(str());
    a.set(a.str());
    newint ret, b(this);
    if (!a.mi && !b.mi || a.mi && b.mi) ret.mi = false;
    if (!a.mi && b.mi || a.mi && !b.mi) ret.mi = true;
    a.mi=false;
    b.mi=false;
    int bs = b.val.size(), as = a.val.size();
    auto f = [](newint a, newint x) { return a * x; };
    newint ati[11];
    for (int i = 0; i < 11; i++) ati[i] = f(a, new newint(to_string(i)));
    if (as > bs)
    {
        ret.set("0");
        return ret;
    }
    for (int i = 0; i <= bs - as; i++)
    {
        string s = b.str(true);
        while (s.size() <= str(true).size()) s = "0" + s;
        newint r(s.substr(i, as + 1));
        for (int j = 1; j < 11; j++)
        {
            if (r < ati[j])
            {
                ret.val += to_string(j - 1);
                newint m;
                m = ati[j - 1];
                for (int p = 0; p < (bs - as - i); p++) m = m * new newint("10");
                b = b - m;
                break;
            }
        }
    }
    reverse(ret.val.begin(), ret.val.end());
    return ret;
}
newint newint::operator%(newint a)
{
    newint b(this), v, ret;
    v = b / a;
    v = v * a;
    ret = b - v;
    return ret;
}
newint newint::operator-()
{
    newint ret(this);
    (ret.mi) ? (ret.mi = false) : (ret.mi = true);
    return ret;
};
newint newint::operator++()
{
    newint b(this);
    b = b + new newint("1");
    set(b.str());
    return *this;
}
newint newint::operator--()
{
    newint b(this);
    b = b - new newint("1");
    set(b.str());
    return *this;
}
bool newint::operator<(newint a)
{
    newint b(this);
    if (a.str()=="0"||a.str()=="-0"&&b.str()=="0"||b.str()=="-0") return false;
    if (b.mi && !a.mi) return true;
    if (!b.mi && a.mi) return false;
    string ast, bst;
    ast = a.str();
    bst = b.str();
    if (!b.mi && !a.mi)
    {
        if (ast.size() > bst.size()) return true;
        if (ast.size() < bst.size()) return false;
        if (ast == bst) return false;
        for (int i = 0; i < ast.size(); i++)
        {
            int ai = int(ast[i] - '0');
            int bi = int(bst[i] - '0');
            if (ai > bi) return true;
            if (ai < bi) return false;
        }
    }
    if (b.mi && a.mi) return -a < -b;
    return false;
}
bool newint::operator<=(newint a)
{
    newint b(this);
    if (b == a) return true;
    return b < a;
}
bool newint::operator>(newint a)
{
    newint b(this);
    return a < b;
}
bool newint::operator>=(newint a)
{
    newint b(this);
    return a <= b;
}
bool newint::operator==(newint a)
{
    newint b(this);
    if (b.str() == a.str())
    {
        return true;
    }
    return false;
}
bool newint::operator!=(newint a)
{
    newint b(this);
    if (b.str() == a.str())
        return false;
    return true;
}
#endif