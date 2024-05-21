
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Models/todoModel.dart';
import 'package:todo/controllers/api/todoController.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
   EditPage({super.key, required this.todo, });
 final TodoModel todo;
  @override
  State<EditPage> createState() => _EditPageState();
   TodoController todoController =Get.put(TodoController());
}
class _EditPageState extends State<EditPage> {
  TextEditingController textEditingController=TextEditingController();
  TodoController todoController=new TodoController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = widget.todo.title;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.deepPurple[500],
        title:   Center(child: Text('EDit'.tr)),
      ),
      body:ListView(
        padding: const EdgeInsets.all(20),
        children:  [
           TextFormField(
            controller: textEditingController,
            decoration:  InputDecoration(
              hintText: 'EDit'.tr,
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
              // ignore: avoid_print
              final updatedTitle = textEditingController.text;
            todoController.updateTodo(widget.todo.id, updatedTitle);
            Navigator.pop(context);
              Get.back();
            },
             child:   Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('up'.tr),
          )),
        ],
      ),
    );
  }
}