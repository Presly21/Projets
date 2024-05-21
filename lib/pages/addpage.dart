import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/api/todoController.dart';

// ignore: must_be_immutable
class AddPage extends StatefulWidget {
   void handleTitleUpdate(String todoId, String newTitle) async {
    await todoController.updateTodo(todoId, newTitle);
    
    // Actualisation de la liste des tâches après la modification du titre
    await todoController.getTodos();
  }
   AddPage({super.key});
  @override
  State<AddPage> createState() => _AddPageState();
  TodoController todoController =Get.put(TodoController());
  
  
}

class _AddPageState extends State<AddPage> {
  TextEditingController text=TextEditingController();
  TodoController todoController= new TodoController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.deepPurple[500],
        title:  Center(child: Text('tas'.tr)),
      ),
      body:ListView(
        padding: const EdgeInsets.all(20),
        children:  [
           TextFormField(
            controller: text,
            decoration:  InputDecoration(
              hintText: 'enter'.tr,
            ),
          ),
           const SizedBox(height: 20,),
          //  TextFormField(
            
          //    decoration: const InputDecoration(
          //     hintText: 'Description',
          //   ),
          //   maxLines: 8,
          //   keyboardType: TextInputType.multiline,
          //   minLines: 5,
          // ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              
              todoController.postTodos(text.text);
              Get.back();
              text.clear();
            },
             child:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Sub'.tr),
            
          )),
        ],
      ),
    );
  }
}