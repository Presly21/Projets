import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexmax_hrms/employeeattendance/calender.dart';
import 'package:nexmax_hrms/employeeattendance/todayscreen.dart';
import '../models copy/user.dart';
import 'services/location.dart';

class HomeScreenEmpl extends StatefulWidget {
  const HomeScreenEmpl({super.key});

  @override
  State<HomeScreenEmpl> createState() => _HomeScreenEmplState();
}

class _HomeScreenEmplState extends State<HomeScreenEmpl> {
  late double screensHeight;
  late double screensWidth;
  Color primary = const Color(0xFFee444c);
  int currentIndex = 1;
  List<IconData> navigationIcons = [
    // ignore: deprecated_member_use
    FontAwesomeIcons.calendarAlt,
    FontAwesomeIcons.check,
  ];
@override
  void initState() {
    super.initState();
   _startLocationService();
  }
 Future< void> getId()async{
     QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where('id', isEqualTo: Users.employeeId)
        .get();

    setState(() {
      Users.id = snap.docs[0].id;
    });
  }
  void _startLocationService() async {
    LocationService().initialize();

    LocationService().getLongitude().then((value) {
      setState(() {
        Users.long = value!;
      });

      LocationService().getLatitude().then((value) {
        setState(() {
          Users.lat = value!;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    screensHeight = MediaQuery.of(context).size.height;
    screensWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children:  const [
            // ignore: prefer_const_constructors
             Employeehistory(),
            TodayScreenEmp(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          right: screensWidth * 0.03,
          left: screensWidth * 0.03,
          bottom: screensHeight * 0.02,
        ),
        height: screensHeight * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(screensHeight * 0.05)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(screensHeight * 0.05)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: Container(
                      height: screensHeight,
                      width: screensWidth,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              navigationIcons[i],
                              color: i == currentIndex ? primary : Colors.black54,
                              size: i == currentIndex ? screensWidth * 0.08 : screensWidth * 0.07,
                            ),
                            if (i == currentIndex)
                              Container(
                                margin: EdgeInsets.only(top: screensHeight * 0.01),
                                height: screensHeight * 0.005,
                                width: screensWidth * 0.05,
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.all(Radius.circular(screensHeight * 0.02)),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
