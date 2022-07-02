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

Future<List<Text>> buildTexts() async {
  // 将棋の結果のリストを返す
  var shogi = ShogiManage();
  var keys = ["shogi?", "shogi", "notshogi", "ban", "yoke"];
  var titles = ["将棋!", "将棋?", "将棋ではない", "爆弾", "将棋避け"];
  var texts = <Text>[];
  for (int i = 0; i < keys.length; i++) {
    await shogi.saveGame(keys[i], -1); // セーブデータは変化させない、min/maxに値を代入させる
    texts.add(Text(
      "${titles[i]}\n Max:${shogi.max == -1 ? "---" : shogi.max}\n Min:${shogi.min == -1 ? "---" : shogi.min}",
      textAlign: TextAlign.start,
      textScaleFactor: 2,
    ));
  }
  return texts;
}

Future<List<TextButton>> buildReplays(BuildContext context) async {
  var keys = ["shogi?", "shogi", "notshogi", "ban"];
  var titles = ["将棋?", "将棋!", "将棋ではない", "爆弾"];
  var texts = <TextButton>[];
  SharedPreferences pref = await SharedPreferences.getInstance();
  List<String> list = pref.getStringList("replay") ?? [];
  print(list);
  for (int i = 0; i < list.length ~/ 3; i++) {
    int num = 0;
    for (int j = 0; j < keys.length; j++) {
      if (list[i * 3] == keys[j]) num = j;
    }
    texts.add(TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HPrep(
              mode: list[i * 3],
              seed: int.parse(list[i * 3 + 1]),
              index: int.parse(list[i * 3 + 2]),
            );
          }));
        },
        child: Text("${titles[num]}\n${list[i * 3 + 1]}-${list[i * 3 + 2]}")));
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
                icon: Icon(Icons.arrow_back),
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
                  child: SizedBox(
                    // 幅設定用
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            // textsを順に表示
                            texts.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: texts[index],
                                ))),
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    // 幅設定用
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            // textsを順に表示
                            replays.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: replays[index],
                                ))),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class HPrep extends StatefulWidget {
  const HPrep(
      {Key? key, required this.mode, required this.seed, required this.index})
      : super(key: key);

  final String mode;
  final int seed, index;

  @override
  State<HPrep> createState() => Pagerep(this.mode, this.seed, this.index);
}

class Pagerep extends State<HPrep> {
  final String mode;
  final int seed, index;
  ShogiManage shogi = ShogiManage();
  late Function next;
  Pagerep(this.mode, this.seed, this.index) : super();
  @override
  void initState() {
    switch (mode) {
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
        ShogiManage();
        next = shogi.nextBan;
        break;
      case "yoke":
        shogi = ShogiManage();
        next = shogi.nextYoke;
    }
    shogi.rnd.seed(seed);
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
                padding: const EdgeInsets.all(5),
                child: Text(
                  shogi.player,
                  textScaleFactor: 2,
                )),
            shogiTableBuild(shogi, () {
              setState(() {
                shogi.winner = "";
              });
            }, MediaQuery.of(context).size, mode, seed, index, showSave: false),
            Padding(
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
