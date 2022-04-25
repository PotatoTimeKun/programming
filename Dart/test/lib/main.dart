import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Potato',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const MyHomePage(title:'function'),
    );
  }
}

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key key=const Key(''),this.title=""}):super(key: key);
  final String title;
  @override
  _MyHomePageState createState()=>_MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{
  int _i=1,_ix=1,_ix2=1,_ix3=1;
  double _il2x=0,_il10x=0,_ilnx=0;
  @override
  Widget build(BuildContext context){
    void _iPlus(){
      setState(() {
        _i++;
        _ix++;
        _ix2=_i*_i;
        _ix3=_i*_i*_i;
        _il2x=log(_i)/log(2);
        _il10x=log(_i)/log(10);
        _ilnx=log(_i);
      });
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'x=$_i\ny=x:\n  y=$_ix\n  f\'($_i)=1\ny=x^2:\n  y=$_ix2\n  f\'($_i)=${2*_i}\ny=x^3:\n  y=$_ix3\n  f\'($_i)=${3*_i*_i}\ny=log[2]x:\n  y=$_il2x\n  f\'($_i)=${1/(_i*log(2))}\ny=log[10]x:\n  y=$_il10x\n  f\'($_i)=${1/(_i*log(10))}\ny=log[e]x:\n  y=$_ilnx\n  f\'($_i)=${1/_i}',
              textAlign: TextAlign.left,
              textScaleFactor: 1.5,
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return secHomePage();
              }));
            }, child: const Text("Next Page"),
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _iPlus,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class secHomePage extends StatefulWidget{
  const secHomePage({Key key=const Key(''),this.title=""}):super(key: key);
  final String title;
  @override
  secPageState createState()=>secPageState();
}

class secPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: secHomePage(),
    );
  }
}

class secPageState extends State<secHomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("2nd Page"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                'images/potato.jpg',
              fit: BoxFit.fitWidth,
            ),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Back Page"),
            )
          ],
        ),
      ),
    );
  }
}