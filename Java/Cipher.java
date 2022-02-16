import java.util.List;
import java.util.stream.Collectors;

public class Cipher {
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
}
