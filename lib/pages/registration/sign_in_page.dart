import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/firebase/authentication.dart';
import 'package:vita_app/widgets/button.dart';
import 'package:vita_app/widgets/input_field.dart';

class SignIn extends StatefulWidget {
  final VoidCallback toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //controllers must be used to save the user input in
  final _emailContr = TextEditingController();

  final _passwordContr = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //our app's logo
                  Image.asset('assets/images/startup.png', height: 150,),
                  const SizedBox(height: 30,),
                  //email input field
                  InputField(
                    hint: 'Email Address', 
                    obs: false,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    icon: const Icon(Icons.email), 
                    controller: _emailContr,
                    validator: (value) {
                      if(value == null || !EmailValidator.validate(value)) {
                        return 'Enter valid email address!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
                  //password input field
                  InputField(
                    hint: 'Password', 
                    obs: true,
                    maxLines: 1,
                    icon: const Icon(Icons.lock), 
                    controller: _passwordContr,
                    validator: (value) {
                      if(value == null || value.length < 7) {
                        return 'Password must be more than 6 character!';
                      } else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30,),
                  //sign in button
                  Button(
                    text: 'Sign In', 
                    onPressed: () => signInValidation(context),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        const Expanded(child: Divider(thickness: 1,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('or continue with', style: TextStyle(color: Colors.grey[700]),),
                        ),
                        const Expanded(child: Divider(thickness: 1,)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  //sign in with google
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(child: CircularProgressIndicator()),
                      );
                      await auth.signInWithGoogle();
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      //google's logo
                      child: Image.asset('assets/images/google.png', height: 40,),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //to go to register screen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?', style: TextStyle(color: Colors.grey[700]),),
                      TextButton(
                        onPressed: widget.toggleView,
                        child: const Text('Register', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signInValidation(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if(isValid) {
      //to show a loading progress while waiting to sign in
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      //we called signIn method from AuthServices class
      await auth.signIn(
        _emailContr.text.trim(), 
        _passwordContr.text.trim()
      );
    }
  }
}