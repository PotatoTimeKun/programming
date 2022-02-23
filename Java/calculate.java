/**
 * 数式を扱うクラスが入っています。
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * 
 */

import java.util.regex.*;
import java.math.*;
/**
 * 数式を扱うクラスです。
 * 四則演算はnormal関数,数学関数はadvance関数で行えます。
 * 
 */
public class calculate{
    /**
     * 引数の数式から四則演算を行います。
     * @param formula 数式
     * @return double 計算結果
     */
    static public double normal(String formula){
        Pattern kak=Pattern.compile("\\(([^\\(\\)]+)\\)");
        Matcher mat;
        mat=kak.matcher(formula);
        while(mat.find()){
            formula=formula.substring(0,mat.start())+BigDecimal.valueOf(normal(mat.group(1))).toPlainString()+formula.substring(mat.end());
            mat=kak.matcher(formula);
        }
        Pattern pat[]=new Pattern[2];
        Pattern mi=Pattern.compile("-\\d");
        Pattern isnum = Pattern.compile("\\d");
        pat[0]=Pattern.compile("(-?\\d\\.?\\d*)(\\*|/)(-?\\d\\.?\\d*)");
        pat[1]=Pattern.compile("(-?\\d\\.?\\d*)(\\+|-)(-?\\d\\.?\\d*)");
        mat=pat[0].matcher(formula);
        while(mat.find()){
            if(mat.group(2).equals("*"))formula=formula.substring(0,mat.start())+BigDecimal.valueOf(Double.valueOf(mat.group(1))*Double.valueOf(mat.group(3))).toPlainString()+formula.substring(mat.end());
            if(mat.group(2).equals("/"))formula=formula.substring(0,mat.start())+BigDecimal.valueOf(Double.valueOf(mat.group(1))/Double.valueOf(mat.group(3))).toPlainString()+formula.substring(mat.end());
            if(mat.start()>0 && mi.matcher(mat.group(1)).find()){if(isnum.matcher(formula.substring(mat.start()-1,mat.start())).find())formula=formula.substring(0,mat.start()-1)+"+"+formula.substring(mat.start());}
            mat=pat[0].matcher(formula);
        }
        mat=pat[1].matcher(formula);
        while(mat.find()){
            if(mat.group(2).equals("+"))formula=formula.substring(0,mat.start())+BigDecimal.valueOf(Double.valueOf(mat.group(1))+Double.valueOf(mat.group(3))).toPlainString()+formula.substring(mat.end());
            if(mat.group(2).equals("-"))formula=formula.substring(0,mat.start())+BigDecimal.valueOf(Double.valueOf(mat.group(1))-Double.valueOf(mat.group(3))).toPlainString()+formula.substring(mat.end());
            mat=pat[1].matcher(formula);
        }
        return Double.valueOf(formula);
    }
    /**
     * 引数の数式から演算を行います。
     * 対応関数
     * sin()，
        cos()，
        tan()，
        javaの乗算記号を2つ(Docstring上で表示されないため間接的に記号を説明しました) :累乗，
        root() :√
     * @param formula 数式
     * @return 計算結果
     */
    static public double advance(String formula){
        Pattern pat[]=new Pattern[6];
        pat[0]=Pattern.compile("sin\\(([\\+\\-\\*/\\.0-9]+)\\)");
        pat[1]=Pattern.compile("cos\\(([\\+\\-\\*/\\.0-9]+)\\)");
        pat[2]=Pattern.compile("tan\\(([\\+\\-\\*/\\.0-9]+)\\)");
        pat[3]=Pattern.compile("(\\d+\\.?\\d*)\\*\\*\\(?([\\+\\-\\*/\\.0-9]+)\\)?");
        pat[4]=Pattern.compile("root\\(([\\+\\-\\*/\\.0-9]+)\\)");
        pat[5]=Pattern.compile("\\((-?\\d+\\.?\\d*)\\)");
        Matcher mat;
        boolean doing=false;
        do{
            for(int i=0;i<6;i++){
                mat=pat[i].matcher(formula);
                if(mat.find()){
                    switch (i) {
                        case 0:
                            formula=formula.substring(0,mat.start())+BigDecimal.valueOf(Math.sin(normal(mat.group(1)))).toPlainString()+formula.substring(mat.end());
                            break;
                        case 1:
                            formula=formula.substring(0,mat.start())+BigDecimal.valueOf(Math.cos(normal(mat.group(1)))).toPlainString()+formula.substring(mat.end());
                            break;
                        case 2:
                            formula=formula.substring(0,mat.start())+BigDecimal.valueOf(Math.tan(normal(mat.group(1)))).toPlainString()+formula.substring(mat.end());
                            break;
                        case 3:
                            formula=formula.substring(0,mat.start())+BigDecimal.valueOf(Math.pow(Double.valueOf(mat.group(1)),(normal(mat.group(2))))).toPlainString()+formula.substring(mat.end());
                            break;
                        case 4:
                            formula=formula.substring(0,mat.start())+BigDecimal.valueOf(Math.sqrt(normal(mat.group(1)))).toPlainString()+formula.substring(mat.end());
                            break;
                        case 5:
                            formula=formula.substring(0,mat.start())+mat.group(1)+formula.substring(mat.end());
                            break;
                    }
                    System.out.println(formula);
                    doing=true;
                }
                else doing=false;
            }
        }while(doing);
        return normal(formula);
    }
}
