import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 合同法乱数を扱うクラス
class Random {
  /// デフォルトでは時間を乱数の種とする
  Random() {
    for (int i = 0; i < 100; i++) {
      rnd.add(0); // rnd配列を0で初期化
    }
  }

  /// インスタンスの宣言と同時に種を指定
  Random.seedSet(this.seed_number) {
    seed(seed_number);
    for (int i = 0; i < 100; i++) {
      rnd.add(0); // rnd配列を0で初期化
    }
  }

  /// 乱数を格納する配列、直接アクセスするのではなくgetメソッドを使用すること
  var rnd = <int>[];

  /// rnd配列のインデックス、クラス外からのアクセスは推奨しない
  int index = 100;

  /// 現在使用している乱数の種、クラス外へは読み込みのみ推奨、書き込まないこと
  int seed_number = -1;

  /// 乱数の種を指定し、乱数を作り直す
  void seed(int n) {
    //合同法乱数の漸化式
    // x[0]=b
    // x[k+1]=(x[k]*a)%m
    seed_number = n;
    index = 0;
    int max; //乱数の周期
    var sosu = <int>[
      //漸化式のmになる
      1000003,
      1000033,
      1000037,
      1000039,
      1000081,
      1000099,
      1000117,
      1000121,
      1000133,
      1000151
    ];
    int count = 0; //while文を通った回数
    do {
      max = 100;
      rnd[0] = n % 500 + 1;
      for (int i = 0; i < 99; i++) {
        // ((n+count)%501+100) <- a , rnd[i] <- x[k] , sosu[n%10] <- m
        rnd[i + 1] = (((n + count) % 501 + 100) * rnd[i]) % sosu[n % 10];
        if (rnd[i + 1] == rnd[0]) {
          // 計算した乱数が最初(b)と同じなら一周期
          max = i;
        }
      }
      count++;
    } while (max < 100); //周期が100以上になるまで
  }

  /// 乱数を返す関数、実行する毎に値が変化する
  int get() {
    if (seed_number == -1) {
      //-1は初期値→時間を種とする
      DateTime now = DateTime.now();
      seed(now.second +
          now.minute * 60 +
          now.hour * 60 * 60 +
          now.day * 60 * 60 * 24 +
          now.month * 60 * 60 * 24 * 31);
      index = 0;
    }
    if (index > 99) {
      //インデックスが最大になったら、乱数を次の種で作る
      seed(++seed_number);
    }
    index++;
    return rnd[index - 1];
  }
}

/// 将棋の盤面やゲームの進みを管理するクラス
class ShogiManage {
  /// 普通の将棋の盤面で初期化
  ShogiManage() {
    shogiTable = [
      [0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 2, 0, 0]
    ];
  }

  /// 王が1人5個の盤面で初期化
  ShogiManage.notShogi() {
    shogiTable = [
      [1, 0, 1, 0, 1],
      [0, 1, 0, 1, 0],
      [0, 0, 0, 0, 0],
      [0, 2, 0, 2, 0],
      [2, 0, 2, 0, 2]
    ];
  }

