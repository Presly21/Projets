// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nexmax_hrms/constants/app_colors.dart';
import 'package:nexmax_hrms/views/auth_screens/function.dart';
import 'package:nexmax_hrms/views/auth_screens/verification_otp.dart';

class PhoneAuth extends StatefulWidget {
  // ignore: use_super_parameters
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}
class _PhoneAuthState extends State<PhoneAuth> {
  bool loading = false;
  String phoneNumber = '';

  void sendOtpCode() {
    setState(() {
      loading = true;
    });

    // ignore: no_leading_underscores_for_local_identifiers
    final _auth = FirebaseAuth.instance;
    if (phoneNumber.isNotEmpty) {
      authWithPhoneNumber(
        phoneNumber,
        onCodeSend: (verificationId, v) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => VerificationOtp(
              verificationId: verificationId,
              phoneNumber: phoneNumber,
            ),
          ));
        },
        onAutoVerify: (v) async {
          await _auth.signInWithCredential(v);
          Navigator.of(context).pop();
        },
        onFailed: (e) {
          setState(() {
            loading = false;
          });
          // Ajoute un message d'erreur plus détaillé ici
          ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(content: Text("Le code est erroné: ")));
        },
        autoRetrieval: (v) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [
            IntlPhoneField(
              initialCountryCode: "CM",
              onChanged: (value) {
                phoneNumber = value.completeNumber;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Numero de Telephone',
              ),
            ),
          
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                fixedSize: const Size(180, 55),
                padding: const EdgeInsets.symmetric(vertical: 2),
              ),
              onPressed: loading ? null : sendOtpCode,
              child: loading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : const Text(
                      'LogIn',
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
            ),
          ],
        );
  }
}
