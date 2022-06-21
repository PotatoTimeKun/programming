import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme:
            GoogleFonts.sawarabiGothicTextTheme(Theme.of(context).textTheme),
      ),
      title: '乱数将棋',
      home: const MyHomePage(title: 'Potato Kun Programs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scafKey = GlobalKey<ScaffoldState>();
  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );
  late AudioPlayer _player;
  bool musicPlay = false;
  double BGMvolume = 1, SEvolume = 1;
  String game1_desc = "", game2_desc = "", game3_desc = "";
  bool show_game1 = false, show_game2 = false, show_game3 = false;
  Future<void> show_url(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> getSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      BGMvolume = pref.getDouble("bgm") ?? 1;
      SEvolume = pref.getDouble("se") ?? 1;
    });
  }

  Future<void> saveSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("bgm", BGMvolume);
    pref.setDouble("se", SEvolume);
  }

  @override
  void initState() {
    getSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _scafKey.currentState!.openEndDrawer();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            const Center(child: Text("BGMボリューム")),
            Slider.adaptive(
              value: BGMvolume,
              onChanged: (double new_volume) {
                setState(() {
                  BGMvolume = new_volume;
                  try {
                    _player.setVolume(BGMvolume);
                  } catch (e) {}
                });
                saveSetting();
              },
              min: 0,
              max: 1,
              divisions: 15,
            ),
            const Center(child: Text("効果音ボリューム")),
            Slider.adaptive(
              value: SEvolume,
              onChanged: (double new_volume) {
                setState(() {
                  SEvolume = new_volume;
                });
                ShogiManage.volume = SEvolume;
                saveSetting();
              },
              min: 0,
              max: 1,
              divisions: 15,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              "乱数将棋",
              textScaleFactor: 3,
            ),
            const Spacer(),
            Container(
                width: 250,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.blue),
                child: Row(
                  children: [
                    TextButton(
                      child: const Text(
                        "将棋!    ",
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 2,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HP3rd();
                        }));
                      },
                    ),
                    const Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlue,
                            border: Border.all(color: Colors.white, width: 2)),
                        margin: const EdgeInsets.all(5),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                show_game2 = !show_game2;
                                if (show_game2) {
                                  game2_desc =
                                      "王は乱数で決まった方向に1マス進みます。\n青の駒:自分  赤の駒:敵";
                                } else {
                                  game2_desc = "";
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.question_mark_rounded,
                              color: Colors.white,
                            )))
                  ],
                )),
            Text(
              game2_desc,
              style: const TextStyle(color: Colors.black54),
              textScaleFactor: 1.2,
            ),
            const Spacer(),
            Container(
                width: 250,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.blue),
                child: Row(
                  children: [
                    TextButton(
                      child: const Text(
                        "将棋?    ",
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 2,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HP2nd();
                        }));
                      },
                    ),
                    const Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlue,
                            border: Border.all(color: Colors.white, width: 2)),
                        margin: const EdgeInsets.all(5),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                show_game1 = !show_game1;
                                if (show_game1) {
                                  game1_desc =
                                      "王は乱数で決まったマスにワープします。\n青の駒:自分  赤の駒:敵";
                                } else {
                                  game1_desc = "";
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.question_mark_rounded,
                              color: Colors.white,
                            )))
                  ],
                )),
            Text(
              game1_desc,
              style: const TextStyle(color: Colors.black54),
              textScaleFactor: 1.2,
            ),
            const Spacer(),
            Container(
                width: 250,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.blue),
                child: Row(
                  children: [
                    TextButton(
                      child: const Text(
                        "将棋ではない",
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 2,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HP4th();
                        }));
                      },
                    ),
                    const Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlue,
                            border: Border.all(color: Colors.white, width: 2)),
                        margin: const EdgeInsets.all(5),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                show_game3 = !show_game3;
                                if (show_game3) {
                                  game3_desc = "将棋ではないことは明らかです。\n青の駒:自分  赤の駒:敵";
                                } else {
                                  game3_desc = "";
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.question_mark_rounded,
                              color: Colors.white,
                            )))
                  ],
                )),
            Text(
              game3_desc,
              style: const TextStyle(color: Colors.black54),
              textScaleFactor: 1.2,
            ),
            const Spacer(),
            Container(
              width: 250,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.blue),
              child: TextButton(
                child: Text(
                  (musicPlay) ? "BGM OFF" : "BGM ON",
                  style: const TextStyle(color: Colors.white),
                  textScaleFactor: 2,
                ),
                onPressed: () async {
                  if (musicPlay) {
                    _player.stop();
                  } else {
                    _player = await _cache.loop('miracle_future.mp3');
                    _player.setVolume(BGMvolume);
                  }
                  setState(() {
                    musicPlay = !musicPlay;
                  });
                },
              ),
            ),
            const Spacer(),
            Container(
                color: Colors.blueGrey,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          show_url(Uri.parse(
                              "https://potatotimekun.github.io/web/"));
                        },
                        child: const Text(
                          "作成者(ポテトタイム君)ホームページ",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                          ),
                          textScaleFactor: 1.5,
                        )),
                    const Spacer(),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

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
  int _index = 100;

  /// 現在使用している乱数の種、クラス外へは読み込みのみ推奨、書き込まないこと
  int seed_number = -1;

  /// 乱数の種を指定し、乱数を作り直す
  void seed(int n) {
    //合同法乱数の漸化式
    // x[0]=b
    // x[k+1]=(x[k]*a)%m
    seed_number = n;
    _index = 0;
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
      _index = 0;
    }
    if (_index > 99) {
      //インデックスが最大になったら、乱数を次の種で作る
      seed(++seed_number);
    }
    _index++;
    return rnd[_index - 1];
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
  static double volume = 1;
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
  Widget Koma(int i, int j) {
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

  /// 盤面を次へ進める、将棋！用
  Future<void> next() async {
    if (win() != 0) return;
    if (turn == 0) {
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
      winner = "You lose...";
    } else if (win() == 2) {
      winner = "You win!";
    }
    _player = await _cache.play('koma.wav');
    _player.setVolume(ShogiManage.volume);
  }

  /// 盤面を次へ進める、将棋？用
  Future<void> nextShogi() async {
    if (win() != 0) return;
    if (turn == 0) {
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
      winner = "You lose...";
    } else if (win() == 2) {
      winner = "You win!";
    }
    _player = await _cache.play('koma.wav');
    _player.setVolume(ShogiManage.volume);
  }

  /// 盤面を次へ進める、将棋ではない用
  Future<void> nextNotShogi() async {
    if (win() != 0) return;
    int turnKoma = (turn == 0) ? 2 : 1;
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
      winner = "You lose...";
    } else if (win() == 2) {
      winner = "You win!";
    }
    _player = await _cache.play('koma.wav');
    _player.setVolume(ShogiManage.volume);
  }
}

