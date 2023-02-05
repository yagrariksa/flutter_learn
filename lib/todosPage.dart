import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learn/connection/myResponse.dart';
import 'package:flutter_learn/connection/todoLoader.dart';
import 'package:flutter_learn/model/todo.dart';

final mockTodos = Iterable.generate(
  10,
  (index) => Todo("${Random().nextInt(1000)}", "Todo #${index + 1}", false),
);

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  List<Todo> _todos = [];
  TodoLoader loader = TodoLoader();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _todos = mockTodos.toList();
  }

  Future<List<Todo>?> loadData() async {
    MyResponse<List<Todo>> response = await loader.getData();
    return response.body;
  }

  void toggleTodo(int index) {
    setState(() {
      _todos.elementAt(index).done = !_todos.elementAt(index).done;
    });
  }

  void addTodo(String task) async {
    MyResponse response = await loader.postData(task);
    print(response.responseCode);
    setState(() {});
  }

  void updateTodo(String task, int index) async {
    setState(() {
      _todos.elementAt(index).todo = task;
    });
  }

  void deleteTodo(int index) async {
    setState(() {
      _todos.removeAt(index);
    });
  }

  _showDialog(Todo? todo, int? index) {
    var todoFieldController = TextEditingController();
    if (todo != null) {
      todoFieldController.text = todo.todo;
    }
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return modalDialog(todoFieldController, todo, index);
      },
    );
  }

  AlertDialog modalDialog(
      TextEditingController controller, Todo? todo, int? index) {
    return AlertDialog(
      title: const Text('Create Todo Item'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(hintText: "Task"),
            )
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                (todo == null || index == null) ? Colors.red[100] : Colors.red,
            disabledBackgroundColor: Colors.red[100],
          ),
          onPressed: () {
            if (todo != null && index != null) {
              deleteTodo(index);
              Navigator.pop(context);
            }
          },
          child: const Text("Delete"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: () {
            if (todo != null && index != null) {
              updateTodo(controller.text, index);
            } else {
              addTodo(controller.text);
            }
            Navigator.pop(context);
          },
          child: const Text("Ok"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showDialog(null, null);
        },
      ),
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _todos = snapshot.data!;
            return SafeArea(
              child: TodosList(_todos, toggleTodo, _showDialog),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}

class TodosList extends StatelessWidget {
  final List<Todo> list;
  final toggleTodo;
  final _showDialog;
  const TodosList(this.list, this.toggleTodo, this._showDialog);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      physics: const ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var todo = list.elementAt(index);
        return InkWell(
          onTap: () {
            _showDialog(todo, index);
          },
          child: Card(
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
          ),
        );
      },
    );
  }
}
