import 'package:flutter/material.dart';
import 'package:flutter_fuckingmath_solver/widgets/conditions.dart';

class TypeProvider extends InheritedWidget {
  TypeProvider({
    required this.rowTypes,
    required this.child,
    required this.mainRow,
    this.conditions,
    this.changeCondition,
    this.removeCondition,
  }) : super(child: child);
  List<String> rowTypes;
  List<String> mainRow;
  List<Condition>? conditions;
  Function(int, Condition)? changeCondition;
  Function(Condition)? removeCondition;
  Widget child;

  //尋找最上層的資料提供者
  static TypeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TypeProvider>();
  }

  //檢測什麼時候該重新廣播一次
  @override
  bool updateShouldNotify(TypeProvider oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.rowTypes != rowTypes;
  }
}
