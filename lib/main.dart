import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/conditions.dart';
import 'widgets/dataProvider.dart';
import 'widgets/result.dart';

void main() {
  runApp(const MaterialApp(home: ThemainRow()));
}

class ThemainRow extends StatefulWidget {
  const ThemainRow({super.key});
  @override
  State<ThemainRow> createState() => _ThemainRowState();
}

class _ThemainRowState extends State<ThemainRow> {
  //排列組合排的人
  Widget RowSymbol(String text) {
    return Card(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          style: TextStyle(fontSize: 50, fontFamily: "Cubic"),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  //主列
  late List<String> mainRow;
  List<String> mainRowTypes() {
    //檢查出所有的種類但不重複
    List<String> noRepeat = [];
    for (var s in mainRow) {
      if (!noRepeat.contains(s)) {
        noRepeat.add(s);
      }
    }
    return noRepeat;
  }

  late TextEditingController addItemController;

  //條件列
  late List<Widget> ConditionsRow;

  late List<bool> isSelections;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainRow = ["A", "B", "C"];
    ConditionsRow = [];
    addItemController = TextEditingController();
    isSelections = [false, false, false];
  }

  //給row縮放用的
  double scale = 1;
  bool notNeed = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> MainRowWidget() {
      List<Widget> l = [];
      for (var i = 0; i < mainRow.length; i++) {
        l.add(
          Dismissible(
            key: UniqueKey(),
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.up,
              background: Center(
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 50,
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  mainRow.removeAt(i);
                });
              },
              child: RowSymbol(mainRow[i]),
            ),
          ),
        );
      }
      return l;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "最強排列暴力計算機",
          style: TextStyle(fontFamily: "Cubic", color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("pics/math.jpg"),
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.6),
              BlendMode.darken,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            //調整排列組合的項目
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 280,
                child: Card(
                  color: Colors.blueGrey[100]!.withValues(alpha: 0.6),
                  shadowColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: .circular(50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        flex: 2,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Row(children: MainRowWidget()),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10,
                        ),
                        child: Divider(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 90,
                              child: TextField(
                                controller: addItemController,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Cubic",
                                ),
                                textAlign: TextAlign.center,
                                textInputAction: TextInputAction.done,
                                cursorColor: Colors.orange,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      .circular(50),
                                    ),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.grey[800]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      .circular(50),
                                    ),

                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            IconButton.filled(
                              onPressed: () {
                                if (addItemController.text != "") {
                                  setState(() {
                                    mainRow.add(
                                      addItemController.text,
                                    );
                                  });
                                }
                                print(mainRow);
                                print("種類${mainRowTypes()}");
                                FocusManager.instance.primaryFocus
                                    ?.unfocus();
                              },
                              icon: Icon(Icons.add, size: 50),
                              // color: Colors.amber,
                              style: IconButton.styleFrom(
                                foregroundColor: Colors.orange[700],
                                backgroundColor: Colors.orange[300],
                                overlayColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 25,
              ),
              child: Divider(),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, _setState) {
                        return AlertDialog(
                          content: ToggleButtons(
                            direction: Axis.vertical,
                            borderRadius: BorderRadius.circular(10),
                            // selectedBorderColor: Colors.amber,
                            selectedColor: Colors.orange,
                            fillColor: Colors.amber,
                            splashColor: Colors.amber,

                            onPressed: (index) {
                              _setState(() {
                                for (
                                  var i = 0;
                                  i < isSelections.length;
                                  i++
                                ) {
                                  if (i != index)
                                    isSelections[i] = false;
                                }
                                isSelections[index] =
                                    !isSelections[index];
                              });
                            },
                            isSelected: isSelections,
                            children: [
                              Text("相鄰條件"),
                              Text("位置條件"),
                              Text("相對條件"),
                            ],
                          ),
                          title: Text("選擇要加入的條件"),
                          actions: [
                            IconButton.filled(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                              ),
                              onPressed: () {
                                if (isSelections[0]) {
                                  setState(() {
                                    ConditionsRow.add(
                                      ConditionsBeside(
                                        symbol1: mainRow[0],
                                        symbol2: mainRow[1],
                                      ),
                                    );
                                  });
                                } else if (isSelections[1]) {
                                  setState(() {
                                    ConditionsRow.add(
                                      ConditionsPosition(
                                        symbol: mainRow[0],
                                        position: 1,
                                      ),
                                    );
                                  });
                                } else if (isSelections[2]) {
                                  setState(() {
                                    ConditionsRow.add(
                                      ConditionsDirection(
                                        symbol1: mainRow[0],
                                        symbol2: mainRow[1],
                                        leftOrRight: true,
                                      ),
                                    );
                                  });
                                }
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.check),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              label: Text(
                "增加條件",
                style: TextStyle(fontFamily: "Cubic", fontSize: 20),
              ),
              iconAlignment: IconAlignment.end,
              icon: Icon(Icons.add, size: 50),
              // color: Colors.amber,
              style: IconButton.styleFrom(
                foregroundColor: Colors.orange[700],
                backgroundColor: Colors.orange[300],
                overlayColor: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: ListView.builder(
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          ConditionsRow.removeAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        child: Center(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                          ),

                          child: TypeProvider(
                            rowTypes: mainRowTypes(),
                            mainRow: mainRow,
                            child: ConditionsRow[index],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: ConditionsRow.length,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCupertinoSheet(
            context: context,
            builder: (context) => TypeProvider(
              rowTypes: mainRowTypes(),
              mainRow: mainRow,
              child: ResultWidget(),
            ),
          );
        },
        backgroundColor: Colors.orange,
        foregroundColor: Colors.orange[900],
        splashColor: Colors.white,
        child: Icon(Icons.calculate_rounded, size: 50),
      ),
    );
  }
}
