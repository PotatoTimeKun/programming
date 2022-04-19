/**
 * 暗号を扱います。
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * 
 */

import java.util.List;
import java.util.stream.Collectors;

/**
 * 暗号を扱うクラスです。
 * シーザー暗号・ヴィジュネル暗号・単一換字式暗号に対応しています。
 * いずれもstaticな関数として入っています。
 */
public class Cipher {
    /**
     * シーザー暗号を扱います。
     * 
     * @param mode "m":暗号化モード，"r":復号化モード
     * @param sentence 変換する文字列
     * @param shift シフトする数
     * @return String 暗号文または平文
     */
    static public String ceasar(String mode, String sentence, int shift) {
        sentence = sentence.toLowerCase();
        int a = 'a', z = 'z';
        List<Integer> list = sentence.chars().boxed().collect(Collectors.toList());
        String ret = "";
        if (mode == "m") {
            if (shift < 0)
                return ceasar("r", sentence, -shift);
            for (int i : list)
                if (i >= a && i <= z)
                    ret += Character.toString(a + (i - a + shift) % 26);
                else
                    ret += Character.toString(i);
            ret = ret.toUpperCase();
        }
        if (mode == "r") {
            if (shift < 0)
                return ceasar("m", sentence, -shift);
            for (int i : list) {
                if (i >= a && i <= z) {
                    int p = (i - a - shift) % 26;
                    if (p < 0)
                        p = 26 + p;
                    ret += Character.toString(a + p);
                } else
                    ret += Character.toString(i);
            }
        }
        if (ret != "")
            return ret;
        return "error";
    }

    /**
     * ヴィジュネル暗号を扱います。
     * 
     * @param mode "m":暗号化モード，"r":復号化モード
     * @param sentence 変換する文字列
     * @param key 鍵
     * @return String 暗号文または平文
     */
    static public String vigenere(String mode, String sentence, String key) {
        int a = 'a', z = 'z';
        key = key.toLowerCase();
        sentence = sentence.toLowerCase();
        List<Integer> list_sen = sentence.chars().boxed().collect(Collectors.toList());
        List<Integer> list_key = key.chars().boxed().collect(Collectors.toList());
        int b = 0;
        String ret = "";
        if (mode == "m") {
            for (int i : list_sen) {
                if (b == key.length())
                    b = 0;
                if (i >= a && i <= z)
                    ret += Character.toString(a + (i + list_key.get(b) - 2 * a) % 26);
                else
                    ret += Character.toString(i);
                b++;
            }
            ret = ret.toUpperCase();
        }
        if (mode == "r") {
            for (int i : list_sen) {
                if (b == key.length())
                    b = 0;
                if (i >= a && i <= z) {
                    if ((i - list_key.get(b)) % 26 >= 0)
                        ret += Character.toString(a + (i - list_key.get(b)) % 26);
                    else
                        ret += Character.toString(a + 26 + (i - list_key.get(b)) % 26);
                } else
                    ret += Character.toString(i);
                b++;
            }
        }
        if (ret != "")
            return ret;
        return "error";
    }

    /**
     * 単一換字式暗号を扱います。
     * 
     * @param mode "m":暗号化モード，"r":復号化モード
     * @param sentence 変換する文字列
     * @param key 鍵(a-zに対応した文字列)
     * @return String 暗号文または平文
     */
    static public String substitution(String mode, String sentence, String key) {
        String abc = "abcdefghijklmnopqrstuvwxyz";
        String ret = "";
        if (mode == "m") {
            for (int i = 0; i < sentence.length(); i++)
                ret += key.charAt(abc.indexOf(sentence.charAt(i)));
        }
        if (mode == "r") {
            for (int i = 0; i < sentence.length(); i++)
                ret += abc.charAt(key.indexOf(sentence.charAt(i)));
        }
        if (ret != "")
            return ret;
        return "error";
    }

    /**
     * ポリュビオスの暗号表(5*5)を扱います。
     * 5*5の方式ではjとiの暗号が同じ結果になります。そのため、復号結果ではiはiのままjをiとします。
     * 平文ではa-z以外の文字(空白も含む)は除いてください。
     * 暗号文では0と1以外の文字(空白も含む)は除いてください。
     * 
     * @param mode "m":暗号化モード，"r":復号化モード
     * @param sentence 変換する文字列
     * @return String 暗号文または平文
     */
    public static String polybius_square(String mode,String sentence){
        String ret="";
        List<Integer> list_sen = sentence.chars().boxed().collect(Collectors.toList());
        int a='a',j='j';
        if(mode=="m"){
            for(int i=0;i<sentence.length();i++){
                int c=list_sen.get(i)-a;
                if(c>=j)c--;
                ret+=Integer.toString(c/5+1);
                ret+=Integer.toString(c%5+1);
            }
        }
        if(mode=="r"){
            for(int i=0;i<sentence.length()/2;i++){
                int c=a+(5*(list_sen.get(2*i)-(int)'0'-1)+(list_sen.get(2*i+1)-(int)'0'-1));
                if(c>=j)c++;
                ret+=Character.toString(c);
            }
        }
        return ret;
    }
    /**
     * スキュタレー暗号を扱います。
     * 5行に分けて暗号化します。
     *
     * @param mode "m":暗号化モード，"r":復号化モード
     * @param sentence 変換する文字列
     * @return String 暗号文または平文
     */
    public static String scytale(String mode,String sentence){
        String ret="";
        List<Integer> list_sen = sentence.chars().boxed().collect(Collectors.toList());
        List<ArrayList<Integer>> table=new ArrayList<>();
        List<Integer> inner=new ArrayList<>();
        if(mode=="m"){
            for(int i=0;i<5;i++)inner.add(0);
            table.add(inner);
            for(int i=0;i<sentence.length();i++){
                if(table.size()<=i/5){
                    inner=new ArrayList<>();
                    for(int j=0;j<5;j++)inner.add(0);
                    table.add(inner);
                }
                inner=table.get(i/5);
                inner.set(i%5,list_sen.get(i));
                table.set(i/5,inner);
            }
            for(int i=0;i<5;i++){
                for(int j=0;j<table.size();j++){
                    if((table.get(j)).get(i)!=0)ret+=Character.toString((table.get(j)).get(i));
                }
            }
        }
        if(mode=="r"){
            for(int i=0;i<5;i++)inner.add(0);
            table.add(inner);
            for(int i=0;i<sentence.length();i++){
                if(table.size()<=i/5){
                    inner=new ArrayList<>();
                    for(int j=0;j<5;j++)inner.add(0);
                    table.add(inner);
                }
                inner=table.get(i/5);
                inner.set(i%5,list_sen.get(i));
                table.set(i/5,inner);
            }
            int k=0;
            for(int i=0;i<5;i++){
                for(int j=0;j<table.size();j++){
                    if(k<sentence.length() && (table.get(j)).get(i)!=0){
                        inner=table.get(j);
                        inner.set(i,list_sen.get(k));
                        table.set(j,inner);
                        k++;
                    }
                }
            }
            for(int i=0;i<sentence.length();i++){{
                if((table.get(i/5)).get(i%5)!=0)ret+=Character.toString((table.get(i/5)).get(i%5)!=0);
            }
        }
        return ret;//*未テスト
    }
}
