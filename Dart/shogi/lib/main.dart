import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shogiManager.dart'; // 将棋の進行・ゲームデータの操作など
import 'shogi.dart'; // 将棋!のページ
import 'shogi_question.dart'; // 将棋?のページ
import 'not_shogi.dart'; // 将棋ではないのページ
import 'bakudan.dart'; // 爆弾のページ
import 'shogi_yoke.dart';

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
  // ホーム(タイトル画面)
  final _scafKey = GlobalKey<ScaffoldState>(); // ドロワーで使用
  /// BGM・SEの停止や音量設定
  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );

  /// BGM・SEの停止や音量設定
  late AudioPlayer _player;

  /// 今BGMを鳴らしているかどうか
  bool musicPlay = false;

  /// 音量(0~1)
  double BGMvolume = 1, SEvolume = 1;

  /// 各ゲームモードのタイトル
  final List<String> titles = [
    "将棋!     ",
    "将棋?     ",
    "将棋ではない",
    "爆弾     ",
    "将棋避け    "
  ];

  /// 各ゲームモードの説明文
  final List<String> desc = [
    "王は乱数で決まった方向に1マス進みます。",
    "王は乱数で決まったマスにワープします。",
    "将棋ではないことは明らかです。",
    "将棋ってなんですか?",
    "王が飛んできます。"
  ];

  /// 各ゲームモードのページ
  final List<StatefulWidget> pages = [
    const HPshogi(),
    const HP2nd(),
    const HPns(),
    const HPban(),
    const HPyk()
  ];

  /// 各ゲームモードで説明文を表示するかどうか
  var showGame = [false, false, false, false, false];

  /// 指定したURIに飛ぶ
  Future<void> showUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  /// 音量設定を取得する
  Future<void> getSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      BGMvolume = pref.getDouble("bgm") ?? 1; // 保存したものがなければ1
      SEvolume = pref.getDouble("se") ?? 1;
    });
  }

  /// 音量設定を保存する
  Future<void> saveSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("bgm", BGMvolume);
    pref.setDouble("se", SEvolume);
  }

  /// 指定した番号のゲームモードへのボタンを返す
  Widget makeGameButton(int gameNumber) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        width: 250,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.blue),
        child: Row(
          children: [
            TextButton(
              // ボタンそのもの
              child: Text(
                titles[gameNumber],
                style: const TextStyle(color: Colors.white),
                textScaleFactor: 2,
              ),
              onPressed: () {
                Navigator.push(this.context,
                    MaterialPageRoute(builder: (context) {
                  return pages[gameNumber];
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
                    // 説明を表示するボタン
                    onPressed: () {
                      setState(() {
                        showGame[gameNumber] = !showGame[gameNumber];
                      });
                    },
                    icon: const Icon(
                      Icons.question_mark_rounded,
                      color: Colors.white,
                    )))
          ],
        ));
  }

  /// showGameリストも考慮して指定したゲームモードの説明文を返す
  Widget makeDesc(int gameNumber) {
    if (showGame[gameNumber]) {
      return Text(
        desc[gameNumber],
        style: const TextStyle(color: Colors.black54),
        textScaleFactor: 1.2,
      );
    } else {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
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
        // 画面上にタイトル、設定ボタンを表示
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _scafKey.currentState!.openEndDrawer(); // 設定ボタンを押したらドロワーを開く
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      endDrawer: Drawer(
        // ドロワー
        child: ListView(
          children: <Widget>[
            const Center(child: Text("BGMボリューム")),
            Slider.adaptive(
              // BGMのボリュームスライダー
              value: BGMvolume,
              onChanged: (double newVolume) {
                setState(() {
                  BGMvolume = newVolume;
                  try {
                    _player.setVolume(BGMvolume);
                  } catch (e) {}
                });
                saveSetting(); // 音量変更時にセーブ
              },
              min: 0,
              max: 1,
              divisions: 15,
            ),
            const Center(child: Text("効果音ボリューム")),
            Slider.adaptive(
              // SEのボリュームスライダー
              value: SEvolume,
              onChanged: (double newVolume) {
                setState(() {
                  SEvolume = newVolume;
                });
                ShogiManage.volume = SEvolume; // SEはShogiManageクラスの方で使う
                saveSetting();
              },
              min: 0,
              max: 1,
              divisions: 15,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const Text(
                // タイトル
                "乱数将棋",
                textScaleFactor: 3,
              ),
              Expanded(
                  // 全ゲームモードのボタンを表示
                  child: SingleChildScrollView(
                      child: Column(
                          children: <Widget>[
                                const SizedBox(
                                  // 横幅調整用
                                  width: double.infinity,
                                  height: 0,
                                ),
                              ] +
                              List.generate(
                                  // ゲームのボタンとその説明を交互に表示
                                  titles.length * 2,
                                  (index) => (index % 2 == 0)
                                      ? makeGameButton(index ~/ 2)
                                      : makeDesc(index ~/ 2))))),
              // 以下は画面下に表示
              Container(
                //記録表示のページへ
                width: 250,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.blue),
                child: TextButton(
                  child: const Text(
                    "記録     ",
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 2,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const HPres();
                    }));
                  },
                ),
              ),
              Container(
                // BGMのON/OFFボタン
                margin: const EdgeInsets.only(top: 10, bottom: 10),
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
              Container(
                  // ホームページリンク
                  color: Colors.blueGrey,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            showUrl(Uri.parse(
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
      ),
    );
  }
}

class HPres extends StatefulWidget {
  const HPres({Key? key}) : super(key: key);

  @override
  State<HPres> createState() => Pageres();
}

/// ハイスコアタブのTextのリストを作成する
Future<List<Text>> buildTexts() async {
  var shogi = ShogiManage();
  var keys = ["shogi?", "shogi", "notshogi", "ban", "yoke"];
  var titles = ["将棋!", "将棋?", "将棋ではない", "爆弾", "将棋避け"];
  var texts = <Text>[];
  for (int i = 0; i < keys.length; i++) {
    await shogi.saveGame(keys[i], -1); // セーブデータは変化させない、min/maxに値を代入させる
    texts.add(Text(
      "${titles[i]}\n Max:${shogi.max == -1 ? "---" : shogi.max}\n Min:${shogi.min == -1 ? "---" : shogi.min}",
      textAlign: TextAlign.center,
      textScaleFactor: 2,
    ));
  }
  return texts;
}

/// リプレイタブのTextButtonのリストを作成する
Future<List<TextButton>> buildReplays(BuildContext context) async {
  var keys = ["shogi?", "shogi", "notshogi", "ban", "yoke"];
  var titles = ["将棋?", "将棋!", "将棋ではない", "爆弾", "将棋避け"];
  var texts = <TextButton>[];
  SharedPreferences pref = await SharedPreferences.getInstance();
  List<String> list = pref.getStringList("replay") ?? []; // リプレイのリストの取得
  List<String> yoke_pos =
      pref.getStringList("yoke_pos") ?? []; // yokeモード専用データを取得
  int yoke_ind = 0; // yoke_posのインデックス
  for (int i = 0; i < list.length ~/ 3; i++) {
    // listは[モード名,乱数の種,乱数リストのインデックス,...]と繰り返す
    int num = 0;
    for (int j = 0; j < keys.length; j++) {
      // モード名と一致するkeysの要素のインデックスをnumに代入
      if (list[i * 3] == keys[j]) num = j;
    }
    String yoke_str = ""; // HPrepに渡す将棋避け用データ
    if (list[i * 3] == "yoke") {
      // 将棋避けのときは専用のデータを取得
      yoke_str = yoke_pos[yoke_ind];
      yoke_ind++;
    }
    texts.add(TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HPrep(
                mode: list[i * 3],
                seed: int.parse(list[i * 3 + 1]),
                index: int.parse(list[i * 3 + 2]),
                yoke_pos: yoke_str);
          }));
        },
        child: Text(
            "${titles[num]}\n${list[i * 3 + 1]}-${list[i * 3 + 2]}",
            textScaleFactor: 2,
            textAlign: TextAlign.center,
        ))); //タイトル\n乱数の種-乱数リストのインデックス
  }
  return texts;
}

