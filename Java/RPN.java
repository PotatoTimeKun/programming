
/**
 * 逆ポーランド記法を扱います。
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * 
 */

import java.io.*;
import java.util.regex.*;
import java.util.*;

/**
 * RPN(逆ポーランド記法)を扱うクラスです。makeRPN関数とRPN_cal関数が入っています。(どちらもstatic)
 */
public class RPN {
    public static void main(String[] args) throws IOException {
        System.out.println("you can use \"1~9.()+-*/\"\nwrite formula");
        BufferedReader read = new BufferedReader(new InputStreamReader(System.in));
        String form = read.readLine();
        System.out.println("=" + makeRPN(form));
        System.out.println("=" + String.valueOf(RPN_cal(makeRPN(form))));
    }

    /**
     * 中置記法の数式をRPNに変換します。
     * 数字は[]で囲んで返されます。
     * 
     * @param form 数式
     * @return String RPN
     */
    static String makeRPN(String form) {
        form = "(" + form + ")"; // 一時的に()を付ける
        Pattern minus_pattern = Pattern.compile("\\((-\\d+\\.?\\d*)\\)"); // 負数のパターン
        Matcher matcher = minus_pattern.matcher(form); // マッチャー
        while (matcher.find()) { // 負数を全て[]で囲む
            form = form.substring(0, matcher.start()) + "[" + matcher.group(1) + "]" + form.substring(matcher.end());
            matcher = minus_pattern.matcher(form);
        }
        Pattern plus_pattern = Pattern.compile("[^\\[0-9](\\d+\\.?\\d*)[^\\]0-9]"); // 正数のパターン
        matcher = plus_pattern.matcher(form);
        while (matcher.find()) { // 正数を全て[]で囲む
            form = form.substring(0, matcher.start(1)) + "[" + matcher.group(1) + "]" + form.substring(matcher.end(1));
            matcher = plus_pattern.matcher(form);
        }
        form = form.substring(1, form.length() - 1); // 一時的に付けた()を外す
        boolean stop = false; // ()が出たときに処理を切り替えるため
        int bracket_count = 0; // 現在位置の文字で()の重なっている個数
        String ret = ""; // 返り値
        String inner_string = ""; // ()内の文字列
        Deque<Character> stack = new ArrayDeque<>(); // スタック
        for (char c : form.toCharArray()) { // 文字を先頭から1つずつ取り出す
            if (!stop) { // ()内でなければ
                switch (c) {
                    case '+':
                    case '-': // +と-の優先度は同じなので同じ処理をする
                        if (ret.charAt(ret.length() - 1) == '[') { // 前の文字が[なら
                            ret += c; // 負数を示す-なのでそのまま追加
                            break; // これ以降は減算の処理なのでbreak
                        }
                        while (!stack.isEmpty()) {
                            ret += stack.pop(); // スタックの中身を全て追加
                        }
                        stack.push(c); // スタックに演算子をプッシュ
                        break;
                    case '*':
                    case '/': // *と/の優先度は同じ
                        if (!stack.isEmpty()) { // 1度しか行われない
                            if (stack.peek() == '*' || stack.peek() == '/')
                                ret += stack.pop();
                            // +や-より優先度が高いので、*と/のみ追加
                        }
                        stack.push(c); // 演算子をプッシュ
                        break;
                    case '(':
                        stop = true; // ()が来たら処理を変える
                        bracket_count = 1; // ()のカウントは1に
                        break;
                    default:
                        ret += c;
                        break;
                }
            } else { // ()内の処理
                switch (c) {
                    case '(':
                        bracket_count++; // (ならカウントを増やす
                        inner_string += c;
                        break;
                    case ')':
                        if (--bracket_count == 0) { // )ならカウントを減らし、それが0なら
                            ret += makeRPN(inner_string.toString()); // ()内で再帰処理
                            stop = false; // ()内の処理を抜ける
                        } else
                            inner_string += c;
                        break;
                    default:
                        inner_string += c;
                        break;
                }
            }
        }
        while (!stack.isEmpty())
            ret += stack.pop(); // スタックに残ったものを追加する
        return ret;
    }

    /**
     * RPNを計算した結果を返します。
     * 文字式には対応していません。
     * 
     * @param form RPN
     * @return Double 計算結果
     */
    static Double RPN_cal(String form) {
        char[] formc = form.toCharArray();
        double ret, val, valf, vall;
        String keep = "";
        Deque<String> sta = new ArrayDeque<>();
        for (char c : formc) {
            switch (c) {
                case '[':
                    keep = "[";
                    break;
                case ']':
                    sta.addFirst(keep.substring(1));
                    keep = "";
                    break;
                case '+':
                    val = Double.valueOf(sta.removeFirst()) + Double.valueOf(sta.removeFirst());
                    sta.addFirst(String.valueOf(val));
                    break;
                case '-':
                    if (keep == "[") {
                        keep += String.valueOf(c);
                        break;
                    }
                    valf = Double.valueOf(sta.removeFirst());
                    vall = Double.valueOf(sta.removeFirst());
                    sta.addFirst(String.valueOf(vall - valf));
                    break;
                case '*':
                    val = Double.valueOf(sta.removeFirst()) * Double.valueOf(sta.removeFirst());
                    sta.addFirst(String.valueOf(val));
                    break;
                case '/':
                    valf = Double.valueOf(sta.removeFirst());
                    vall = Double.valueOf(sta.removeFirst());
                    sta.addFirst(String.valueOf(vall / valf));
                    break;
                default:
                    keep += c;
                    break;
            }
        }
        ret = Double.valueOf(sta.removeFirst());
        return ret;
    }
}
