import 'package:hive_flutter/adapters.dart';

class TodoDatabase{
  List todoList=[];

  static const TODOKEY = "TODOKEY";

  final  _todoBox = Hive.box("TodoBox");

  void createInitialData(){
    todoList=[
      ["Make breakfast", false],
      ["Take a shower", false]
    ];
  }

  void loadData(){
    todoList = _todoBox.get(TODOKEY);
  }

  void updateDatabase(){
    _todoBox.put(TODOKEY, todoList);
  }
}