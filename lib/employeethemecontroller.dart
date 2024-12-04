import 'package:get/get.dart';

class EmployeeThemeController extends GetxController {
  var isDarkTheme = false.obs;

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
  }
}
