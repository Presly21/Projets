import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   double screensHeight = 0;
  double screensWidth = 0;
  Color primary = const Color(0xFFee444c);
  List<IconData>navigationIcons=[
    FontAwesomeIcons.calendarAlt,
    FontAwesomeIcons.check,
    FontAwesomeIcons.userAlt,
    
  ];
  @override
  Widget build(BuildContext context) {
     final bool isKeyBoardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    screensHeight = MediaQuery.of(context).size.height;
    screensWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: const SafeArea(child: Center(
        child: Text("home"),
      ),
      ),bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          right: 12,
          left: 12,
          bottom: 24,
        ),
         height: 70,
         decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(2, 2)
            )
          ]
         ),
         child:  ClipRRect(
           borderRadius: const BorderRadius.all(Radius.circular(40)),
           child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             for(int i=0;i<navigationIcons.length;i++)...<Expanded>{
               Expanded(child: Center(
                child: Icon(navigationIcons[i]),
              )),
             }
            ],
           ),
         ),
      ),
    );
  }
}