  /// 爆弾5個をランダムに置いた盤面で初期化
  void bakudan() {
    shogiTable = [
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 2, 0, 0]
    ];
    int bakudanCount = 5, locate = 0;
    while (true) {
      if (rnd.get() % 24 == 0 && shogiTable[locate ~/ 5][locate % 5] == 0) {
        shogiTable[locate ~/ 5][locate % 5] = 3;
        bakudanCount--;
      }
      if (bakudanCount == 0) break;
      locate = (locate + 1) % 25;
    }
  }

  /// データをセーブする関数
  /// key : ゲームモード(shogi?/shogi/notshogi/ban)
  /// value : ターン数
  Future<void> saveGame(String key, int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    max = pref.getInt("Max$key") ?? -1;
    if (max < value) {
      pref.setInt("Max$key", value);
      max = value;
    }
    min = pref.getInt("Min$key") ?? -1;
    if ((min == -1 || min > value) && value != -1) {
      pref.setInt("Min$key", value);
      min = value;
    }
  }

  Future<void> savePlay(String mode, int seed, int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList("replay") ?? [];
    list.add(mode);
    list.add(seed.toString());
    list.add(index.toString());
    pref.setStringList("replay", list);
  }

  /// デバッグ用、ゲームデータ削除
  Future<void> _deleteSave() async {
    var keys = ["shogi?", "shogi", "notshogi", "ban", "yoke"];
    SharedPreferences pref = await SharedPreferences.getInstance();
    for (int i = 0; i < keys.length; i++) {
      pref.remove("Max${keys[i]}");
      pref.remove("Min${keys[i]}");
    }
  }

  /// 最小ターン数(saveGame関数実行時に更新)
  int min = -1;

  /// 最大ターン数(saveGame関数実行時に更新)
  int max = -1;

  /// ターン数のカウント
  int turnCount = 0;

  /// SEのボリューム
  static double volume = 1;

  /// SEを流すためのプレーヤー
  AudioPlayer _player = AudioPlayer();
  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );

  /// 乱数用、クラス外からアクセスしない
  var rnd = Random();

  /// 現在のターン、0=自分、1=コンピューター
  int turn = 0;

  /// 勝者表示用
  String winner = "";

  /// ターン表示用
  String player = "あなたのターンです";

  /// 現在の駒の位置、クラス外からアクセスしない
  var komaNow = [0, 2, 4, 2];

  /// 将棋の盤面、5*5、空=0、自分=2、相手=1
  var shogiTable;

  /// 縦の位置i(0~4)と横の位置j(0~4)からその位置の様子を返す
  Widget koma(int i, int j) {
    int n = shogiTable[i][j];
    if (n == 1) {
      return RotatedBox(
          quarterTurns: 2,
          child: Image.asset(
            "images/ou_red.png",
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          ));
    }
    if (n == 2) {
      return Image.asset(
        "images/ou_blue.png",
        height: 80,
        width: 80,
        fit: BoxFit.fill,
      );
    }
    if (n == 3) {
      return Image.asset(
        "images/bakudan.png",
        height: 80,
        width: 80,
        fit: BoxFit.fill,
      );
    }
    if (n == 4) {
      return Image.asset(
        "images/ban.png",
        height: 80,
        width: 80,
        fit: BoxFit.fill,
      );
    }
    return const SizedBox(
      width: 80,
      height: 80,
    );
  }

  /// 返り値が、0->勝者なし、1->相手の勝ち、2->自分の勝ち
  int win() {
    bool g1 = false, g2 = false;
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if (shogiTable[i][j] == 1) g1 = true;
        if (shogiTable[i][j] == 2) g2 = true;
      }
    }
    if (g1 && !g2) return 1;
    if (!g1 && g2) return 2;
    return 0;
  }

  /// 盤面を次へ進める、将棋?用
  Future<void> next() async {
    if (win() != 0) return;
    if (turn == 0) {
      turnCount++;
      shogiTable[komaNow[2]][komaNow[3]] = 0;
      komaNow[2] = rnd.get() % 5;
      komaNow[3] = rnd.get() % 5;
      shogiTable[komaNow[2]][komaNow[3]] = 2;
    } else if (turn == 1) {
      shogiTable[komaNow[0]][komaNow[1]] = 0;
      komaNow[0] = rnd.get() % 5;
      komaNow[1] = rnd.get() % 5;
      shogiTable[komaNow[0]][komaNow[1]] = 1;
    }
    if (win() == 0) {
      turn = turn == 0 ? 1 : 0;
      player = turn == 0 ? "あなたのターンです" : "あいてのターンです";
      if (turn == 1) {}
    } else if (win() == 1) {
      saveGame("shogi", turnCount);
      winner = "You lose...";
    } else if (win() == 2) {
      saveGame("shogi", turnCount);
      winner = "You win!";
    }
    _player = await _cache.play('koma.wav');
    _player.setVolume(ShogiManage.volume);
  }

  /// 盤面を次へ進める、将棋!用
  Future<void> nextShogi() async {
    if (win() != 0) return;
    if (turn == 0) {
      turnCount++;
      shogiTable[komaNow[2]][komaNow[3]] = 0;
      while (true) {
        int tate = (rnd.get() % 2 == 1 ? -1 : 1) * (rnd.get() % 2);
        int yoko = (rnd.get() % 2 == 1 ? -1 : 1) * (rnd.get() % 2);
        if (!(tate == 0 && yoko == 0) &&
            komaNow[2] + tate < 5 &&
            komaNow[2] + tate > -1 &&
            komaNow[3] + yoko < 5 &&
            komaNow[3] + yoko > -1) {
          komaNow[2] += tate;
          komaNow[3] += yoko;
          break;
        }
      }
      shogiTable[komaNow[2]][komaNow[3]] = 2;
    } else if (turn == 1) {
      shogiTable[komaNow[0]][komaNow[1]] = 0;
      while (true) {
        int tate = (rnd.get() % 2 == 1 ? -1 : 1) * (rnd.get() % 2);
        int yoko = (rnd.get() % 2 == 1 ? -1 : 1) * (rnd.get() % 2);
        if (!(tate == 0 && yoko == 0) &&
            komaNow[0] + tate < 5 &&
            komaNow[0] + tate > -1 &&
            komaNow[1] + yoko < 5 &&
            komaNow[1] + yoko > -1) {
          komaNow[0] += tate;
          komaNow[1] += yoko;
          break;
        }
      }
      shogiTable[komaNow[0]][komaNow[1]] = 1;
    }
    if (win() == 0) {
      turn = turn == 0 ? 1 : 0;
      player = turn == 0 ? "あなたのターンです" : "あいてのターンです";
      if (turn == 1) {}
    } else if (win() == 1) {
      saveGame("shogi?", turnCount);
      winner = "You lose...";
    } else if (win() == 2) {
      saveGame("shogi?", turnCount);
      winner = "You win!";
    }
    _player = await _cache.play('koma.wav');
    _player.setVolume(ShogiManage.volume);
  }

  /// 盤面を次へ進める、将棋ではない用
  Future<void> nextNotShogi() async {
    if (win() != 0) return;
    int turnKoma = (turn == 0) ? 2 : 1;
    if (turn == 0) turnCount++;
    while (true) {
      bool breaking = false; //while文を抜けるかどうか
      int selected = rnd.get() % 5 + 1; //5個ある内の動かす駒を決める
      var komaNow = [rnd.get() % 5, rnd.get() % 5];
      int count = 0; //これがselectedと同じになるまでカウントを進める
      for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
          if (shogiTable[i][j] == turnKoma) {
            count++;
          }
          if (count == selected) {
            //現在のi,jの位置の駒が動かす駒
            while (shogiTable[komaNow[0]][komaNow[1]] == turnKoma) {
              komaNow = [rnd.get() % 5, rnd.get() % 5];
            } //仲間の駒は取らない
            shogiTable[komaNow[0]][komaNow[1]] = turnKoma;
            shogiTable[i][j] = 0;
            breaking = true;
            count++;
          }
        }
      }
      if (breaking) break;
    }
    if (win() == 0) {
      turn = turn == 0 ? 1 : 0;
      player = turn == 0 ? "あなたのターンです" : "あいてのターンです";
      if (turn == 1) {}
    } else if (win() == 1) {
      saveGame("notshogi", turnCount);
      winner = "You lose...";
    } else if (win() == 2) {
      saveGame("notshogi", turnCount);
      winner = "You win!";
    }
    _player = await _cache.play('koma.wav');
    _player.setVolume(ShogiManage.volume);
  }

  Future<void> nextBan() async {
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if (shogiTable[i][j] == 4) return;
      }
    }
    turnCount++;
    shogiTable[komaNow[2]][komaNow[3]] = 0;
    while (true) {
      int tate = (rnd.get() % 2 == 1 ? -1 : 1) * (rnd.get() % 2);
      int yoko = (rnd.get() % 2 == 1 ? -1 : 1) * (rnd.get() % 2);
      if (!(tate == 0 && yoko == 0) &&
          komaNow[2] + tate < 5 &&
          komaNow[2] + tate > -1 &&
          komaNow[3] + yoko < 5 &&
          komaNow[3] + yoko > -1) {
        komaNow[2] += tate;
        komaNow[3] += yoko;
        break;
      }
    }
    if (shogiTable[komaNow[2]][komaNow[3]] == 3) {
      shogiTable[komaNow[2]][komaNow[3]] = 4;
      saveGame("ban", turnCount);
      winner = "Explosion!";
    } else {
      shogiTable[komaNow[2]][komaNow[3]] = 2;
    }
    _player = await _cache.play('koma.wav');
    _player.setVolume(ShogiManage.volume);
  }

  Future<void> nextYoke() async {
    if (win() == 1) return;
    turnCount++;
    for (int i = 24; i >= 0; i--) {
      if (shogiTable[i ~/ 5][i % 5] == 4) shogiTable[i ~/ 5][i % 5] = 0;
    }
    while (true) {
      int x = -1;
      int y = -1;
      for (int i = 24; i >= 0; i--) {
        if (shogiTable[i ~/ 5][i % 5] == 1) {
          x = i ~/ 5;
          y = i % 5;
          break;
        }
      }
      if (x == -1) break;
      if (x == 4) {
        shogiTable[x][y] = 0;
        continue;
      }
      int move = rnd.get() % 3 - 1;
      if (y + move >= 0 && y + move <= 4) {
        shogiTable[x][y] = 0;
        if (shogiTable[x + 1][y + move] == 2 ||
            shogiTable[x + 1][y + move] == 5) {
          shogiTable[x + 1][y + move] = 4;
        } else {
          shogiTable[x + 1][y + move] = 5;
        }
      }
    }
    for (int i = 24; i >= 0; i--) {
      if (shogiTable[i ~/ 5][i % 5] == 5) shogiTable[i ~/ 5][i % 5] = 1;
    }
    for (int i = rnd.get() % 3; i > 0; i--) {
      while (true) {
        int put = rnd.get() % 5;
        if (shogiTable[0][put] == 0) {
          shogiTable[0][put] = 1;
          break;
        }
      }
    }
    if (shogiTable[komaNow[2]][komaNow[3]] != 2) {
      saveGame("yoke", turnCount);
      winner = "王に衝突した";
    }
    _player = await _cache.play('koma.wav');
    _player.setVolume(ShogiManage.volume);
    print("end");
  }

  Future<void> move(int distance) async {
    if (shogiTable[komaNow[2]][komaNow[3]] != 2) return;
    shogiTable[komaNow[2]][komaNow[3]] = 0;
    if (komaNow[3] + distance >= 0 && komaNow[3] + distance <= 4)
      komaNow[3] += distance;
    shogiTable[komaNow[2]][komaNow[3]] = 2;
    _player = await _cache.play('koma.wav');
    _player.setVolume(ShogiManage.volume);
  }
}

