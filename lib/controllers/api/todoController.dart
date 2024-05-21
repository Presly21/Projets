import 'dart:convert';

import 'package:dio/dio.dart' as dio; // Importing dio with prefix
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Models/todoModel.dart';

class TodoController extends GetxController {
  var todoList = RxList<TodoModel>();
  RxBool isLoading = false.obs;
  TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getTodos();
  }

  Future<RxList<TodoModel>> getTodos() async {
    isLoading.value = true;

    try {
      dio.Dio dioClient = dio.Dio();
      dio.Response response = await dioClient.get('https://66338c8cf7d50bbd9b49ca1f.mockapi.io/api/todolist');
      var data = response.data;

      if (response.statusCode == 200) {
        todoList.clear();
        for (Map<String, dynamic> index in data) {
          todoList.add(TodoModel.fromJson(index));
        }
        isLoading.value = false;
        return todoList;
      } else {
        return todoList;
      }
    } catch (error) {
      return todoList;
    }
  }

  // Post todo
  Future<void> postTodos(title) async {
    isLoading.value = true;

    try {
      dio.Dio dioClient = dio.Dio();
      dio.Response response = await dioClient.post(
        'https://66338c8cf7d50bbd9b49ca1f.mockapi.io/api/todolist',
        options: dio.Options(headers: {'Content-Type': 'application/json'}),
        data: json.encode({"todotitle": title}),
      );

      if (response.statusCode == 201) {
        getTodos();
        isLoading.value = false;
        Get.snackbar("Success", "Done", icon: Icon(Icons.alarm));
      } else {
        Get.snackbar("Error", "Failed", icon: Icon(Icons.alarm));
      }
    } catch (error) {
      Get.snackbar("Error", "Failed", icon: Icon(Icons.alarm));
    }
  }

  // Delete todo
  Future<void> deleteTodo(String todoId) async {
    isLoading.value = true;

    try {
      dio.Dio dioClient = dio.Dio();
      dio.Response response = await dioClient.delete(
        'https://66338c8cf7d50bbd9b49ca1f.mockapi.io/api/todolist/$todoId',
        options: dio.Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        getTodos();
        todoList.clear();
        isLoading.value = false;
        Get.snackbar("Success", "Todo deleted", icon: const Icon(Icons.alarm));
      } else {
        Get.snackbar("Error", "Failed to delete todo");
      }
    } catch (error) {
      Get.snackbar("Error", "Failed to delete todo");
    }
  }

  Future<void> updateTodo(String todoId, String updatedTitle) async {
    isLoading.value = true;

    try {
      dio.Dio dioClient = dio.Dio();
      dio.Response response = await dioClient.put(
        'https://66338c8cf7d50bbd9b49ca1f.mockapi.io/api/todolist/$todoId',
        options: dio.Options(headers: {'Content-Type': 'application/json'}),
        data: json.encode({"todotitle": updatedTitle}),
      );

      if (response.statusCode == 200) {
        getTodos();
        isLoading.value = false;
        Get.snackbar("Success", "Todo Updated", icon: const Icon(Icons.alarm));
      } else {
        Get.snackbar("Error", "Failed to update todo", icon: Icon(Icons.alarm));
      }
    } catch (error) {
      Get.snackbar("Error", "Failed to update todo", icon: Icon(Icons.alarm));
    }
  }
}