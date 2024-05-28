import 'package:attend/screens/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  double screensHeight = 0;
  double screensWidth = 0;
  Color primary = const Color(0xFFee444c);
  bool isLoading = false;
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final bool isKeyBoardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    screensHeight = MediaQuery.of(context).size.height;
    screensWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              isKeyBoardVisible
                  ? SizedBox(height: screensHeight / 50)
                  : Container(
                      height: screensHeight / 3,
                      width: screensWidth,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(80),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: screensWidth / 3.5,
                        ),
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(
                  top: screensHeight / 15,
                  bottom: screensHeight / 20,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screensWidth / 18,
                    fontFamily: "NexaBold",
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: screensWidth / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fieldTitle("Employee ID"),
                    customField("Enter your employee id", idController, false),
                    fieldTitle("Password"),
                    customField("Enter your employee Password", passController, true),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });

                        FocusScope.of(context).unfocus();
                        String id = idController.text.trim();
                        String password = passController.text.trim();

                        if (id.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Employee id is still empty!")));
                          setState(() {
                            isLoading = false;
                          });
                        } else if (password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Password is still empty!")));
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          try {
                            QuerySnapshot snap = await FirebaseFirestore.instance
                                .collection("Employee")
                                .where('id', isEqualTo: id)
                                .get();
                            if (password == snap.docs[0]['password']) {
                              sharedPreferences =await SharedPreferences.getInstance();
                              sharedPreferences.setString('employeeId', id).then((_){
                                    Navigator.pushReplacement(context,
                                     MaterialPageRoute(builder: (context) 
                                     => HomeScreen()));
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Password is not correct!")));
                            }
                          } catch (e) {
                            String error = "";
                            if (e.toString() ==
                                "RangeError (index): Invalid value: Valid value range is empty: 0") {
                              setState(() {
                                error = "Employee id does not exist!";
                              });
                            } else {
                              setState(() {
                                error = "Error Occurred!";
                              });
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
                          }

                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: screensWidth / 40),
                        height: 60,
                        width: screensWidth,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Center(
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screensWidth / 18,
                                    fontFamily: AutofillHints.birthdayMonth,
                                    color: Colors.white,
                                    letterSpacing: 2,
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
        ),
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screensWidth / 23,
          fontFamily: AutofillHints.countryName,
        ),
      ),
    );
  }

  Widget customField(String hint, TextEditingController controller, bool obscure) {
    return Container(
      width: screensWidth * 0.8,
      margin: EdgeInsets.only(bottom: screensWidth / 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: screensWidth / 5,
            child: Icon(
              Icons.person,
              color: primary,
              size: screensWidth / 15,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screensWidth / 12),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screensHeight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hint,
                ),
                maxLines: 1,
                obscureText: obscure,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
