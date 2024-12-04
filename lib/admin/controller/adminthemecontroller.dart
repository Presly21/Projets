import 'package:get/get.dart';

class AdminThemeController extends GetxController {
  var isDarkTheme = false.obs;

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
  }
}
