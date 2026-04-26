import 'package:flutter/material.dart';
import 'package:flutter_fuckingmath_solver/widgets/dataProvider.dart';

//傳入的條件class
class Condition {
  Condition({
    required this.conditionmod,
    required this.symbol1,
    this.symbol2,
    this.besideOrNot,
    this.leftOrRight,
    this.canOnOrNot,
    this.position,
  });
  conditionMod conditionmod;
  String symbol1;
  //相鄰或相對位置
  String? symbol2;
  //判斷相鄰
  bool? besideOrNot;
  //判斷相對位置
  bool? leftOrRight;
  //判斷位置
  bool? canOnOrNot;
  int? position;
}

enum conditionMod { beside, direction, position }

class ConditionBeside extends StatelessWidget {
  ConditionBeside({
    super.key,
    required this.besideCondition,
    required this.conditionIndex,
  });

  final Condition besideCondition;
  final int conditionIndex;

  void changeOneValueOfCondition({
    required String valueName,
    required var value,
    required TypeProvider provider,
  }) {
    provider.changeCondition!(
      conditionIndex,
      Condition(
        conditionmod: conditionMod.beside,
        symbol1: valueName == "symbol1"
            ? value
            : besideCondition.symbol1,
        symbol2: valueName == "symbol2"
            ? value
            : besideCondition.symbol2,
        besideOrNot: valueName == "besideOrNot"
            ? value
            : besideCondition.besideOrNot,
      ),
    );
  }

