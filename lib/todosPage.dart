import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learn/model/todo.dart';

final mockTodos = Iterable.generate(
  100,
  (index) => Todo("${Random().nextInt(1000)}", "Todo #${index + 1}", false),
);

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  List<Todo> _todos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todos = mockTodos.toList();
  }

  void toggleTodo(int index) {
    setState(() {
      _todos.elementAt(index).done = !_todos.elementAt(index).done;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TodosList(_todos, toggleTodo),
      )),
    );
  }
}

class TodosList extends StatelessWidget {
  final List<Todo> list;
  final toggleTodo;
  const TodosList(this.list, this.toggleTodo);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      physics: const ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var todo = list.elementAt(index);
        return Card(
          child: ListTile(
            leading: IconButton(
              onPressed: () {
                toggleTodo(index);
              },
              icon: Icon(
                (!todo.done) ? Icons.rectangle_outlined : Icons.done_outline,
              ),
            ),
            title: Text(todo.todo),
          ),
        );
      },
    );
  }
}
