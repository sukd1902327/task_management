// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vita_app/firebase/database.dart';
import 'package:vita_app/models/user_model.dart';
import 'package:vita_app/widgets/snackbar.dart';


class AuthService {
  
  FirebaseAuth auth = FirebaseAuth.instance;

  //create account with email & password
  Future signUp(String name, String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      UserModel userModel = UserModel(
        name: name, 
        email: user.email!,
        completedTask: 0,
        pendingTask: 0,
      );
      //to create user database
      await DatabaseService().setUserData(userModel);
      Get.back();
    } 
    on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.back();
        return mySnackbar('Error!', 'Email address is already in use!', Colors.red);
      }
      else{
        Get.back();
        return mySnackbar('Error!', 'Network connection failed!', Colors.red);
      }
    }
  }

  //sign in with email & password
  Future signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.back();
    } 
    on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Get.back();
        return mySnackbar('Error!', 'Invalid email address or incorrect password!', Colors.red);
      }
      else{
        Get.back();
        return mySnackbar('Error!', 'Network connection failed!', Colors.red);
      }
    }
  }

  //sign in with google account
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      // if(gUser == null){
      //   return ;
      // }
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      await auth.signInWithCredential(credential);
      UserModel userModel = UserModel(
        name: gUser.displayName, 
        email: gUser.email,
        completedTask: 0,
        pendingTask: 0,
      );
      //to create user database
      await DatabaseService().setUserData(userModel);
      print('${gUser.id} ===================');
      print('${gUser.displayName} ===================');
      print('${gUser.email} ===================');
    } 
    on FirebaseAuthException catch (e) {
      print(e.code + '=======================');
    }
  }

}