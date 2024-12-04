import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
// ignore: duplicate_import
import 'package:month_year_picker/month_year_picker.dart';
import 'package:nexmax_hrms/models%20copy/user.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  // ignore: use_full_hex_values_for_flutter_colors
  Color primary = const Color(0xffeef444c);

  String _month = DateFormat('MMMM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee history",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       alignment: Alignment.centerLeft,
              //       child: Text(
              //         "Employee History",
              //         style: TextStyle(
              //           fontSize: screenWidth / 18,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       width: 30,
              //       height: 30,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(50),
              //         color: primary,
              //       ),
              //       child: Users.profilePicLink.isNotEmpty // Vérifiez si l'URL de l'image n'est pas vide
              //           ? ClipRRect(
              //               borderRadius: BorderRadius.circular(50),
              //               child: Image.network(
              //                 Users.profilePicLink,
              //                 fit: BoxFit.cover,
              //               ),
              //             )
              //           : const Icon(
              //               Icons.person,
              //               size: 20,
              //               color: Colors.black,
              //             ),
              //     ),
              //   ],
              // ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 32),
                    child: Text(
                      _month,
                      style: TextStyle(
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(top: 32),
                    child: GestureDetector(
                      onTap: () async {
                        final month = await showMonthYearPicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2099),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: primary,
                                  secondary: primary,
                                  onSecondary: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: primary,
                                  ),
                                ),
                                textTheme: const TextTheme(
                                  headlineMedium: TextStyle(),
                                  labelSmall: TextStyle(),
                                  labelLarge: TextStyle(),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (month != null) {
                          setState(() {
                            _month = DateFormat('MMMM').format(month);
                          });
                        }
                      },
                      child: Text(
                        "Pick a Month",
                        style: TextStyle(
                          fontSize: screenWidth / 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: screenHeight / 1.45,
                child: Users.id.isNotEmpty // Vérifiez si Users.id n'est pas vide
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Employee")
                            .doc(Users.id)
                            .collection("Record")
                            .snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final snap = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: snap.length,
                              itemBuilder: (context, index) {
                                return DateFormat('MMMM').format(snap[index]['date'].toDate()) == _month
                                    ? Container(
                                        margin: EdgeInsets.only(top: index > 0 ? 12 : 0, left: 6, right: 6),
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
                                              child: Container(
                                                margin: const EdgeInsets.only(),
                                                decoration: BoxDecoration(
                                                  color: primary,
                                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    DateFormat('EE\ndd').format(snap[index]['date'].toDate()),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: screenWidth / 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                                    snap[index]['checkIn'],
                                                    style: TextStyle(
                                                      fontFamily: "NexaBold",
                                                      fontSize: screenWidth / 18,
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: SingleChildScrollView(
                                                      // ignore: avoid_unnecessary_containers
                                                      child: Container(
                                                        child: Text(
                                                          snap[index]['checkInLocation'],
                                                          style: const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
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
                                                      fontFamily: "NexaRegular",
                                                      fontSize: screenWidth / 20,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Text(
                                                    snap[index]['checkOut'],
                                                    style: TextStyle(
                                                      fontFamily: "NexaBold",
                                                      fontSize: screenWidth / 18,
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: SingleChildScrollView(
                                                      // ignore: avoid_unnecessary_containers
                                                      child: Container(
                                                        child: Text(
                                                          snap[index]['checkOutLocation'],
                                                          style: const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            );
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      )
                    : const Center(
                        child: Text(
                          'No user ID available',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
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
