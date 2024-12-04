import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';


import 'constants/themes.dart';
import 'controllers/lazy_controller.dart';
import 'views/splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  // ignore: unused_field
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (BuildContext context, Orientation orientation, deviceType) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: GetMaterialApp(
          initialBinding: LazyController(),
          debugShowCheckedModeBanner: false,
          title: 'NEXMAX',
          theme: Styles.themeData(false, context),
          home: const SplashScreen(),
          localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
      ],
        ),
      );
    });
  }
}
