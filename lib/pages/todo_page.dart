import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Models/todoModel.dart';
import 'package:todo/controllers/api/todoController.dart';
import 'package:todo/main.dart';
import 'package:todo/pages/addpage.dart';
import 'package:todo/pages/editpage.dart';
import 'package:dio/dio.dart' as dio;

class TodoPage extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
MyApp myApp =MyApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('T o d o'.tr),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Get.to(AddPage());
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.deepPurple[500],
              ),
              width: 80,
              height: 80,
              child: const Center(
                child: Icon(Icons.add, size: 50, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      MyApp().builddialog(context);
                    },
                    child: Text(
                      "change".tr,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      todoController.getTodos();
                    },
                    child: Text(
                      "Re".tr,
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Obx(() {
                  if (todoController.isLoading.value) {
                    return Center(child: Text('lo'.tr));
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final todo = todoController.todoList[index];
                        return Card(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.add_circle,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 10,),
                                    Text(
                                      todo.title.toString().tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => EditPage(todo: todo),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        String todoId = todo.id;
                                        todoController.deleteTodo(todoId);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: todoController.todoList.length,
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditTodoDialog extends StatefulWidget {
  final TodoModel todo;

  const EditTodoDialog({required this.todo});

  @override
  _EditTodoDialogState createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  TodoController todoController = TodoController();
  dio.Dio dioClient = dio.Dio();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.todo.title;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: TextField(
        controller: _textEditingController,
        decoration: const InputDecoration(
          labelText: 'Title',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final updatedTitle = _textEditingController.text;
            try {
              dio.Response response = await dioClient.put(
                'https://www.todo.id/api/todos/${widget.todo.id}',
                data: {"title":updatedTitle},
              );
              if (response.statusCode == 200) {
                todoController.getTodos();
                Navigator.pop(context);
              } else {
                // handle error
              }
            } catch (error) {
              // handle error
            }
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}