import 'package:flutter/material.dart';
import 'package:vita_app/pages/registration/sign_in_page.dart';
import 'package:vita_app/pages/registration/sign_up_page.dart';

class TogglePages extends StatefulWidget {
  const TogglePages({super.key});

  @override
  State<TogglePages> createState() => _TogglePagesState();
}

class _TogglePagesState extends State<TogglePages> {

  bool showSignIn = true;
  void toggle() {
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggle);
    }
    else{
      return SignUp(toggleView: toggle);
    }
  }
}