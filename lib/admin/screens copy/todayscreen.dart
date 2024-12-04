// ignore_for_file: use_super_parameters

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nexmax_hrms/admin/models/admin.dart';
import 'package:nexmax_hrms/admin/screens%20copy/announcementhistory.dart';
import 'package:nexmax_hrms/admin/screens%20copy/calender.dart';
import 'package:nexmax_hrms/admin/screens%20copy/departmenthistory.dart';
import 'package:nexmax_hrms/admin/screens%20copy/employeehistory.dart';
import 'package:nexmax_hrms/controllers/auth_controller.dart';
import 'package:nexmax_hrms/views/auth_screens/login_screen.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  // ignore: use_full_hex_values_for_flutter_colors
  Color primary = const Color(0xffeef444c);

  @override
  void initState() {
    super.initState();
    _getRecord();
  }
 void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Admin")
          .where('name', isEqualTo: Admin.adminId)
          .get();

      // ignore: unused_local_variable
      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("Admin")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();
    setState(() {
    
      });
    } catch(e) {
      setState(() {
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true, // Center aligns the title
        title:
            const Text("ADUIAH", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Stack(
            children: [
              // Replace the notification icon with an image
              Container(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/Vector.png',
                  width: 30,
                  height: 30,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 11,
                  width: 11,
                  margin: const EdgeInsets.only(
                    left: 19,
                    right: 25, // Adjust the right margin here
                    top: 17,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 11,
                        width: 11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                        'assets/images/mypictur.jpg',
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 2)),
                  const Text(
                    "presly ebonke",
                    style: TextStyle(fontSize: 15),
                  ),
                  const Text(
                    "preslyebonke21@gmail.com",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_mark),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            GestureDetector(
               onTap: () {
                            Get.find<AuthController>().signOut();
                            Get.off(const LoginScreen());
                          },
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: GestureDetector(
                   onTap: () {
                            Get.find<AuthController>().signOut();
                            Get.off(const LoginScreen());
                          },
                  child: const Text('Logout')),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 13),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18, // Use a fixed font size here if needed
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Admin ${Admin.adminId}  👋",
                  style: TextStyle(
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildCard(
                    context,
                    "Announcement",
                    FontAwesomeIcons.bullhorn,
                    Colors.orange,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnnouncementHistoryPage()));
                    },
                  ),
                  _buildCard(
                    context,
                    "Attendance",
                    FontAwesomeIcons.calendarCheck,
                    Colors.blue,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CalenderScreen()));
                    },
                  ),
                  _buildCard(
                    context,
                    "Leaves",
                    FontAwesomeIcons.planeDeparture,
                    Colors.green,
                    () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => LeavesPage()));
                    },
                  ),
                  _buildCard(
                    context,
                    "Notebook",
                    FontAwesomeIcons.book,
                    Colors.red,
                    () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => NotebookPage()));
                    },
                  ),
                  _buildCard(
                    context,
                    "Pay Slip",
                    FontAwesomeIcons.fileInvoiceDollar,
                    Colors.purple,
                    () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => PaySlipPage()));
                    },
                  ),
                  _buildCard(
                    context,
                    "Salary",
                    // ignore: deprecated_member_use
                    FontAwesomeIcons.moneyCheckAlt,
                    Colors.teal,
                    () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SalaryPage()));
                    },
                  ),
                  _buildCard(
                    context,
                    "Employee",
                    FontAwesomeIcons.user,
                    Colors.brown,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmployeeListPage()));
                    },
                  ),
                  _buildCard(
                    context,
                    "Department",
                    FontAwesomeIcons.accusoft,
                    Colors.brown,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DepartmentListPage()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildCard(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth / 2 - 30,
        height: screenWidth / 2 - 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth / 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: TodayScreen(),
  ));
}
