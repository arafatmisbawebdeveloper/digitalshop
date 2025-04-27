import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  static AuthService instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    // Binding the user stream so we can track changes to the user state.
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    // Automatically navigate to either the login or home screen based on user state
    ever(_user, _initialScreen);
  }

  // This function handles the screen navigation when user state changes
  _initialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/login'); // Navigate to login screen if no user
    } else {
      Get.offAllNamed('/home'); // Navigate to home screen if user is logged in
    }
  }

  // Register a new user
  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // After successful registration, user is automatically logged in
    } catch (e) {
      // Display error message using Get.snackbar if registration fails
      Get.snackbar('Registration Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Login an existing user
  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      // On successful login, the user will be redirected automatically
    } catch (e) {
      // Show error message in case login fails
      Get.snackbar('Login Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Logout the user and navigate to the login page
  void logout() async {
    await auth.signOut(); // Sign out the current user
    Get.offAllNamed('/login'); // Navigate back to login screen
  }

  // Check if the user is logged in
  User? get currentUser => auth.currentUser;
}
