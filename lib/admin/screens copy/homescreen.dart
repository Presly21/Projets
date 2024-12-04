// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexmax_hrms/admin/screens%20copy/employeehistory.dart';
import 'package:nexmax_hrms/admin/screens%20copy/setting.dart';
import 'package:nexmax_hrms/admin/screens%20copy/todayscreen.dart';
import 'package:nexmax_hrms/admin/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double screensHeight;
  late double screensWidth;
  Color primary = const Color(0xFFee444c);
  int currentIndex = 1;
  List<IconData> navigationIcons = [
    FontAwesomeIcons.users,
    FontAwesomeIcons.check,
    FontAwesomeIcons.user,
    FontAwesomeIcons.cog,
  ];

  @override
  void initState() {
    super.initState();
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
          children: [
            // ignore: prefer_const_constructors
            EmployeeListPage(),
            const TodayScreen(),
            const ProfileScreen(),
            const Settingpage(),
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
                              color:
                                  i == currentIndex ? primary : Colors.black54,
                              size: i == currentIndex
                                  ? screensWidth * 0.08
                                  : screensWidth * 0.07,
                            ),
                            if (i == currentIndex)
                              Container(
                                margin:
                                    EdgeInsets.only(top: screensHeight * 0.01),
                                height: screensHeight * 0.005,
                                width: screensWidth * 0.05,
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(screensHeight * 0.02)),
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
