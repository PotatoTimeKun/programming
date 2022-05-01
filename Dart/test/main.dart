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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var isexp = false;
  int _i = 1, _ix = 1, _ix2 = 1, _ix3 = 1;
  double _il2x = 0, _il10x = 0, _ilnx = 0;
  String title3 = "3rd Page";
  int dropv = 0;
  double incr = 1;
  final _scafKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  var isSel = [true, false];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    void _iPlus({int val = 1}) {
      setState(() {
        _i += val;
        _ix += val;
        _ix2 = _i * _i;
        _ix3 = _i * _i * _i;
        _il2x = log(_i) / log(2);
        _il10x = log(_i) / log(10);
        _ilnx = log(_i);
      });
    }

    return Scaffold(
      key: _scafKey,
      appBar: AppBar(
        title: Text(widget.title),
        leading: const IconButton(
          icon: Icon(Icons.web),
          onPressed: _launchUrl,
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem>[
                PopupMenuItem(
                    child: TextButton(
                  onPressed: () {
                    setState(() {
                      _i = 1;
                      _ix = 1;
                      _ix2 = _i * _i;
                      _ix3 = _i * _i * _i;
                      _il2x = log(_i) / log(2);
                      _il10x = log(_i) / log(10);
                      _ilnx = log(_i);
                    });
                  },
                  child: const Text("x reset"),
                )),
                PopupMenuItem(
                    child: TextButton(
                  onPressed: () {
                    setState(() {
                      _i = 1;
                      _ix = 1;
                      _ix2 = _i * _i;
                      _ix3 = _i * _i * _i;
                      _il2x = log(_i) / log(2);
                      _il10x = log(_i) / log(10);
                      _ilnx = log(_i);
                      _iPlus(val: 9999);
                    });
                  },
                  child: const Text("x to 10000"),
                )),
              ];
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scafKey.currentState!.openEndDrawer();
            },
          ),
        ],
        bottom: TabBar(
          tabs: const [
            Tab(
              icon: Icon(Icons.mail),
            ),
            Tab(
              icon: Icon(Icons.youtube_searched_for),
            ),
          ],
          controller: _tabController,
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          children: const <Widget>[Spacer(), Text("drawer"), Spacer()],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isexpan) {
                      setState(() {
                        isexp = !isexp;
                      });
                    },
                    children: [
                      ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isexpan) {
                            return ListTile(
                              title: Text("x=$_i"),
                            );
                          },
                          body: Text(
                            'y=x:\n  y=$_ix\n  f\'($_i)=1\ny=x^2:\n  y=$_ix2\n  f\'($_i)=${2 * _i}\ny=x^3:\n  y=$_ix3\n  f\'($_i)=${3 * _i * _i}\ny=log[2]x:\n  y=$_il2x\n  f\'($_i)=${1 / (_i * log(2))}\ny=log[10]x:\n  y=$_il10x\n  f\'($_i)=${1 / (_i * log(10))}\ny=log[e]x:\n  y=$_ilnx\n  f\'($_i)=${1 / _i}',
                            textAlign: TextAlign.left,
                            textScaleFactor: 1.5,
                          ),
                          isExpanded: isexp)
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SecHomePage();
                          }));
                        },
                        child: const Text("Next Page"),
                      ),
                      ColoredBox(
                        color: Colors.grey,
                        child: TextButton.icon(
                          icon: const Icon(Icons.arrow_forward),
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
                          label: Text(title3),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ForHomePage();
                          }));
                        },
                        child: const Text("4th Page"),
                      ),
                    ],
                  ),
                  DropdownButton(
                      value: dropv,
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                            value: 0,
                            child: TextButton(
                                onPressed: () {
                                  _iPlus(val: 10);
                                },
                                child: const Text("+10"))),
                        DropdownMenuItem(
                            value: 1,
                            child: TextButton(
                                onPressed: () {
                                  _iPlus(val: 100);
                                },
                                child: const Text("+100"))),
                        DropdownMenuItem(
                            value: 2,
                            child: TextButton(
                                onPressed: () {
                                  _iPlus(val: -1);
                                },
                                child: const Text("-1"))),
                      ],
                      onChanged: (dynamic value) {
                        setState(() {
                          dropv = value;
                        });
                      }),
                  ToggleButtons(
                    children: const [
                      Icon(Icons.add),
                      Icon(Icons.do_not_disturb_on)
                    ],
                    isSelected: isSel,
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < 2; i++) {
                          if (i == index) {
                            isSel[i] = true;
                          } else {
                            isSel[i] = false;
                          }
                        }
                      });
                    },
                  ),
                  Slider.adaptive(
                      value: incr,
                      divisions: 10,
                      min: 1,
                      max: 100,
                      label: "+ ${incr.toInt()}",
                      onChanged: (double val) {
                        setState(() {
                          incr = val;
                        });
                      }),
                  const CircularProgressIndicator()
                ],
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Flexible Space Bar"),
                  centerTitle: true,
                  background: FlutterLogo(),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ListTile(
                    title: Text('$index'),
                  );
                }, childCount: 30),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _iPlus(val: incr.toInt());
        },
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
  var _v = "";
  var _t = "";
  var _d = "";
  Future _sel() async {
    DateTime? sel = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2023),
        locale: Localizations.localeOf(context));
    if (sel != null) {
      setState(() {
        _v = sel.toString();
      });
    }
  }

  Future _selt() async {
    TimeOfDay? selt =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selt != null) {
      setState(() {
        _t = selt.toString();
      });
    }
  }

  Future _dia() async {
    var ans = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("question"),
            children: <Widget>[
              SimpleDialogOption(
                child: const Text("option 1"),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),
              SimpleDialogOption(
                child: const Text("option 2"),
                onPressed: () {
                  Navigator.pop(context, 2);
                },
              ),
            ],
          );
        });
    switch (ans) {
      case 1:
        setState(() {
          _d = "1";
        });
        break;
      case 2:
        setState(() {
          _d = "2";
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("4th Page"),
        ),
        body: RefreshIndicator(
            child: ListView(
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const FivHomePage();
                      }));
                    },
                    child: const Text("5th Page"),
                  ),
                ),
                Tooltip(
                  message: 'card',
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text("this is card"),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(_v),
                  subtitle: TextButton(
                    onPressed: _sel,
                    child: const Text("select date"),
                  ),
                ),
                ListTile(
                  title: Text(_t),
                  subtitle: TextButton(
                    onPressed: _selt,
                    child: const Text("select time"),
                  ),
                ),
                ListTile(
                  title: Text(_d),
                  subtitle: TextButton(
                    onPressed: _dia,
                    child: const Text("dialog"),
                  ),
                ),
              ],
            ),
            onRefresh: () {
              return Future.delayed(const Duration(seconds: 5), () {});
            }));
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
