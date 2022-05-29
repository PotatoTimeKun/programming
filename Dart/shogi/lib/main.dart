import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
      title: 'Random Shogi',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                color: Colors.blue,
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
                    IconButton(
                        onPressed: () {
                          setState(() {
                            show_game2 = !show_game2;
                            if (show_game2) {
                              game2_desc = "王は乱数で決まった方向に1マス進みます。";
                            } else {
                              game2_desc = "";
                            }
                          });
                        },
                        icon: const Icon(Icons.question_mark_rounded))
                  ],
                )),
            Text(
              game2_desc,
              style: const TextStyle(color: Colors.black45),
            ),
            const Spacer(),
            Container(
                width: 250,
                color: Colors.blue,
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
                    IconButton(
                        onPressed: () {
                          setState(() {
                            show_game1 = !show_game1;
                            if (show_game1) {
                              game1_desc = "王は乱数で決まったマスにワープします。";
                            } else {
                              game1_desc = "";
                            }
                          });
                        },
                        icon: const Icon(Icons.question_mark_rounded))
                  ],
                )),
            Text(
              game1_desc,
              style: const TextStyle(color: Colors.black45),
            ),
            const Spacer(),
            Container(
                width: 250,
                color: Colors.blue,
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
                    IconButton(
                        onPressed: () {
                          setState(() {
                            show_game3 = !show_game3;
                            if (show_game3) {
                              game3_desc = "将棋ではないことは明らかです。";
                            } else {
                              game3_desc = "";
                            }
                          });
                        },
                        icon: const Icon(Icons.question_mark_rounded))
                  ],
                )),
            Text(
              game3_desc,
              style: const TextStyle(color: Colors.black45),
            ),
            const Spacer(),
            const Text(
              "ルール:\n乱数によって駒の動きが決まる将棋です。\n青:自分\n赤:敵",
              textScaleFactor: 1.5,
            ),
            const Spacer(),
            Container(
                color: Colors.blueGrey,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    const Spacer(),
                    const Icon(Icons.web),
                    TextButton(
                        onPressed: () {
                          show_url(Uri.parse(
                              "https://potatotimekun.github.io/web/"));
                        },
                        child: const Text(
                          "作成者(ポテトタイム君)ホームページ",
                          style: TextStyle(color: Colors.white),
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

class HP2nd extends StatefulWidget {
  const HP2nd({Key? key}) : super(key: key);

  @override
  State<HP2nd> createState() => Page2nd();
}

class Page2nd extends State<HP2nd> {
  bool first = true;
  var rnd = <int>[];
  int _index = 100;
  int seed_number = 1;
  void seed(int n) {
    setState(() {
      seed_number = n;
      _index = 0;
    });
    int max;
    var sosu = <int>[
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
    int count = 0;
    do {
      max = 100;
      setState(() {
        rnd[0] = n % 500 + 1;
        for (int i = 0; i < 99; i++) {
          rnd[i + 1] = (((n + count) % 501 + 100) * rnd[i]) % sosu[n % 10];
          if (rnd[i + 1] == rnd[0]) {
            max = i;
          }
        }
      });
      count++;
    } while (max < 100);
  }

  int rand() {
    if (first) {
      setState(() {
        for (int i = 0; i < 100; i++) {
          rnd.add(0);
        }
      });
      DateTime now = DateTime.now();
      seed(now.second +
          now.minute * 60 +
          now.hour * 60 * 60 +
          now.day * 60 * 60 * 24 +
          now.month * 60 * 60 * 24 * 31);
      first = false;
    }
    if (_index > 99) {
      seed(++seed_number);
    }
    setState(() {
      _index++;
    });
    return rnd[_index - 1];
  }

  int turn = 0;
  String head = "あなたのターンです";
  var komaNow = [0, 2, 4, 2];
  var shogiTable = [
    [0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 2, 0, 0]
  ];
  Widget Koma(int n) {
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

  Future<void> next() async {
    if (win() != 0) return;
    if (turn == 0) {
      setState(() {
        shogiTable[komaNow[2]][komaNow[3]] = 0;
        komaNow[2] = rand() % 5;
        komaNow[3] = rand() % 5;
        shogiTable[komaNow[2]][komaNow[3]] = 2;
      });
    } else if (turn == 1) {
      setState(() {
        shogiTable[komaNow[0]][komaNow[1]] = 0;
        komaNow[0] = rand() % 5;
        komaNow[1] = rand() % 5;
        shogiTable[komaNow[0]][komaNow[1]] = 1;
      });
    }
    if (win() == 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("You Lose..."),
              content: const Text("お前の負けだあああああ"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            );
          });
    } else if (win() == 2) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("You Win!!"),
              content: const Text("勝った！勝ったぞおおおお"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            );
          });
    } else {
      setState(() {
        turn = turn == 0 ? 1 : 0;
        head = turn == 0 ? "あなたのターンです" : "あいてのターンです";
      });
      if (turn == 1) {
        await Future.delayed(const Duration(milliseconds: 500));
        next();
      }
    }
  }

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
              child: Text(
                head,
                textScaleFactor: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Table(
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
                                child: Koma(shogiTable[index][index2]))))),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 200,
                  color: Colors.cyan,
                  child: TextButton(
                      onPressed: () {
                        next();
                      },
                      child: const Text(
                        "駒を動かす",
                        textScaleFactor: 2,
                        style: TextStyle(color: Colors.black),
                      )),
                )),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 200,
                  color: Colors.cyan,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          first = true;
                          shogiTable = [
                            [0, 0, 1, 0, 0],
                            [0, 0, 0, 0, 0],
                            [0, 0, 0, 0, 0],
                            [0, 0, 0, 0, 0],
                            [0, 0, 2, 0, 0]
                          ];
                          turn = 0;
                          head = "あなたのターンです";
                          komaNow = [0, 2, 4, 2];
                        });
                      },
                      child: const Text(
                        "リセット",
                        textScaleFactor: 2,
                        style: TextStyle(color: Colors.red),
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
  bool first = true;
  var rnd = <int>[];
  int _index = 100;
  int seed_number = 1;
  void seed(int n) {
    setState(() {
      seed_number = n;
      _index = 0;
    });
    int max;
    var sosu = <int>[
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
    int count = 0;
    do {
      max = 100;
      setState(() {
        rnd[0] = n % 500 + 1;
        for (int i = 0; i < 99; i++) {
          rnd[i + 1] = (((n + count) % 501 + 100) * rnd[i]) % sosu[n % 10];
          if (rnd[i + 1] == rnd[0]) {
            max = i;
          }
        }
      });
      count++;
    } while (max < 100);
  }

  int rand() {
    if (first) {
      setState(() {
        for (int i = 0; i < 100; i++) {
          rnd.add(0);
        }
      });
      DateTime now = DateTime.now();
      seed(now.second +
          now.minute * 60 +
          now.hour * 60 * 60 +
          now.day * 60 * 60 * 24 +
          now.month * 60 * 60 * 24 * 31);
      first = false;
    }
    if (_index > 99) {
      seed(++seed_number);
    }
    setState(() {
      _index++;
    });
    return rnd[_index - 1];
  }

  int turn = 0;
  String head = "あなたのターンです";
  var komaNow = [0, 2, 4, 2];
  var shogiTable = [
    [0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 2, 0, 0]
  ];
  Widget Koma(int n) {
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

  Future<void> next() async {
    if (win() != 0) return;
    if (turn == 0) {
      setState(() {
        shogiTable[komaNow[2]][komaNow[3]] = 0;
        while (true) {
          int tate = (rand() % 2 == 1 ? -1 : 1) * (rand() % 2);
          int yoko = (rand() % 2 == 1 ? -1 : 1) * (rand() % 2);
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
      });
    } else if (turn == 1) {
      setState(() {
        shogiTable[komaNow[0]][komaNow[1]] = 0;
        while (true) {
          int tate = (rand() % 2 == 1 ? -1 : 1) * (rand() % 2);
          int yoko = (rand() % 2 == 1 ? -1 : 1) * (rand() % 2);
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
      });
    }
    if (win() == 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("You Lose..."),
              content: const Text("お前の負けだあああああ"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            );
          });
    } else if (win() == 2) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("You Win!!"),
              content: const Text("勝った！勝ったぞおおおお"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            );
          });
    } else {
      setState(() {
        turn = turn == 0 ? 1 : 0;
        head = turn == 0 ? "あなたのターンです" : "あいてのターンです";
      });
      if (turn == 1) {
        await Future.delayed(const Duration(milliseconds: 500));
        next();
      }
    }
  }

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
              child: Text(
                head,
                textScaleFactor: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Table(
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
                                child: Koma(shogiTable[index][index2]))))),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 200,
                  color: Colors.cyan,
                  child: TextButton(
                      onPressed: () {
                        next();
                      },
                      child: const Text(
                        "駒を動かす",
                        textScaleFactor: 2,
                        style: TextStyle(color: Colors.black),
                      )),
                )),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 200,
                  color: Colors.cyan,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          first = true;
                          shogiTable = [
                            [0, 0, 1, 0, 0],
                            [0, 0, 0, 0, 0],
                            [0, 0, 0, 0, 0],
                            [0, 0, 0, 0, 0],
                            [0, 0, 2, 0, 0]
                          ];
                          turn = 0;
                          head = "あなたのターンです";
                          komaNow = [0, 2, 4, 2];
                        });
                      },
                      child: const Text(
                        "リセット",
                        textScaleFactor: 2,
                        style: TextStyle(color: Colors.red),
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
  bool first = true;
  var rnd = <int>[];
  int _index = 100;
  int seed_number = 1;
  void seed(int n) {
    setState(() {
      seed_number = n;
      _index = 0;
    });
    int max;
    var sosu = <int>[
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
    int count = 0;
    do {
      max = 100;
      setState(() {
        rnd[0] = n % 500 + 1;
        for (int i = 0; i < 99; i++) {
          rnd[i + 1] = (((n + count) % 501 + 100) * rnd[i]) % sosu[n % 10];
          if (rnd[i + 1] == rnd[0]) {
            max = i;
          }
        }
      });
      count++;
    } while (max < 100);
  }

  int rand() {
    if (first) {
      setState(() {
        for (int i = 0; i < 100; i++) {
          rnd.add(0);
        }
      });
      DateTime now = DateTime.now();
      seed(now.second +
          now.minute * 60 +
          now.hour * 60 * 60 +
          now.day * 60 * 60 * 24 +
          now.month * 60 * 60 * 24 * 31);
      first = false;
    }
    if (_index > 99) {
      seed(++seed_number);
    }
    setState(() {
      _index++;
    });
    return rnd[_index - 1];
  }

  int turn = 0;
  String head = "あなたのターンです";
  var shogiTable = [
    [1, 0, 1, 0, 1],
    [0, 1, 0, 1, 0],
    [0, 0, 0, 0, 0],
    [0, 2, 0, 2, 0],
    [2, 0, 2, 0, 2]
  ];
  Widget Koma(int n) {
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

  Future<void> next() async {
    if (win() != 0) return;
    if (turn == 0) {
      setState(() {
        while (true) {
          bool breaking = false;
          int selected = rand() % 5 + 1;
          var komaNow = [rand() % 5, rand() % 5];
          int count = 0;
          for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
              if (shogiTable[i][j] == 2) {
                count++;
              }
              if (count == selected) {
                while (shogiTable[komaNow[0]][komaNow[1]] == 2) {
                  komaNow = [rand() % 5, rand() % 5];
                }
                setState(() {
                  shogiTable[komaNow[0]][komaNow[1]] = 2;
                  shogiTable[i][j] = 0;
                });
                breaking = true;
                count++;
              }
            }
          }
          if (breaking) break;
        }
      });
    } else if (turn == 1) {
      setState(() {
        while (true) {
          bool breaking = false;
          int selected = rand() % 5 + 1;
          var komaNow = [rand() % 5, rand() % 5];
          int count = 0;
          for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
              if (shogiTable[i][j] == 1) {
                count++;
              }
              if (count == selected) {
                while (shogiTable[komaNow[0]][komaNow[1]] == 1) {
                  komaNow = [rand() % 5, rand() % 5];
                }
                setState(() {
                  shogiTable[komaNow[0]][komaNow[1]] = 1;
                  shogiTable[i][j] = 0;
                });
                breaking = true;
                count++;
              }
            }
          }
          if (breaking) break;
        }
      });
    }
    if (win() == 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("You Lose..."),
              content: const Text("お前の負けだあああああ"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            );
          });
    } else if (win() == 2) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("You Win!!"),
              content: const Text("勝った！勝ったぞおおおお"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            );
          });
    } else {
      setState(() {
        turn = turn == 0 ? 1 : 0;
        head = turn == 0 ? "あなたのターンです" : "あいてのターンです";
      });
      if (turn == 1) {
        await Future.delayed(const Duration(milliseconds: 500));
        next();
      }
    }
  }

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
              child: Text(
                head,
                textScaleFactor: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Table(
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
                                child: Koma(shogiTable[index][index2]))))),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 200,
                  color: Colors.cyan,
                  child: TextButton(
                      onPressed: () {
                        next();
                      },
                      child: const Text(
                        "駒を動かす",
                        textScaleFactor: 2,
                        style: TextStyle(color: Colors.black),
                      )),
                )),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 200,
                  color: Colors.cyan,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          first = true;
                          shogiTable = [
                            [1, 0, 1, 0, 1],
                            [0, 1, 0, 1, 0],
                            [0, 0, 0, 0, 0],
                            [0, 2, 0, 2, 0],
                            [2, 0, 2, 0, 2]
                          ];
                          turn = 0;
                          head = "あなたのターンです";
                        });
                      },
                      child: const Text(
                        "リセット",
                        textScaleFactor: 2,
                        style: TextStyle(color: Colors.red),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
