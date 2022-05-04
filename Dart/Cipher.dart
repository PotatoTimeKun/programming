import 'dart:convert';

int a = ascii.encode('a')[0].toInt();
int z = ascii.encode('z')[0].toInt();
Function dec = ascii.decode;
Function enc = ascii.encode;

/**
 * 暗号を扱うクラスです
 */
class Cipher {
  /**
   * シーザー暗号を扱います。
   * mode "m":暗号化モード,"r":復号化モード
   * sentence 変換する文字列
   * shift シフトする数
   * ->return 暗号文または平文
   */
  static String ceasar(String mode, String sentence, int shift) {
    String ret = "";
    int p = 0;
    sentence = sentence.toLowerCase();
    var encoded = enc(sentence);
    if (mode == "m") {
      if (shift < 0) return ceasar("r", sentence, shift);
      encoded.forEach((i) {
        if (i >= a && i <= z)
          ret += dec([(a + (i - a + shift) % 26).toInt()]);
        else
          ret += dec([i]);
      });
      ret = ret.toUpperCase();
    } else if (mode == "r") {
      if (shift < 0) return ceasar("m", sentence, shift);
      encoded.forEach((i) {
        if (i >= a && i <= z) {
          p = (i - a - shift) % 26;
          if (p < 0) p += 26;
          ret += dec([a + p]);
        } else
          ret += dec([i]);
      });
    }
    return ret;
  }

  /**
   * ヴィジュネル暗号を扱います。
   * mode "m":暗号化モード,"r":復号化モード
   * sentence 変換する文字列
   * key 鍵
   */
  static String Vigenere(String mode, String sentence, String key) {
    String ret = "";
    key = key.toLowerCase();
    sentence = sentence.toLowerCase();
    var encoded = enc(sentence);
    var enc_key = enc(key);
    int ind_k = 0;
    if (mode == "m") {
      encoded.forEach((i) {
        if (ind_k == key.length) ind_k = 0;
        if (i >= a && i <= z)
          ret += dec([(a + (i + enc_key[ind_k] - 2 * a) % 26).toInt()]);
        else
          ret += dec([i]);
        ind_k++;
        ret = ret.toUpperCase();
      });
    } else if (mode == "r") {
      encoded.forEach((i) {
        if (ind_k == key.length) ind_k = 0;
        if (i >= a && i <= z) {
          int p = (i - enc_key[ind_k]) % 26;
          if (p >= 0)
            ret += dec([(a + p).toInt()]);
          else
            ret += dec([(a + 26 + p).toInt()]);
        } else
          ret += dec([i]);
        ind_k++;
      });
    }
    return ret;
  }

  /**
   * 単一換字式暗号を扱います。
   * mode "m":暗号化モード,"r":復号化モード
   * sentence 変換する文字列
   * key 鍵
   */
  static String substitution(String mode, String sentence, String key) {
    String ret = "";
    String abc = "abcdefghijklmnopqrstuvwxyz";
    sentence = sentence.toLowerCase();
    if (mode == "m") {
      for (int i = 0; i < sentence.length; i++) {
        try {
          ret += key[abc.indexOf(sentence[i])];
        } catch (e) {
          ret += sentence[i];
        }
      }
    }
    if (mode == "r") {
      for (int i = 0; i < sentence.length; i++) {
        try {
          ret += abc[key.indexOf(sentence[i])];
        } catch (e) {
          ret += sentence[i];
        }
      }
    }
    return ret;
  }

  /**
   * ポリュビオスの暗号表(5*5)を扱います。
   * 5*5の方式ではjとiの暗号が同じ結果になります。そのため、復号結果ではiはiのままjをiとします。
   * mode "m":暗号化モード,"r":復号化モード
   * sentence 変換する文字列
   * ->return 暗号文または平文
   */
  static String polybius_square(String mode, String sentence) {
    String ret = "", sent_t = "";
    sentence = sentence.toLowerCase();
    int j = enc('j')[0].toInt() - a;
    var encoded = enc(sentence);
    if (mode == "m") {
      encoded.forEach((c) {
        if (c >= a && c <= z) sent_t += dec(<int>[c.toInt()]);
      });
      encoded = enc(sent_t);
      for (int i = 0; i < sent_t.length; i++) {
        int c = encoded[i] - a;
        if (c >= j) c--;
        ret += (c / 5 + 1).toInt().toString();
        ret += (c % 5 + 1).toInt().toString();
      }
    } else if (mode == "r") {
      int e0 = enc("0")[0].toInt();
      int e1 = enc("1")[0].toInt();
      int e5 = enc("5")[0].toInt();
      encoded.forEach((c) {
        if (c >= e1 && c <= e5) sent_t += dec(<int>[c.toInt()]);
      });
      print("${5 * (encoded[2 * 0] - e0 - 1) + (encoded[2 * 0 + 1] - e0 - 1)}");
      encoded = enc(sent_t);
      for (int i = 0; i < (sent_t.length / 2).toInt(); i++) {
        int c = (a +
                (5 * (encoded[2 * i] - e0 - 1) + (encoded[2 * i + 1] - e0 - 1)))
            .toInt();
        if (c >= j + a) c++;
        ret += dec([c]);
      }
    }
    return ret;
  }

  /**
   * スキュタレー暗号を扱います。
   * ５列に分けて暗号化します。
   * mode "m":暗号化モード,"r":復号化モード
   * sentence 変換する文字列
   * ->return 暗号文または平文
   */
  static String scytale(String mode, String sentence) {
    String ret = "";
    var encoded = enc(sentence);
    var table = <List<int>>[
      <int>[0, 0, 0, 0, 0]
    ];
    if (mode == "m") {
      for (int i = 0; i < sentence.length; i++) {
        if (table.length <= (i / 5).toInt()) table.add(<int>[0, 0, 0, 0, 0]);
        table[(i / 5).toInt()][i % 5] = encoded[i];
      }
      for (int i = 0; i < 5; i++) {
        for (int j = 0; j < table.length; j++) {
          if (table[j][i] != 0) ret += dec(<int>[table[j][i]]);
        }
      }
    } else if (mode == "r") {
      for (int i = 0; i < sentence.length; i++) {
        if (table.length <= (i / 5).toInt()) table.add(<int>[0, 0, 0, 0, 0]);
        table[(i / 5).toInt()][i % 5] = encoded[i];
      }
      int k = 0;
      for (int i = 0; i < 5; i++) {
        for (int j = 0; j < table.length; j++) {
          if (table[j][i] != 0 && k < sentence.length) {
            table[j][i] = enc(sentence[k])[0].toInt();
            k++;
          }
        }
      }
      for (int i = 0; i < sentence.length; i++) {
        if (table[(i / 5).toInt()][i % 5] != 0)
          ret += dec([table[(i / 5).toInt()][i % 5]]);
      }
    }
    return ret;
  }
}
