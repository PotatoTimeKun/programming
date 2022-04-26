import 'dart:math';

import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'function'),
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
                return secHomePage();
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
                      return serHomePage(
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
          )
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

class secHomePage extends StatefulWidget {
  const secHomePage({Key key = const Key(''), this.title = ""})
      : super(key: key);
  final String title;
  @override
  secPageState createState() => secPageState();
}

class secPageState extends State<secHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2nd Page"),
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
            Spacer(
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
            Spacer(
              flex: 1,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back Page"),
            ),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}

class serHomePage extends StatefulWidget {
  const serHomePage({Key key = const Key(''), this.title = "", this.data = 1})
      : super(key: key);
  final String title;
  final int data;
  @override
  serPageState createState() => serPageState(data);
}

class serPageState extends State<serHomePage> {
  serPageState(this.data);
  final int data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("3rd Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("x=$data"),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, "already visited");
                },
                child: const Text("Back"))
          ],
        ),
      ),
    );
  }
}
