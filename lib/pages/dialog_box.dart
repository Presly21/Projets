import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
void MyDialogBox(){
  Get.defaultDialog(
title: "Enter your name plz",
content: const Column(
  children: [
    Row(
      children: [
        Expanded(child: TextField(),)
      ],
    )
  ],
),
titlePadding: const EdgeInsets.all(10),
contentPadding: const EdgeInsets.all(10),
radius: 10,
actions: [
  OutlinedButton(onPressed: (){
    Get.back();
  }, child: const Text('Cancel'),
  ),
  ElevatedButton(onPressed: (){
    print('Done');
    Get.back();
  }, child: const Text('Done'))
],
backgroundColor: Colors.white
  );
}