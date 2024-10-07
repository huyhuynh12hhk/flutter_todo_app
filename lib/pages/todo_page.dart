import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  TextEditingController tController = TextEditingController();
  String msg = "";

  void greet() {
    setState(() {
      msg = "Message: " + tController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(msg),

              TextField(
                controller: tController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Type something here"),
              ),
              ElevatedButton(onPressed: greet, child: Text("Tap here"))
            ],
          ),
        ),
      ),
    );
  }
}
