// ignore_for_file: use_super_parameters, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nexmax_hrms/admin/screens%20copy/homescreen.dart';
import 'package:nexmax_hrms/views/auth_screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_colors.dart';
import '../../constants/gradeinet_background.dart';
import '../../constants/text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradientBackground(
        child: Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // final AuthController _authController = Get.find<AuthController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _phoneNumberController = TextEditingController();
  // final TextEditingController _otp1Controller = TextEditingController();
  // final TextEditingController _otp2Controller = TextEditingController();
  // final TextEditingController _otp3Controller = TextEditingController();
  // final TextEditingController _otp4Controller = TextEditingController();
  late SharedPreferences sharedPreferences;
  bool isLoading = false;
  bool _passwordVisible = false;
  bool _isAdminMode = false;
  bool _showPhoneNumberField = true;
  String phoneNumber = '';
  Color borderColor = Colors.black;
  bool _isProceedButtonVisible() {
    return !_isAdminMode; // Return true if not in admin mode
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isAdminMode = false;
                      _showPhoneNumberField = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _isAdminMode ? Colors.transparent : AppColors.primary,
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      'Glisser vers  Admin',
                      style: TextStyle(
                        color: _isAdminMode ? AppColors.primary : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isAdminMode = true;
                      _showPhoneNumberField = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _isAdminMode ? AppColors.primary : Colors.transparent,
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      'Glisser ver Employé',
                      style: TextStyle(
                        color: _isAdminMode ? Colors.white : AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Image.asset('assets/images/logo2.png', width: 55.w),
            const SizedBox(height: 20),
            if (!_isAdminMode)
              SizedBox(
                height: 40,
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(color: AppColors.secondary),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: AppColors.primary,
                    ),
                    hintText: 'Email ou nom utilisateur',
                    hintStyle: TextStyle(color: AppColors.primaryHintColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                ),
              ),
            if (!_isAdminMode) const SizedBox(height: 10),
            if (!_isAdminMode)
              SizedBox(
                height: 40,
                child: TextField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  style: const TextStyle(color: AppColors.secondary),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColors.primary,
                    ),
                    hintText: 'Mot de passe',
                    hintStyle: TextStyle(color: AppColors.primaryHintColor),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      child: Icon(
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                ),
              ),
            if (_isAdminMode && _showPhoneNumberField)
              const SizedBox(
                height: 150,
                child: PhoneAuth(),
              ),
            if (!_isAdminMode && _isProceedButtonVisible())
              const SizedBox(height: 20),
            if (_isProceedButtonVisible())
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });

                  String name = _nameController.text.trim();
                  String password = _passwordController.text.trim();

                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Le nom de L'admin est toujour vide!")),
                    );
                    setState(() {
                      isLoading = false;
                    });
                  } else if (password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Le mot de passe est toujour vide!")),
                    );
                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    try {
                      QuerySnapshot snap = await FirebaseFirestore.instance
                        .collection("Admin")
                        .where('name', isEqualTo: name)
                        .get();
                      
                      if (snap.docs.isNotEmpty && password == snap.docs[0]['password']) {
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('Admin', name).then((_) {
                          Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()));
                             ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Verification avec succes!")));
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Invalid credentials!")),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Error occurred during login!")),
                      );
                    }

                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.secondary,
                  ),
                  child: Center(
                    child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "LogIn",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                  ),
                ),
              ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Add any additional widgets here if needed
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              color: AppColors.secondary,
              thickness: 1,
            ),
            Text(
              'Please contact Admin if forget password',
              style: CustomTextStyles.bodyTextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}