class Pageres extends State<HPres> {
  // 結果を表示するページ
  dynamic texts;
  dynamic replays;

  @override
  void initState() {
    // 最初にbuildTexts関数でセーブデータを取得
    super.initState();
    Future(() async {
      var tex = await buildTexts();
      var rep = await buildReplays(this.context);
      setState(() {
        texts = tex;
        replays = rep;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("記録なう"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(this.context);
                },
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: "ハイスコア",
                  ),
                  Tab(
                    text: "リプレイ",
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child:Column(
                        children: List.generate(
                            // textsを順に表示
                            texts.length,
                            (index) => Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(color:Colors.black12,borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: texts[index],
                                ))),
                ),
                SingleChildScrollView(
                  child: Column(
                        children: List.generate(
                            // replaysを順に表示
                            replays.length,
                            (index) => Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(color:Colors.black12,borderRadius: BorderRadius.all(Radius.circular(5))),
                                  child: replays[index],
                                ))),
                  ),
              ],
            )),
      ),
    );
  }
}

/// リプレイの表示
class HPrep extends StatefulWidget {
  /// mode : ゲームモード名(半角英数)
  /// seed : 乱数の種
  /// index : 乱数リストのインデックス
  /// yoke_pos : yoke用データ(ない場合は””)
  const HPrep(
      {Key? key,
      required this.mode,
      required this.seed,
      required this.index,
      required this.yoke_pos})
      : super(key: key);