  void selectChangeSymbol(int symbolIndex, BuildContext context) {
    TypeProvider? provider = TypeProvider.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: provider!.rowTypes.map((e) {
              return RadioTheme(
                data: RadioThemeData(
                  fillColor: WidgetStatePropertyAll(
                    Colors.amber[900],
                  ),
                ),
                child: RadioMenuButton(
                  value: e,
                  groupValue: symbolIndex == 1
                      ? besideCondition.symbol1
                      : besideCondition.symbol2,
                  onChanged: (value) {
                    changeOneValueOfCondition(
                      valueName: symbolIndex == 1
                          ? "symbol1"
                          : "symbol2",
                      value: value,
                      provider: provider,
                    );
                    Navigator.pop(context);
                  },
                  child: Text(e),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  late List<String> rowTypes;

  @override
  Widget build(BuildContext context) {
    TypeProvider? provider = TypeProvider.of(context);

    return FittedBox(
      child: Card(
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(.circular(10)),
                border: Border.all(
                  color: Colors.blue, // Outline color
                  width: 2.0, // Outline thickness
                ),
              ),
              child: InkWell(
                onTap: () => selectChangeSymbol(1, context),
                child: Text(
                  besideCondition.symbol1,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(.circular(10)),
              ),
              child: InkWell(
                onTap: () {
                  changeOneValueOfCondition(
                    valueName: "besideOrNot",
                    value: !besideCondition.besideOrNot!,
                    provider: provider!,
                  );
                },
                child: Text(
                  besideCondition.besideOrNot! ? "必" : "不",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Text("相鄰於", style: TextStyle(fontSize: 25)),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(.circular(10)),
                border: Border.all(
                  color: Colors.blue, // Outline color
                  width: 2.0, // Outline thickness
                ),
              ),
              child: InkWell(
                onTap: () => selectChangeSymbol(2, context),
                child: Text(
                  besideCondition.symbol2!,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConditionPosition extends StatelessWidget {
  ConditionPosition({
    super.key,
    required this.positionCondition,
    required this.conditionIndex,
  });
  final Condition positionCondition;
  final int conditionIndex;

  void changeOneValueOfCondition({
    required String valueName,
    required var value,
    required TypeProvider provider,
  }) {
    provider.changeCondition!(
      conditionIndex,
      Condition(
        conditionmod: conditionMod.position,
        symbol1: valueName == "symbol1"
            ? value
            : positionCondition.symbol1,
        position: valueName == "position"
            ? value
            : positionCondition.position,
        canOnOrNot: valueName == "canOnOrNot"
            ? value
            : positionCondition.canOnOrNot,
      ),
    );
  }

  void selectChangeSymbol(int symbolIndex, BuildContext context) {
    TypeProvider? provider = TypeProvider.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: provider!.rowTypes.map((e) {
              return RadioTheme(
                data: RadioThemeData(
                  fillColor: WidgetStatePropertyAll(
                    Colors.amber[900],
                  ),
                ),
                child: RadioMenuButton(
                  value: e,
                  groupValue: positionCondition.symbol1,
                  onChanged: (value) {
                    changeOneValueOfCondition(
                      valueName: "symbol1",
                      value: value,
                      provider: provider,
                    );
                    Navigator.pop(context);
                  },
                  child: Text(e),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TypeProvider? provider = TypeProvider.of(context);
    TextEditingController changePosController = TextEditingController(
      text: "${positionCondition.position}",
    );

    return FittedBox(
      child: Card(
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(.circular(10)),
                border: Border.all(color: Colors.blue, width: 2.0),
              ),
              child: InkWell(
                onTap: () => selectChangeSymbol(1, context),
                child: Text(
                  positionCondition.symbol1,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(.circular(10)),
              ),
              child: InkWell(
                onTap: () {
                  changeOneValueOfCondition(
                    valueName: "canOnOrNot",
                    value: !positionCondition.canOnOrNot!,
                    provider: provider!,
                  );
                },
                child: Text(
                  positionCondition.canOnOrNot! ? "只能" : "不能",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Text("在第", style: TextStyle(fontSize: 25)),
            SizedBox(
              width: 40,
              child: TextField(
                controller: changePosController,
                onEditingComplete: () {
                  changeOneValueOfCondition(
                    valueName: "position",
                    value: int.parse(changePosController.text),
                    provider: provider!,
                  );
                  FocusScope.of(context).unfocus();
                },
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Text("位", style: TextStyle(fontSize: 25)),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class ConditionDirection extends StatelessWidget {
  ConditionDirection({
    super.key,
    required this.directionCondition,
    required this.conditionIndex,
  });
  final Condition directionCondition;
  final int conditionIndex;

  void changeOneValueOfCondition({
    required String valueName,
    required var value,
    required TypeProvider provider,
  }) {
    provider.changeCondition!(
      conditionIndex,
      Condition(
        conditionmod: conditionMod.direction,
        symbol1: valueName == "symbol1"
            ? value
            : directionCondition.symbol1,
        symbol2: valueName == "symbol2"
            ? value
            : directionCondition.symbol2,
        leftOrRight: valueName == "leftOrRight"
            ? value
            : directionCondition.leftOrRight,
      ),
    );
  }

  void selectChangeSymbol(int symbolIndex, BuildContext context) {
    TypeProvider? provider = TypeProvider.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: provider!.rowTypes.map((e) {
              return RadioTheme(
                data: RadioThemeData(
                  fillColor: WidgetStatePropertyAll(
                    Colors.amber[900],
                  ),
                ),
                child: RadioMenuButton(
                  value: e,
                  groupValue: symbolIndex == 1
                      ? directionCondition.symbol1
                      : directionCondition.symbol2,
                  onChanged: (value) {
                    changeOneValueOfCondition(
                      valueName: symbolIndex == 1
                          ? "symbol1"
                          : "symbol2",
                      value: value,
                      provider: provider,
                    );
                    Navigator.pop(context);
                  },
                  child: Text(e),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TypeProvider? provider = TypeProvider.of(context);

    return FittedBox(
      child: Card(
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(.circular(10)),
                border: Border.all(color: Colors.blue, width: 2.0),
              ),
              child: InkWell(
                onTap: () => selectChangeSymbol(1, context),
                child: Text(
                  directionCondition.symbol1,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Text("位於", style: TextStyle(fontSize: 25)),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(.circular(10)),
                border: Border.all(color: Colors.blue, width: 2.0),
              ),
              child: InkWell(
                onTap: () => selectChangeSymbol(2, context),
                child: Text(
                  directionCondition.symbol2!,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Text("的", style: TextStyle(fontSize: 25)),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(.circular(10)),
              ),
              child: InkWell(
                onTap: () {
                  changeOneValueOfCondition(
                    valueName: "leftOrRight",
                    value: !directionCondition.leftOrRight!,
                    provider: provider!,
                  );
                },
                child: Text(
                  directionCondition.leftOrRight! ? "左方" : "右方",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