/// 将棋の盤面を返す関数
/// 引数は、
/// shogiManageのインスタンス,
/// 右のような関数(){setState((){shogiManageのインスタンス.winner="";});},
/// デバイスのサイズ(Size型)
Widget shogiTableBuild(ShogiManage shogi, Function setWinner, Size windowSize,
    String mode, int seed, int index,
    {bool showSave = true}) {
  return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(color: Colors.black),
            children: List.generate(
                5,
                (index) => TableRow(
                    children: List.generate(
                        5,
                        (index2) => Container(
                            alignment: Alignment.center,
                            color: Colors.black12,
                            child: shogi.koma(index, index2))))),
          ),
          Positioned(
              top: 20,
              left: windowSize.width / 2 - 200,
              child: Opacity(
                opacity: (shogi.winner != "") ? 1 : 0,
                child: Container(
                    height: 360,
                    width: 390,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular((10))),
                        border: Border.all(width: 5, color: Colors.black)),
                    child: Column(
                      children: <Widget>[
                        Text(
                          shogi.winner,
                          textScaleFactor: 4,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${shogi.turnCount}ターン\n最小ターン数:${shogi.min}\n最大ターン数:${shogi.max}",
                          textScaleFactor: 2,
                          style: const TextStyle(color: Colors.black45),
                          textAlign: TextAlign.center,
                        ),
                        (showSave && mode != "yoke")
                            ? (TextButton(
                                onPressed: () {
                                  shogi.savePlay(mode, seed, index);
                                },
                                child: const Text(
                                  "リプレイを保存",
                                  textScaleFactor: 1.5,
                                )))
                            : (const SizedBox(
                                width: 0,
                                height: 0,
                              ))
                      ],
                    )),
              )),
          Positioned(
              left: windowSize.width / 2 + 140,
              top: 30,
              child: Opacity(
                opacity: (shogi.winner != "") ? 1 : 0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setWinner();
                  },
                ),
              )),
        ],
      ));
}
