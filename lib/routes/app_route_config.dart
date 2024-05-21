import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/Models/todoModel.dart';
import 'package:todo/pages/addpage.dart';
import 'package:todo/pages/editpage.dart';
import 'package:todo/pages/todo_page.dart';
import 'package:todo/routes/app_route_constant.dart';

class MyAppRoute{
  GoRouter router=GoRouter(routes: [
GoRoute(
  name: MYAPPCONSTANTS.editRouteName,
  path: '/EditPage',
  pageBuilder: (context, state) {
    return MaterialPage(child: EditPage(todo:TodoModel.fromJson(Map()) ));
  },
),
GoRoute(
  name: MYAPPCONSTANTS.addRouteName,
  path: '/Addpage',
  pageBuilder: (context, state) {
    return MaterialPage(child: AddPage());
  },
),
  ]);
}