import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isSettingsOpen = false.obs; // التحكم في حالة السايد بار
  var isSideBarOpen = false.obs; // حالة السايد بار

  // دالة لتبديل حالة السايد بار
  void toggleSettings() {
    isSettingsOpen.value = !isSettingsOpen.value;
    isSideBarOpen.value = !isSideBarOpen.value; // تغيير حالة السايد بار
  }
}

