import 'package:flutter/material.dart';
import 'dart:async';

import 'shogiManager.dart';

class HPns extends StatefulWidget {
  const HPns({Key? key}) : super(key: key);

  @override
  State<HPns> createState() => PageNotShogi();
}

class PageNotShogi extends State<HPns> {
  var shogi = ShogiManage.notShogi();
  bool cpuTurn = false;
  late int seed, index;
  @override
  void initState() {
    setState(() {
      shogi.rnd.get();
      seed = shogi.rnd.seed_number;
      index = shogi.rnd.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                            shogi.rnd.get();
                            seed = shogi.rnd.seed_number;
                            index = shogi.rnd.index;
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
            }, size, "notshogi", seed, index),
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
