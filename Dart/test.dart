void main() {
  var a = 10;
  print("a=$a");
  String b = "he";
  b += 'llo ワールド';
  print(b);
  List l = [];
  l.add(1);
  l.add("a");
  print("l=$l,${l.length}");
  Set s = {2};
  s.add(1);
  s.add(2);
  print("s=$s");
  Map<int, String> m = {};
  m.addAll({2: "b"});
  m.addAll({8: "potato"});
  print("m=$m,m[8]=${m[8]}");
  Runes r = new Runes("\u2665");
  print(new String.fromCharCodes(r));
  dynamic d;
  d = 1;
  print("d=$d");
  d = 'a';
  print("d=$d");
  final f = 1;
  const c = 3;
  List li = const [2, 5, 6];
  print("int.parse(\"10\") == 10 -> ${int.parse("10") == 10}");
  li.forEach((element) {
    print("forEach:$element");
  });
  for (int i = 0; i < c; i++) {
    print("for:${li[i]}");
  }
  for (var i in l) {
    print("forin:$i");
  }
  int w = 2;
  while (w != 0) {
    print("while:$w");
    w--;
  }
  w = 0;
  do {
    print("do-while:$w");
  } while (w != 0);
  String st = "abc";
  switch (st) {
    case "abc":
      print("switch");
      break;
    default:
  }
  int func(int a) {
    return a * a;
  }

  print("func(5) -> ${func(5)}");
  int ar(int a) => -a;
  print("ar(2) -> ${ar(2)}");
  void funchi({int a = 0, int b = 0}) {
    print("funchi:a=$a,b=$b");
  }

  funchi(a: 1);
  void funcnu(int a, [int b = 0, int c = 0]) {
    print("funcnu:a=$a,b=$b,c=$c");
  }

  funcnu(1, 2);
  try {
    throw Exception(1);
  } catch (e) {
    print(e);
  } finally {
    print(2);
  }
  String ms = '''
a
b
c''';
  print(ms);
  var noname = (int a) {
    print("noname:$a");
  };
  noname(10);
  Function kl(num a) {
    return (num b) => a + b;
  }

  var funkl = kl(7);
  print("funkl(2):${funkl(2)}");
  tesCl tc = new tesCl.fitx("hello");
  tc._i = 1;
  tc.show();
  print(tesCl.st);
  tes2Cl t2 = tes2Cl();
  t2.show();
  tes3Cl t3 = tes3Cl();
  print(t3());
}

abstract class abCl {
  void show();
}

class tesCl implements abCl {
  static String st = "static";
  String fitx = "";
  int _i = 0;
  tesCl();
  tesCl.fitx(this.fitx);
  int get i => _i;
  set i(int v) => _i = v;
  void show() {
    print("fitx:$fitx,_i:$_i");
  }
}

class tes2Cl extends tesCl {
  @override
  void show() {
    print("aaaaaaaaaaaaaa");
  }
}

mixin te on tesCl {
  int d = 0;
}

class tes3Cl extends tesCl with te {
  @override
  void show() {
    print("$d aaaaaaaaaaaaaa");
  }

  String call() => "$d,$_i";
}
