/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onReady() {
    super.onReady();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  // تسجيل الدخول بالبريد الإلكتروني وكلمة المرور
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offNamed('/home'); // الانتقال إلى الصفحة الرئيسية بعد تسجيل الدخول
    } catch (e) {
      Get.snackbar('Login Failed', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // تسجيل الخروج
  Future<void> logout() async {
    await _auth.signOut();
    Get.offNamed('/login');
  }

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offNamed('/home'); // الانتقال إلى الصفحة الرئيسية بعد التسجيل
    } catch (e) {
      Get.snackbar('Registration Failed', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
*/