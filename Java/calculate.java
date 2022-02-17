import java.io.*;
import java.util.regex.*;
import java.util.*;
import java.lang.*;
import java.math.*;
public class calculate{
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
