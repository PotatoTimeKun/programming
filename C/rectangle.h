#include <stdio.h>
#include <math.h>

#ifndef INCLUDE_RECTANGLE
#define INCLUDE_RECTANGLE

/**
 * @brief arcsinをテイラー展開して求めています
 * 
 * @param x double 
 * @return double 
 */
double arcsin(double x)
{
    double poweredX = x, n2kaijo = 1, nkaijo = 1, njou4 = 1, sumValue = 0;
    for (int i = 0; i < 100; i++)
    {
        double addValue = poweredX * (n2kaijo / (njou4 * nkaijo * nkaijo * (2 * i + 1)));
        if (addValue == 0. || isinf(addValue))
            return sumValue;
        sumValue += addValue;
        poweredX *= x * x;
        n2kaijo *= (2 * i + 1) * (2 * i + 2);
        nkaijo *= 2 * i + 1;
        njou4 *= 4;
    }
    return sumValue;
}

/**
 * @brief arctanをテイラー展開して求めています。
 * 
 * @param x double
 * @return double 
 */
double arctan(double x)
{
    double poweredX = x, sumValue = 0, sign = 1;
    for (int i = 0; i < 100; i++)
    {
        double addValue = sign * poweredX / (2 * i + 1);
        if (addValue == 0. || isinf(addValue))
            return sumValue;
        sumValue += addValue;
        poweredX *= x * x;
        sign *= -1;
    }
    return sumValue;
}

/**
 * @brief arccos x = pi/2 - arcsin x
 * 
 * @param x double 
 * @return double 
 */
double arccos(double x)
{
    double piPer2 = 2 * (2 * arctan(1. / 3) + arctan(1. / 7));
    return piPer2 - arcsin(x);
}

/**
 * @brief sinをテイラー展開して求めています。
 * 
 * @param x double
 * @return double 
 */
double mySin(double x)
{
    double sign = 1, kaijo = 1, poweredX = x, sumValue = 0;
    for (int i = 0; i < 100; i++)
    {
        double addValue = sign * poweredX / kaijo;
        if (addValue == 0. || isinf(addValue))
            return sumValue;
        sumValue += addValue;
        sign *= -1;
        poweredX *= x * x;
        kaijo *= (2 * i + 2) * (2 * i + 3);
    }
    return sumValue;
}

/**
 * @brief cosをテイラー展開して求めています。
 * 
 * @param x double
 * @return double 
 */
double myCos(double x)
{
    double sign = 1, kaijo = 1, poweredX = 1, sumValue = 0;
    for (int i = 0; i < 100; i++)
    {
        double addValue = sign * poweredX / kaijo;
        if (addValue == 0. || isinf(addValue))
            return sumValue;
        sumValue += addValue;
        sign *= -1;
        poweredX *= x * x;
        kaijo *= (2 * i + 1) * (2 * i + 2);
    }
    return sumValue;
}

/**
 * @brief tan x = sin x / cos x
 * 
 * @param x double
 * @return double 
 */
double myTan(double x)
{
    return mySin(x) / myCos(x);
}

#endif