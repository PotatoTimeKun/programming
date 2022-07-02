import 'package:flutter/material.dart';

import 'shogiManager.dart';

class HPban extends StatefulWidget {
  const HPban({Key? key}) : super(key: key);

  @override
  State<HPban> createState() => PageBan();
}

class PageBan extends State<HPban> {
  late var shogi;
  late int seed,index;
  @override
  void initState(){
    setState((){
      shogi=ShogiManage();
      shogi.rnd.get();
      seed=shogi.rnd.seed_number;
      index=shogi.rnd.index;
      shogi.bakudan();
    });
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("爆弾なう"),
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
                            shogi=ShogiManage();
                            shogi.rnd.get();
                            seed=shogi.rnd.seed_number;
                            index=shogi.rnd.index;
                            shogi.bakudan();
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
            }, size,"ban",seed,index),
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
                          shogi.nextBan();
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
