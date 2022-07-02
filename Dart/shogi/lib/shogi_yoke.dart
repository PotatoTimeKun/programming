import 'package:flutter/material.dart';
import 'dart:async';

import 'shogiManager.dart';

class HPyk extends StatefulWidget {
  const HPyk({Key? key}) : super(key: key);

  @override
  State<HPyk> createState() => PageShogiYoke();
}

class PageShogiYoke extends State<HPyk> {
  var shogi = ShogiManage();
  late Timer timer;
  late int seed,index;
  @override
  void initState() {
    setState((){
      shogi.rnd.get();
      seed=shogi.rnd.seed_number;
      index=shogi.rnd.index;
    });
    timer = Timer.periodic(
      const Duration(milliseconds: 1000),
      (Timer timer) {
        setState(() {
          shogi.nextYoke();
        });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("将棋避けなう"),
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
                  ],
                )),
            shogiTableBuild(shogi, () {
              setState(() {
                shogi.winner = "";
              });
            }, size,"yoke",seed,index),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.all(10),
                        width: 150,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.blue),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                shogi.move(-1);
                              });
                            },
                            child: const Text(
                              "<---",
                              style: TextStyle(color: Colors.black),
                            ))),
                    Container(
                        margin: const EdgeInsets.all(10),
                        width: 150,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.blue),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                shogi.move(1);
                              });
                            },
                            child: const Text(
                              "--->",
                              style: TextStyle(color: Colors.black),
                            ))),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
