import 'package:flutter/material.dart';
import 'Cipher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cipher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Cipher'),
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
  final valCon = TextEditingController();
  final keyCon = TextEditingController();
  final fomky = GlobalKey<FormState>();
  String str = "", cea = "", vig = "", sub = "", pol = "", scy = "";
  String mode = "暗号化", sen = "平文";
  bool ang = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                    key: fomky,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: valCon,
                              decoration: InputDecoration(labelText: sen),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: keyCon,
                              decoration: const InputDecoration(labelText: "鍵"),
                            )),
                      ],
                    )),
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ColoredBox(
                      color: Colors.blueAccent,
                      child: TextButton(
                        onPressed: () {
                          String key = keyCon.text;
                          String st = valCon.text;
                          String nowmode = ang ? "m" : "r";
                          setState(() {
                            try {
                              cea = Cipher.ceasar(nowmode, st, int.parse(key));
                            } catch (e) {
                              cea = "can not translate";
                            }
                            try {
                              vig = Cipher.Vigenere(nowmode, st, key);
                            } catch (e) {
                              vig = "can not translate";
                            }
                            try {
                              sub = Cipher.substitution(nowmode, st, key);
                            } catch (e) {
                              sub = "can not translate";
                            }
                            try {
                              pol = Cipher.polybius_square(nowmode, st);
                            } catch (e) {
                              pol = "can not translate";
                            }
                            try {
                              scy = Cipher.scytale(nowmode, st);
                            } catch (e) {
                              scy = "can not translate";
                            }
                          });
                        },
                        child: Text(
                          mode,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: IconButton(
                      icon: const Icon(Icons.compare_arrows),
                      onPressed: () {
                        setState(() {
                          ang = ang ? false : true;
                          if (ang) {
                            mode = "暗号化する";
                            sen = "平文";
                          } else {
                            mode = "復号化する";
                            sen = "暗号文";
                          }
                        });
                      },
                    ),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "シーザー暗号\n  $cea",
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "ヴィジュネル暗号\n  $vig",
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "単一換字式暗号\n  $sub",
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "ポリュビオスの暗号表\n  $pol",
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "スキュタレー暗号\n  $scy",
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
