import 'package:flutter/material.dart';
import 'package:flutter_fuckingmath_solver/widgets/conditions.dart';
import 'dataProvider.dart';

class ResultWidget extends StatefulWidget {
  const ResultWidget({super.key});

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  // List<int> rowIndexs = [0, 1, 2];
  late List<String> resultRow;
  late List<String> list;
  late List<bool> isTakens;

  bool isBesideORnot({
    required int index,
    required String nowSymbol,
    required String i,
    required String you,
    required bool besideORnot,
  }) {
    //false可以通過 true這round必須跳過
    //如果是相鄰：只要旁邊有就滿足條件！！不相鄰：兩邊都要同時沒有！！
    if (nowSymbol == i) {
      if (besideORnot) {
        if (index == list.length - 1) {
          if (resultRow[index - 1] == you) {
            return false;
          }
        } else if (index == 0) {
          if (resultRow[index + 1] == you) {
            return false;
          }
        } else if (resultRow[index - 1] == you ||
            resultRow[index + 1] == you) {
          return false;
        }
      } else {
        if (index == list.length - 1) {
          if (!(resultRow[index - 1] == you)) {
            return false;
          }
        } else if (index == 0) {
          if (!(resultRow[index + 1] == you)) {
            return false;
          }
        } else if (!(resultRow[index - 1] == you) &&
            !(resultRow[index + 1] == you)) {
          return false;
        }
      }
    } else {
      return false;
    }

    return true;
  }

  bool isPositionOrNot({
    required String nowSymbol,
    required int nowIndex,
    required int position,
    required String symbol,
    required bool canOnOrNot,
  }) {
    if (nowSymbol == symbol) {
      if ((nowIndex == position - 1) == canOnOrNot) {
        return false;
      }
    } else {
      return false;
    }
    return true;
  }

  bool isLeftOrRight({
    required int index,
    required String nowSymbol,
    required String i,
    required String you,
    required bool leftOrRight,
  }) {
    if (nowSymbol == i) {
      if (leftOrRight) {
        if (resultRow.indexWhere((x) => x == you) < index) {
          return false;
        }
      } else {
        if (resultRow.indexWhere((x) => x == you) > index) {
          return false;
        }
      }
    } else {
      return false;
    }

    return true;
  }

  String pText = "";
  int count = 0;
  int waitMicroseconds = 0;
  List<Condition> conditions = [];

  //計算總排列數的方法
  Future<void> calculatePermutation(int i) async {
    if (i == list.length) {
      if (!mounted) return;
      setState(() {
        pText = "$resultRow"
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll(",", "");
        count++;
        print(resultRow);
      });
      // print(resultRow);
      await Future.delayed(Duration(microseconds: waitMicroseconds));
      return;
    }
    for (var j = 0; j < list.length; j++) {
      if (!mounted) return;
      if (!isTakens[j]) {
        //條件判斷
        bool needToContinue = false; //當=false，代表可以過這一關

        //遍歷所有的條件
        for (Condition c in conditions) {
          if (c.conditionmod == conditionMod.beside) {
            needToContinue = isBesideORnot(
              index: j,
              nowSymbol: list[i],
              i: c.symbol2!,
              you: c.symbol1,
              besideORnot: c.besideOrNot!,
            );
            //如果有其中一個條件不符合這個排列就不能算
            if (needToContinue) {
              break;
            }
          } else if (c.conditionmod == conditionMod.position) {
            needToContinue = isPositionOrNot(
              nowSymbol: list[i],
              nowIndex: j,
              position: c.position!,
              symbol: c.symbol1,
              canOnOrNot: c.canOnOrNot!,
            );
            if (needToContinue) {
              break;
            }
          } else if (c.conditionmod == conditionMod.direction) {
            needToContinue = isLeftOrRight(
              index: j,
              nowSymbol: list[i],
              i: c.symbol2!,
              you: c.symbol1,
              leftOrRight: c.leftOrRight!,
            );
            if (needToContinue) {
              break;
            }
          }
        }

        if (needToContinue) {
          continue;
        }
        resultRow[j] = list[i];
        isTakens[j] = true;

        await calculatePermutation(i + 1);

        isTakens[j] = false;
        resultRow[j] = ":)";
      }
    }
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //設定排列參數
    TypeProvider? provider = TypeProvider.of(context);
    list = provider!.mainRow;
    resultRow = List.generate(
      list.length,
      (i) => ":)",
      growable: true,
    );
    isTakens = List.generate(
      list.length,
      (i) => false,
      growable: true,
    );
    pText = "$list"
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll(",", "");
    conditions = provider.conditions!;

    //把排序用好
    for (Condition c in conditions) {
      if (c.conditionmod == conditionMod.beside) {
        int i_index = list.indexWhere((x) => x == c.symbol2);
        int you_index = list.indexWhere((x) => x == c.symbol1);

        //符號互換
        if (i_index < you_index) {
          String temp = c.symbol2!;
          c.symbol2 = c.symbol1;
          c.symbol1 = temp;
        }
      }
      if (c.conditionmod == conditionMod.direction) {
        int i_index = list.indexWhere((x) => x == c.symbol2);
        int you_index = list.indexWhere((x) => x == c.symbol1);

        if (i_index < you_index) {
          String temp = c.symbol2!;
          c.symbol2 = c.symbol1;
          c.symbol1 = temp;
          c.leftOrRight = !c.leftOrRight!;
        }
      }
    }
    // 創造有觀賞性的間隔秒數
    waitMicroseconds = list.length <= 4
        ? (4 / list.length).round() * 10000
        : (10 / list.length).round();
    if (list.length <= 4) {
      waitMicroseconds = (4 / list.length).round() * 10000;
    } else if (list.length >= 5 && list.length < 7) {
      waitMicroseconds = (6 / list.length).round() * 1000;
    } else if (list.length == 7) {
      waitMicroseconds = 999;
    } else if (list.length > 7) {
      waitMicroseconds = 1;
    }
    print("等待時間為$waitMicroseconds");
    await Future.delayed(Duration(seconds: 1));

    calculatePermutation(0);
  }

  void text(List<String> list) {
    for (var i = 0; i < list.length; i++) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: Container(
          height: 5,
          width: 80,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(.circular(60)),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(.circular(20)),
          image: DecorationImage(
            image: AssetImage("pics/catmath.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 1),
              BlendMode.modulate,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text.rich(
                    TextSpan(
                      children: pText.split("").map((char) {
                        if (char == " ") {
                          return TextSpan(
                            text: char,
                            style: TextStyle(fontSize: 50),
                          );
                        } else {
                          return TextSpan(
                            text: char,
                            style: TextStyle(
                              fontSize: 50,
                              fontFamily: "Cubic",
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              color: Colors.white,
                            ),
                          );
                        }
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 50,
                ),
                child: Divider(),
              ),
              Text(
                "目前計算出$count個",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
