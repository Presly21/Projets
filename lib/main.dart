import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Localization/localeString.dart';
import 'package:todo/Models/todoModel.dart';
import 'package:todo/pages/addpage.dart';
import 'package:todo/pages/editpage.dart';
import 'package:todo/pages/todo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List locale=[
          { 'name':'ENGLISH','locale':Locale('en','EN')},
          { 'name':'FRENCH','locale':Locale('fr','FR')},
  ];
  updatelanguage(Locale locale){
               Get.back();
               Get.updateLocale(locale);
  }
  builddialog(BuildContext context){
    showDialog(context: context,
     builder: (builder){
      return AlertDialog(
          title: Text('Choose'.tr),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    updatelanguage(locale[index]['locale']);
                  },
                  child: Text(locale[index]['name'])),
              );
            },
             separatorBuilder: (context,index){
              return Divider(
                         color: Colors.deepPurple,
              );
             }, 
            itemCount: locale.length),
          ),
      );
     }
     );
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      locale: Locale('en','fr'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardTheme(
          color: Colors.white
        ),
         textTheme:  const TextTheme(
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
         elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
          ),
        ),
      ),
      
      home: TodoPage(),
      getPages: [
        GetPage(
          name: '/addpage', 
          page: () => AddPage()),
        GetPage(
          name: '/editpage',
          page: () => EditPage(todo: TodoModel.fromJson(Map())),
        ),
      ],
    );
  }
}