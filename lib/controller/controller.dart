import 'dart:io';

import 'package:ecpods/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../dataFile/data_file.dart';
import '../model/popular_model.dart';
import '../model/release_model.dart';

class IntroController extends GetxController {
  RxInt position = 0.obs;

  onChange(RxInt value) {
    position.value = value.value;
    update();
  }
}

class LoginController extends GetxController with GetTickerProviderStateMixin {
  RxBool select = false.obs;

  onValueChange() {
    if (!select.value) {
      select = true.obs;
    } else {
      select = false.obs;
    }
    update();
  }
}

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(
      msg: e.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Account created successfully.');
      Get.offAllNamed('/home');
      // Handle successful sign up
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            // Handle email already in use error
            Get.snackbar('Email Already in Use', 'Please use a different email address.');
            break;
          case 'invalid-email':
            // Handle invalid email error
            Get.snackbar('Invalid Email', 'Please enter a valid email address.');
            break;
          case 'operation-not-allowed':
            // Handle operation not allowed error
            Get.snackbar('Operation Not Allowed', 'This operation is not allowed.');
            break;
          case 'weak-password':
            // Handle weak password error
            Get.snackbar('Weak Password', 'Please use a stronger password.');
            break;
          default:
            // Handle other errors
            Get.snackbar('Error', 'An error occurred while signing up.');
            break;
        }
      } else {
        // Handle other exceptions
        Get.snackbar('Error', 'An error occurred while signing up.');
      }
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Logged in successfully.');
      // Get.offAllNamed('/home');
      Get.toNamed(Routes.homeRoute);
      // Handle successful sign in
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            // Handle invalid email error
            Get.snackbar('Invalid Email', 'Please enter a valid email address.');
            break;
          case 'wrong-password':
            // Handle wrong password error
            Get.snackbar('Wrong Password', 'Please enter the correct password.');
            break;
          case 'user-not-found':
            // Handle user not found error
            Get.snackbar('User Not Found', 'Please create an account first.');
            break;
          default:
            // Handle other errors
            Get.snackbar('Error', 'An error occurred while signing in.');
            break;
        }
      } else {
        // Handle other exceptions
        Get.snackbar('Error', 'An error occurred while signing in.');
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    // Get.offAllNamed('/login');
    Get.toNamed(Routes.loginRoute);
    // Handle successful sign out
  }

Future<void> deleteAccount() async {
    try {
      await _auth.currentUser!.delete();
      Get.snackbar('Success', 'Account deleted successfully.');
      // Get.offAllNamed('/login');
      Get.toNamed(Routes.loginRoute);
      // Handle successful account deletion
    } catch (e) {
      // Handle errors
      Get.snackbar('Error', 'An error occurred while deleting your account.');
    }
  }

}

class HomeController extends GetxController {
  RxInt index = 0.obs;

  onChange(RxInt value) {
    index.value = value.value;
    update();
  }
}

class HomeScreenController extends GetxController {
  RxInt index = 0.obs;

  indexChange(RxInt value) {
    index.value = value.value;
    update();
  }
}

class SearchController extends GetxController {
  List<String> searchList = [
    "You're Wrong About",
    "Slow Burn",
    "Discover Your True Self"
  ];

  itemRemove(int index) {
    searchList.removeAt(index);
    update();
  }

// onItemChanged(String value) {
//   searchList = searchList
//       .where((element) => element.toLowerCase().contains(value.toLowerCase()))
//       .toList();
//   update();
// }
}

class FilterController extends GetxController {
  RxInt select = 0.obs;
  RxInt subjectSelect = 0.obs;

  selectChange(int value) {
    select.value = value;
    update();
  }

  subjectChange(int value) {
    subjectSelect.value = value;
    update();
  }
}

class ProfileController extends GetxController {
  RxBool edit = false.obs;

  File? image;
  RxString imagePath = ''.obs;
  final _picker = ImagePicker();

  getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imagePath(pickedFile.path);
      update();
    } else {}
  }

  editchange() {
    edit.value = edit.value ? false : true;
    update();
  }

  editFalse() {
    edit.value = false;
    update();
  }
}

class DownloadController extends GetxController {
  RxBool list = false.obs;
  List<ModelPopular> downloadLists = DataFile.downloadList;

  getList(bool value) {
    list.value = value;
    update();
  }

  removeItem(int index) {
    downloadLists.removeAt(index);
    update();
  }
}

class LibraryController extends GetxController{
  List<ModelRelease> libraryLists = DataFile.libraryList;

  removeItem(int index){
    libraryLists.removeAt(index);
    update();
  }
}
