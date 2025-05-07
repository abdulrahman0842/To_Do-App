import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:to_do_app/models/to_do_model.dart';

class ApiService {


  
  Future<List<ToDoModel>?> getToDo() async {
    var apiEndPoint = "https://jsonplaceholder.typicode.com/todos";

    try {
      var response = await http.get(Uri.parse(apiEndPoint));
      if (response.statusCode == 200) {
        log(response.toString());
        List<dynamic> json = jsonDecode(response.body);
        List<ToDoModel> todos =
            json.map((ele) => ToDoModel.fromJson(ele)).toList();
        return todos;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> addToDo(String title) async {
    var url = "https://jsonplaceholder.typicode.com/todos/post";
    try {
      var response = await http.post(Uri.parse(url), body: {"title": title});
      log(response.toString());
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Error Adding Data");
      return false;
    }
  }
}
