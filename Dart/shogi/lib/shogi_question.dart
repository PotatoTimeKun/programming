import 'package:flutter/material.dart';
import 'dart:async';

import 'shogiManager.dart';

class HP2nd extends StatefulWidget {
  const HP2nd({Key? key}) : super(key: key);

  @override
  State<HP2nd> createState() => Page2nd();
}

class Page2nd extends State<HP2nd> {
  var shogi = ShogiManage();
  bool cpuTurn = false;
  late int seed,index;
  @override
  void initState(){
    setState((){
      shogi.rnd.get();
      seed=shogi.rnd.seed_number;
      index=shogi.rnd.index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                            shogi.rnd.get();
                            seed=shogi.rnd.seed_number;
                            index=shogi.rnd.index;
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
            shogiTableBuild(shogi, () {
              setState(() {
                shogi.winner = "";
              });
            }, size,"shogi?",seed,index),
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
