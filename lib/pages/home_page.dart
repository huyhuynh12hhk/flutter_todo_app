import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_title.dart';
import 'package:todo_app/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final _todoBox = Hive.box('TodoBox');

  final _controller = TextEditingController();


  TodoDatabase db = TodoDatabase();
  

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask(){
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller, 
            onCancel: ()=> Navigator.of(context).pop(),
            onSave : ()=> saveNewTask(),
          );
        });
  }

  @override
  void initState() {
    if(_todoBox.get(TodoDatabase.TODOKEY) == null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        
        appBar: AppBar(
          backgroundColor: Colors.yellow[400],
          title: Text("TO DO"),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          
          child: Icon(Icons.add),
          shape: CircleBorder(),
        ),
        body: ListView.builder(
            itemCount: db.todoList.length,
            itemBuilder: (context, index) {
              return TodoTitle(
                taskName: db.todoList[index][0],
                taskCompleted: db.todoList[index][1],
                onChanged: (value) => checkboxChanged(value, index),
                deleteFunction: (p0) => deleteTask(index),
              );
            }));
  }
}
