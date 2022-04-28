import 'dart:math';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://potatotimekun.github.io/web/');

void _launchUrl() async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potato',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key = const Key(''), this.title = ""})
      : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _i = 1, _ix = 1, _ix2 = 1, _ix3 = 1;
  double _il2x = 0, _il10x = 0, _ilnx = 0;
  String title3 = "3rd Page";
  @override
  Widget build(BuildContext context) {
    void _iPlus() {
      setState(() {
        _i++;
        _ix++;
        _ix2 = _i * _i;
        _ix3 = _i * _i * _i;
        _il2x = log(_i) / log(2);
        _il10x = log(_i) / log(10);
        _ilnx = log(_i);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: const IconButton(
          icon: Icon(Icons.web),
          onPressed: _launchUrl,
        ),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.web_asset),
            onPressed: _launchUrl,
          ),
          IconButton(
            icon: Icon(Icons.web_stories),
            onPressed: _launchUrl,
          ),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'x=$_i\ny=x:\n  y=$_ix\n  f\'($_i)=1\ny=x^2:\n  y=$_ix2\n  f\'($_i)=${2 * _i}\ny=x^3:\n  y=$_ix3\n  f\'($_i)=${3 * _i * _i}\ny=log[2]x:\n  y=$_il2x\n  f\'($_i)=${1 / (_i * log(2))}\ny=log[10]x:\n  y=$_il10x\n  f\'($_i)=${1 / (_i * log(10))}\ny=log[e]x:\n  y=$_ilnx\n  f\'($_i)=${1 / _i}',
            textAlign: TextAlign.left,
            textScaleFactor: 1.5,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SecHomePage();
              }));
            },
            child: const Text("Next Page"),
          ),
          TextButton(
            onPressed: () async {
              String bol = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) {
                      return ThiHomePage(
                        data: _i,
                      );
                    },
                    fullscreenDialog: true),
              ) as String;
              setState(() {
                title3 = bol;
              });
            },
            child: Text(title3),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ForHomePage();
              }));
            },
            child: const Text("4th Page"),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _iPlus,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SecHomePage extends StatefulWidget {
  const SecHomePage({Key key = const Key(''), this.title = ""})
      : super(key: key);
  final String title;
  @override
  SecPageState createState() => SecPageState();
}

class SecPageState extends State<SecHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2nd Page"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(-pi / 10),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(right: 60),
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(width: 10, color: Colors.lightBlue),
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('images/potato.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [BoxShadow(blurRadius: 10)],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back Page"),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}

class ThiHomePage extends StatefulWidget {
  const ThiHomePage({Key key = const Key(''), this.title = "", this.data = 1})
      : super(key: key);
  final String title;
  final int data;
  @override
  ThiPageState createState() => ThiPageState(data);
}

class ThiPageState extends State<ThiHomePage> {
  ThiPageState(this.data);
  final int data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("3rd Page"),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            const Align(
                alignment: Alignment.center,
                child: ClipOval(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                  ),
                )),
            const Align(
              alignment: Alignment(-0.2, -0.2),
              child: SizedBox(
                width: 100,
                height: 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            ),
            Align(
                alignment: const Alignment(0.2, 0.2),
                child: ClipRRect(
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                )),
            Align(
                alignment: const Alignment(0.15, 0.15),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, "already visited");
                    },
                    child: const Text("Back"))),
            Align(
              alignment: const Alignment(0.25, 0.25),
              child: Text("x=$data"),
            ),
          ],
        ),
      ),
    );
  }
}

class ForHomePage extends StatefulWidget {
  const ForHomePage({Key key = const Key(''), this.title = ""})
      : super(key: key);
  final String title;
  @override
  ForPageState createState() => ForPageState();
}

class ForPageState extends State<ForHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("4th Page"),
        ),
        body: ListView(
          children: <Widget>[
            const ListTile(
              title: Text("1"),
              subtitle: Text("hello"),
            ),
            const ListTile(
              title: Text("2"),
              subtitle: Text("good morning"),
            ),
            const ListTile(
              title: Text("3"),
              subtitle: Text("good night"),
            ),
            ListTile(
              title: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FivHomePage();
                  }));
                },
                child: const Text("5th Page"),
              ),
            )
          ],
        ));
  }
}

class FivHomePage extends StatefulWidget {
  const FivHomePage({Key key = const Key(''), this.title = ""})
      : super(key: key);
  final String title;
  @override
  FivPageState createState() => FivPageState();
}

class FivPageState extends State<FivHomePage> {
  final valCon = TextEditingController();
  String st = "", stD = "Drag Target";
  Color a = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("5th Page"),
        ),
        body: PageView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(seconds: 4),
                  color: a,
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        a = Colors.blue;
                      });
                    },
                    child: const Text("animation"))
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: valCon,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          st = valCon.text;
                        });
                      },
                      child: const Text(
                        "get text",
                        textScaleFactor: 2,
                      )),
                  Text(st, textScaleFactor: 2),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          st = "taped";
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("on Tap", textScaleFactor: 2),
                      )),
                  GestureDetector(
                      onDoubleTap: () {
                        setState(() {
                          st = "double taped";
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("on DoubleTap", textScaleFactor: 2),
                      )),
                  GestureDetector(
                      onLongPress: () {
                        setState(() {
                          st = "long pressed";
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("on LongPress", textScaleFactor: 2),
                      )),
                  Dismissible(
                    key: UniqueKey(),
                    child: const ListTile(
                      title: Text("Dismissible"),
                    ),
                    background: Container(
                      color: Colors.black12,
                    ),
                  ),
                  Draggable(
                    child: Container(
                      width: 150,
                      height: 50,
                      child: const Text(
                        "Draggable",
                        textScaleFactor: 1.5,
                      ),
                      alignment: Alignment.center,
                    ),
                    feedback: const FlutterLogo(
                      size: 150,
                      textColor: Colors.red,
                    ),
                    data: "Draged",
                  ),
                  DragTarget<String>(
                    builder: (context, accepted, rejected) {
                      return Container(
                        width: 150,
                        height: 50,
                        child: Text(
                          stD,
                          textScaleFactor: 1.5,
                        ),
                        alignment: Alignment.center,
                      );
                    },
                    onAccept: (data) {
                      setState(() {
                        stD = data;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
