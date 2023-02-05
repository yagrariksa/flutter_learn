import 'dart:convert';

import 'package:flutter_learn/connection/myResponse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_learn/model/todo.dart';

class TodoLoader {
  final String urlString =
      "https://crudcrud.com/api/00a874fc2ffe478489a07dab3fb380fa/todos";
  late Uri urlBase = Uri.parse(urlString);

  Future<MyResponse<Todo>> postData(Todo data) async {
    var response = await _postData(data);
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

  Future<MyResponse<List<Todo>>> getData() async {
    var response = await _getData();
    var success = false;
    var body;
    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<Map>;
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

  Future<http.Response> _postData(Todo data) async {
    var response = await http.post(
      urlBase,
      body: data.toMap(),
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

  Future<http.Response> _updateData(Todo data) async {
    var dataMap = data.toMap();
    var uri = Uri.parse(urlString + dataMap['id']);
    var response = await http.put(
      uri,
      body: dataMap,
    );

    return response;
  }

  Future<http.Response> _deleteData(String id) async {
    var uri = Uri.parse(urlString + id);
    var response = await http.delete(uri);
    return response;
  }
}
