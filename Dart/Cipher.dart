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
}
