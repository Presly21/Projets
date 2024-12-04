
// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../models copy/user.dart';
class TodayScreenEmp extends StatefulWidget {
  // ignore: use_super_parameters
  const TodayScreenEmp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TodayScreenEmpState createState() => _TodayScreenEmpState();
}

class _TodayScreenEmpState extends State<TodayScreenEmp> {
  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn = "--/--";
  String checkOut = "--/--";
  String location = " ";
  String scanResult = " ";
  String officeCode = " ";

  // ignore: use_full_hex_values_for_flutter_colors
  Color primary = const Color(0xffeef444c);

  @override
  void initState() {
    super.initState();
     _getRecord();
    // _getOfficeCode();
    // _getRecord();
    // _getLocation();
  }
   void _getLocation() async {
    List<Placemark> placemark = await placemarkFromCoordinates(Users.lat, Users.long);

    setState(() {
      location = "${placemark[0].street}, ${placemark[0].administrativeArea}, ${placemark[0].postalCode}, ${placemark[0].country}";
    });
  }
  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Employee")
          .where('id', isEqualTo: Users.employeeId)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      setState(() {
        checkIn = snap2['checkIn'];
        checkOut = snap2['checkOut'];
      });
    } catch(e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
      });
    }
  }
  // void _getOfficeCode() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance.collection("Attributes").doc("Office1").get();
  //   setState(() {
  //     officeCode = snap['code'];
  //   });
  // }
 Future<void> scanQRandCheck() async {
    String result = " ";


    setState(() {
      scanResult = result;
    });

    if(scanResult == officeCode) {
      if(Users.lat != 0) {
        _getLocation();

        QuerySnapshot snap = await FirebaseFirestore.instance
            .collection("Employee")
            .where('id', isEqualTo: Users.employeeId)
            .get();

        DocumentSnapshot snap2 = await FirebaseFirestore.instance
            .collection("Employee")
            .doc(snap.docs[0].id)
            .collection("Record")
            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
            .get();

        try {
          String checkIn = snap2['checkIn'];

          setState(() {
            checkOut = DateFormat('hh:mm').format(DateTime.now());
          });

          await FirebaseFirestore.instance
              .collection("Employee")
              .doc(snap.docs[0].id)
              .collection("Record")
              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
              .update({
            'date': Timestamp.now(),
            'checkIn': checkIn,
            'checkOut': DateFormat('hh:mm').format(DateTime.now()),
            'checkInLocation': location,
          });
        } catch (e) {
          setState(() {
            checkIn = DateFormat('hh:mm').format(DateTime.now());
          });

          await FirebaseFirestore.instance
              .collection("Employee")
              .doc(snap.docs[0].id)
              .collection("Record")
              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
              .set({
            'date': Timestamp.now(),
            'checkIn': DateFormat('hh:mm').format(DateTime.now()),
            'checkOut': "--/--",
            'checkOutLocation': location,
          });
        }
      } else {
        Timer(const Duration(seconds: 3), () async {
          _getLocation();

          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection("Employee")
              .where('id', isEqualTo: Users.employeeId)
              .get();

          DocumentSnapshot snap2 = await FirebaseFirestore.instance
              .collection("Employee")
              .doc(snap.docs[0].id)
              .collection("Record")
              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
              .get();

          try {
            String checkIn = snap2['checkIn'];

            setState(() {
              checkOut = DateFormat('hh:mm').format(DateTime.now());
            });

            await FirebaseFirestore.instance
                .collection("Employee")
                .doc(snap.docs[0].id)
                .collection("Record")
                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                .update({
              'date': Timestamp.now(),
              'checkIn': checkIn,
              'checkOut': DateFormat('hh:mm').format(DateTime.now()),
              'checkInLocation': location,
            });
          } catch (e) {
            setState(() {
              checkIn = DateFormat('hh:mm').format(DateTime.now());
            });

            await FirebaseFirestore.instance
                .collection("Employee")
                .doc(snap.docs[0].id)
                .collection("Record")
                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                .set({
              'date': Timestamp.now(),
              'checkIn': DateFormat('hh:mm').format(DateTime.now()),
              'checkOut': "--/--",
              'checkOutLocation': location,
            });
          }
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
              Row(
                children: [
                 Stack(
                  children: [
                     Container(
                    alignment: Alignment.bottomLeft,
                    child: const Icon(
                              Icons.notifications,
                              size: 40,
                              
                            ),
                  ),
                   Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 11,
                              width: 11,
                              margin: const EdgeInsets.only(
                                  left: 25, right: 2, top: 7),
                              child: Column(
                                children: [
                                  Container(
                                    //  padding: EdgeInsets.only(top: 3,left: 110),

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
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (String result) {},
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'View',
                        child: Text('Add Employee'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'List',
                        child: Text('Add Department'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Update',
                        child: Text('Update'),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem<String>(
                        value: 'Delete',
                        child: PopupMenuButton<String>(
                          child: const ListTile(
                            title: Text('Delete'),
                            trailing: Icon(Icons.arrow_right),
                          ),
                          onSelected: (String subResult) {},
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Delete Employee',
                              child: Text('Employee'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Delete Department',
                              child: Text('Department'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
               Container(
                    margin: const EdgeInsets.only(top: 13),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                // ignore: prefer_interpolation_to_compose_strings
                "Employee ${Users.employeeId}  👋",
                style: TextStyle(
                  fontSize: screenWidth / 18,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                "Today's Status",
                style: TextStyle(
                  fontSize: screenWidth / 18,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Check In",
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          checkIn,
                          style: TextStyle(
                            fontSize: screenWidth / 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Check Out",
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          checkOut,
                          style: TextStyle(
                            fontSize: screenWidth / 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: DateTime.now().day.toString(),
                  style: TextStyle(
                    color: primary,
                    fontSize: screenWidth / 18,
                  ),
                  children: [
                    TextSpan(
                      text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth / 20,
                      ),
                    ),
                  ],
                ),
              )
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('hh:mm:ss a').format(DateTime.now()),
                    style: TextStyle(
                      fontSize: screenWidth / 20,
                      color: Colors.black54,
                    ),
                  ),
                );
              },
            ),
            checkOut == "--/--" ? Container(
              margin: const EdgeInsets.only(top: 24, bottom: 12),
              child: Builder(
                builder: (context) {
                  final GlobalKey<SlideActionState> key = GlobalKey();

                  return SlideAction(
                    text: checkIn == "--/--" ? "Slide to Check In" : "Slide to Check Out",
                    textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: screenWidth / 20,
                    ),
                    outerColor: Colors.white,
                    innerColor: primary,
                    key: key,
                    onSubmit: () async {

                      if(Users.lat !=0){
                        _getLocation();
                          QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("Employee")
                            .where('id', isEqualTo: Users.employeeId)
                            .get();

                        DocumentSnapshot snap2 = await FirebaseFirestore.instance
                            .collection("Employee")
                            .doc(snap.docs[0].id)
                            .collection("Record")
                            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                            .get();

                        try {
                          String checkIn = snap2['checkIn'];

                          setState(() {
                            checkOut = DateFormat('hh:mm').format(DateTime.now());
                          });

                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .update({
                            'date': Timestamp.now(),
                            'checkIn': checkIn,
                            'checkOut': DateFormat('hh:mm').format(DateTime.now()),
                            'checkInLocation':location,
                          });
                        } catch (e) {
                          setState(() {
                            checkIn = DateFormat('hh:mm').format(DateTime.now());
                          });
                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .set({
                            'date': Timestamp.now(),
                            'checkIn': DateFormat('hh:mm').format(DateTime.now()),
                            'checkOut':"--/--",
                            'checkOutLocation':location,
                          });
                        }

                        key.currentState!.reset();
                      }else{
                        Timer(const Duration(seconds: 3), () async {
                          _getLocation();

                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection("Employee")
                              .where('id', isEqualTo: Users.employeeId)
                              .get();

                          DocumentSnapshot snap2 = await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .get();

                          try {
                            String checkIn = snap2['checkIn'];

                            setState(() {
                              checkOut = DateFormat('hh:mm').format(DateTime.now());
                            });

                            await FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                .update({
                              'checkIn': checkIn,
                              'checkOut': DateFormat('hh:mm').format(DateTime.now()),
                              'checkInLocation':location,
                            });
                          } catch (e) {
                            setState(() {
                              checkIn = DateFormat('hh:mm').format(DateTime.now());
                            });

                            await FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                .set({
                              'checkIn': DateFormat('hh:mm').format(DateTime.now()),
                              'checkOut':"--/--",
                              'checkOutLocation':location,
                            });
                          }

                          key.currentState!.reset();
                        });
                      }
                      
                    },
                  );
                },
              ),
            ) : Container(
              margin: const EdgeInsets.only(top: 32, bottom: 32),
              child: Text(
                "You have completed this day!",
                style: TextStyle(
                  fontSize: screenWidth / 20,
                  color: Colors.black54,
                ),
              ),
            ),
            location != " " ? Text(
              // ignore: prefer_interpolation_to_compose_strings
              "Location: " + location,
            ) : const SizedBox(),
              GestureDetector(
              onTap: () {
                scanQRandCheck();
              },
              child: Container(
                height: screenWidth / 2,
                width: screenWidth / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.expand,
                          size: 70,
                          color: primary,
                        ),
                        Icon(
                          FontAwesomeIcons.camera,
                          size: 25,
                          color: primary,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8,),
                      child: Text(
                        checkIn == "--/--" ? "Scan to Check In" : "Scan to Check Out",
                        style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: screenWidth / 20,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