  final String mode, yoke_pos;
  final int seed, index;

  @override
  State<HPrep> createState() =>
      Pagerep(this.mode, this.seed, this.index, this.yoke_pos);
}

class Pagerep extends State<HPrep> {
  final String mode;
  final int seed, index;
  final String yoke_pos;
  ShogiManage shogi = ShogiManage();
  late Function next; // "駒を動かす"ボタンを押したときに実行する関数
  int yoke_ind = 0; // yoke_posのインデックス
  Pagerep(this.mode, this.seed, this.index, this.yoke_pos) : super();
  @override
  void initState() {
    switch (mode) {
      // shogiの初期化とnextの設定
      case "shogi":
        shogi = ShogiManage();
        next = shogi.nextShogi;
        break;
      case "shogi?":
        shogi = ShogiManage();
        next = shogi.next;
        break;
      case "notshogi":
        shogi = ShogiManage.notShogi();
        next = shogi.nextNotShogi;
        break;
      case "ban":
        // ShogiManage.bakudan()は乱数を使用するので種を設定するまで実行しない→switch後
        next = shogi.nextBan;
        break;
      case "yoke":
        shogi = ShogiManage();
        next = () {
          // nextYoke関数は相手の駒を動かすだけなのでその前に自分を動かす
          if (shogi.win() == 1) return;
          // yoke_posはインデックスと同じターンでの駒の位置(横のみ)
          shogi.move(int.parse(yoke_pos[++yoke_ind]) - shogi.komaNow[3]);
          shogi.nextYoke();
        };
    }
    shogi.rnd.seed(seed); // 種・インデックスを設定
    shogi.rnd.index = index;
    if (mode == "ban") shogi.bakudan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("リプレイなう"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
                // 駒を動かすプレイヤー
                padding: const EdgeInsets.all(5),
                child: Text(
                  shogi.player,
                  textScaleFactor: 2,
                )),
            shogiTableBuild(shogi, () {
              // 盤面
              setState(() {
                shogi.winner = "";
              });
            }, MediaQuery.of(context).size, mode, seed, index, showSave: false),
            Padding(
                // "駒を動かす"ボタン
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blue),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          next();
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
