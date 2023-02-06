import 'dart:convert';

import 'package:flutter_learn/connection/myResponse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_learn/model/todo.dart';

class TodoLoader {
  final String urlString =
      "https://crudcrud.com/api/c3f516ca4d2f4a45b4b802581ed8420f/todos";
  late Uri urlBase = Uri.parse(urlString);
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "*/*"
  };

  Future<MyResponse<Todo>> postData(String data) async {
    var response = await _postData(data);
    var success = false;
    var body;
    if (response.statusCode == 201) {
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      body = Todo.fromJson(decodedResponse);
      success = true;
    }
    var mResponse = MyResponse<Todo>(body, success, response.statusCode);
    return mResponse;
  }

  Future<MyResponse<List<Todo>>> getData() async {
    var response = await _getData();
    var success = false;
    var body;
    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      body = List<Todo>.from(decodedResponse.map((e) => Todo.fromJson(e)));
      success = true;
    }
    var mResponse = MyResponse<List<Todo>>(body, success, response.statusCode);
    return mResponse;
  }

  Future<MyResponse<Todo>> getSpesific(String id) async {
    var response = await _getSpesific(id);
    var success = false;
    var body;
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      body = Todo.fromJson(decodedResponse);
      success = true;
    }
    var mResponse = MyResponse<Todo>(body, success, response.statusCode);
    return mResponse;
  }

  Future<MyResponse<Todo>> updateData(Todo data) async {
    var response = await _updateData(data);
    print(response.statusCode);
    var success = false;
    var body;
    if (response.statusCode == 200) {
      success = true;
    }
    var mResponse = MyResponse<Todo>(body, success, response.statusCode);
    return mResponse;
  }

  Future<MyResponse<Todo>> deleteData(String id) async {
    var response = await _deleteData(id);
    var success = false;
    var body;
    if (response.statusCode == 200) {
      success = true;
    }
    var mResponse = MyResponse<Todo>(body, success, response.statusCode);
    return mResponse;
  }

  Future<http.Response> _postData(String data) async {
    var response = await http.post(
      urlBase,
      body: jsonEncode(Todo(null, data, false).toMap()),
      headers: headers,
    );
    return response;
  }

  Future<http.Response> _getData() async {
    var response = await http.get(urlBase);
    return response;
  }

  Future<http.Response> _getSpesific(String id) async {
    var uri = Uri.parse(urlString + id);
    var response = await http.get(uri);
    return response;
  }

  Future<http.Response> _updateData(Todo todo) async {
    var dataMap = todo.toMap();
    var uri = Uri.parse(urlString + "/" + todo.id());
    var response = await http.put(
      uri,
      body: jsonEncode(dataMap),
      headers: headers,
    );

    return response;
  }

  Future<http.Response> _deleteData(String id) async {
    var uri = Uri.parse(urlString + "/" + id);
    var response = await http.delete(
      uri,
      headers: headers,
    );
    return response;
  }
}
