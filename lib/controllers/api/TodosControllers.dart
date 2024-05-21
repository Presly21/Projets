import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo/Models/todoModel.dart';
import 'package:http/http.dart' as http;
class Todoscontrollers extends GetxController {

  var todolist =RxList<TodoModel>();
// get todo 
  Future<RxList<TodoModel>> getTodos()async{
  final Response =await http.get(Uri.parse("https://66338c8cf7d50bbd9b49ca1f.mockapi.io/api/todolist"));
  var data=jsonDecode(Response.body.toString());
  if(Response.statusCode==200){
      
      for(Map<String,dynamic> index in data){
        todolist.add(TodoModel.fromJson(index));
      }
      return todolist;
  }else{
      return todolist;
  }
}

}