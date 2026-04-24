import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuckingmath_solver/widgets/dataProvider.dart';

class ConditionsBeside extends StatefulWidget {
  ConditionsBeside({
    super.key,
    required this.symbol1,
    required this.symbol2,
    this.canOrNot = true,
  });
  String symbol1;
  String symbol2;
  bool canOrNot;

  @override
  State<ConditionsBeside> createState() => _ConditionsBesideState();
}

class _ConditionsBesideState extends State<ConditionsBeside> {
  void selectChangeSymbol(int symbolIndex) {
    TypeProvider? provider = TypeProvider.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, _setState) {
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
                          ? widget.symbol1
                          : widget.symbol2,
                      onChanged: (value) {
                        _setState(() {
                          setState(() {
                            if (symbolIndex == 1) {
                              widget.symbol1 = value!;
                            } else if (symbolIndex == 2) {
                              widget.symbol2 = value!;
                            }
                          });
                        });
                      },
                      child: Text(e),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    TypeProvider? provider = TypeProvider.of(context);
    rowTypes = provider!.rowTypes;
  }

  late List<String> rowTypes;

  @override
  Widget build(BuildContext context) {
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
                onTap: () => selectChangeSymbol(1),
                child: Text(
                  widget.symbol1,
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
                  setState(() {
                    widget.canOrNot = !widget.canOrNot;
                  });
                },
                child: Text(
                  widget.canOrNot ? "必" : "不",
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
                onTap: () => selectChangeSymbol(2),
                child: Text(
                  widget.symbol2,
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

class ConditionsPosition extends StatefulWidget {
  ConditionsPosition({
    super.key,
    required this.symbol,
    required this.position,
    this.isOrNot = false,
  });
  String symbol;
  int position;
  bool isOrNot;

  @override
  State<ConditionsPosition> createState() =>
      _ConditionsPositionState();
}

class _ConditionsPositionState extends State<ConditionsPosition> {
  void selectChangeSymbol() {
    TypeProvider? provider = TypeProvider.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, _setState) {
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
                      groupValue: widget.symbol,
                      onChanged: (value) {
                        _setState(() {
                          setState(() {
                            widget.symbol = value!;
                          });
                        });
                      },
                      child: Text(e),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  late TextEditingController changePosController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changePosController = TextEditingController(
      text: "${widget.position}",
    );
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () => selectChangeSymbol(),
                child: Text(
                  widget.symbol,
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
                  setState(() {
                    widget.isOrNot = !widget.isOrNot;
                  });
                },
                child: Text(
                  widget.isOrNot ? "只能" : "不能",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Text("在第", style: TextStyle(fontSize: 25)),
            SizedBox(
              width: 40,
              child: TextField(
                controller: changePosController,
                onEditingComplete: () => setState(() {
                  widget.position = int.parse(
                    changePosController.text,
                  );
                  FocusScope.of(context).unfocus();
                }),
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

class ConditionsDirection extends StatefulWidget {
  ConditionsDirection({
    super.key,
    required this.symbol1,
    required this.symbol2,
    required this.leftOrRight,
  });
  String symbol1;
  String symbol2;
  bool leftOrRight;

  @override
  State<ConditionsDirection> createState() =>
      _ConditionsDirectionState();
}

class _ConditionsDirectionState extends State<ConditionsDirection> {
  void selectChangeSymbol(int symbolIndex) {
    TypeProvider? provider = TypeProvider.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, _setState) {
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
                          ? widget.symbol1
                          : widget.symbol2,
                      onChanged: (value) {
                        _setState(() {
                          setState(() {
                            if (symbolIndex == 1) {
                              widget.symbol1 = value!;
                            } else if (symbolIndex == 2) {
                              widget.symbol2 = value!;
                            }
                          });
                        });
                      },
                      child: Text(e),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () => selectChangeSymbol(1),
                child: Text(
                  widget.symbol1,
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
                border: Border.all(
                  color: Colors.blue, // Outline color
                  width: 2.0, // Outline thickness
                ),
              ),
              child: InkWell(
                onTap: () => selectChangeSymbol(2),
                child: Text(
                  widget.symbol2,
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
                onTap: () => setState(() {
                  widget.leftOrRight = !widget.leftOrRight;
                }),
                child: Text(
                  widget.leftOrRight ? "左方" : "右方",
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
