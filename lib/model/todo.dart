class Todo {
  String? _id;
  String todo;
  bool done;

  String id() {
    return _id ?? "a";
  }

  Todo(this._id, this.todo, this.done);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (_id != null) map['id'] = _id;
    map['todo'] = todo;
    map['done'] = done ? "true" : "false";

    return map;
  }

  factory Todo.fromJson(Map<dynamic, dynamic> json) {
    return Todo(json['_id'], json['todo'], (json['done'] == "true"));
  }
}