/// 将棋の盤面を返す関数
Widget shogiTableBuild(ShogiManage shogi) {
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
                            child: shogi.Koma(index, index2))))),
          ),
          Text(
            shogi.winner,
            textScaleFactor: 4,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ));
}

class HP2nd extends StatefulWidget {
  const HP2nd({Key? key}) : super(key: key);

  @override
  State<HP2nd> createState() => Page2nd();
}

class Page2nd extends State<HP2nd> {
  var shogi = ShogiManage();
  bool cpuTurn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("将棋?なう"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          setState(() {
                            shogi = ShogiManage();
                          });
                        },
                        icon: const Icon(Icons.refresh)),
                    const Spacer(),
                    Text(
                      shogi.player,
                      textScaleFactor: 2,
                    ),
                    const Spacer()
                  ],
                )),
            shogiTableBuild(shogi),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blue),
                  child: TextButton(
                      onPressed: () async {
                        if (cpuTurn) return;
                        setState(() {
                          shogi.next();
                          cpuTurn = true;
                        });
                        await Future.delayed(const Duration(milliseconds: 700));
                        setState(() {
                          shogi.next();
                          cpuTurn = false;
                        });
                      },
                      child: const Text(
                        "駒を動かす",
                        textScaleFactor: 2,
                        style: TextStyle(color: Colors.black),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}

class HP3rd extends StatefulWidget {
  const HP3rd({Key? key}) : super(key: key);

  @override
  State<HP3rd> createState() => Page3rd();
}

class Page3rd extends State<HP3rd> {
  var shogi = ShogiManage();
  bool cpuTurn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("将棋!なう"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          setState(() {
                            shogi = ShogiManage();
                          });
                        },
                        icon: const Icon(Icons.refresh)),
                    const Spacer(),
                    Text(
                      shogi.player,
                      textScaleFactor: 2,
                    ),
                    const Spacer()
                  ],
                )),
            shogiTableBuild(shogi),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blue),
                  child: TextButton(
                      onPressed: () async {
                        if (cpuTurn) return;
                        setState(() {
                          shogi.nextShogi();
                          cpuTurn = true;
                        });
                        await Future.delayed(const Duration(milliseconds: 700));
                        setState(() {
                          shogi.nextShogi();
                          cpuTurn = false;
                        });
                      },
                      child: const Text(
                        "駒を動かす",
                        textScaleFactor: 2,
                        style: TextStyle(color: Colors.black),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}

class HP4th extends StatefulWidget {
  const HP4th({Key? key}) : super(key: key);

  @override
  State<HP4th> createState() => Page4th();
}

class Page4th extends State<HP4th> {
  var shogi = ShogiManage.notShogi();
  bool cpuTurn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("将棋ではないなう"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          setState(() {
                            shogi = ShogiManage.notShogi();
                          });
                        },
                        icon: const Icon(Icons.refresh)),
                    const Spacer(),
                    Text(
                      shogi.player,
                      textScaleFactor: 2,
                    ),
                    const Spacer()
                  ],
                )),
            shogiTableBuild(shogi),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blue),
                  child: TextButton(
                      onPressed: () async {
                        if (cpuTurn) return;
                        setState(() {
                          shogi.nextNotShogi();
                          cpuTurn = true;
                        });
                        await Future.delayed(const Duration(milliseconds: 700));
                        setState(() {
                          shogi.nextNotShogi();
                          cpuTurn = false;
                        });
                      },
                      child: const Text(
                        "駒を動かす",
                        textScaleFactor: 2,
                        style: TextStyle(color: Colors.black),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
