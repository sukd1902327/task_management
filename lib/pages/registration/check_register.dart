
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vita_app/menu.dart';
import 'package:vita_app/pages/registration/toggle_pages.dart';

class CheckRegister extends StatelessWidget {
  const CheckRegister({super.key});

  @override
  Widget build(BuildContext context) {
    //stream builder will listen to userStateChange
    //if user has data, will keep signed in and show the home page
    //otherwise, will show the sign in page
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MenuPage();
        } else {
          return const TogglePages();
        }
      },
    );
  }
}