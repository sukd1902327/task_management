import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:vita_app/firebase/authentication.dart';
import 'package:vita_app/widgets/button.dart';
import 'package:vita_app/widgets/input_field.dart';

class SignUp extends StatefulWidget {
  final VoidCallback toggleView;
  const SignUp({super.key, required this.toggleView});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //controllers must be used to save the user input in
  final _nameContr = TextEditingController();

  final _emailContr = TextEditingController();

  final _passwordContr = TextEditingController();

  final _conPasswordContr = TextEditingController();

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
                  const SizedBox(height: 50,),
                  //name input field
                  InputField(
                    hint: 'Full Name', 
                    obs: false,
                    maxLines: 1,
                    icon: const Icon(Icons.person), 
                    controller: _nameContr,
                    validator: (value) => value == null || value == ''
                    ? 'Please, enter your name!' : null,
                  ),
                  const SizedBox(height: 10,),
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
                  const SizedBox(height: 10,),
                  //confirm password input field
                  InputField(
                    hint: 'Confirm Password', 
                    obs: true,
                    maxLines: 1,
                    icon: const Icon(Icons.lock), 
                    controller: _conPasswordContr,
                    validator: (value) {
                      if(value == null || _passwordContr.text != _conPasswordContr.text) {
                        return 'Password does not match!';
                      } else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30,),
                  //sign up button
                  Button(
                    text: 'Sign Up', 
                    onPressed: () => signUpValidation(context),
                  ),
                  const SizedBox(height: 20,),
                  //to go back to Sign In page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', style: TextStyle(color: Colors.grey[700]),),
                      TextButton(
                        onPressed: widget.toggleView,
                        child: const Text('Log In', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
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

  void signUpValidation(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if(isValid) {
      //to show a loading progress while waiting to sign in
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      //we called signIn method from AuthServices class
      await auth.signUp(
        _nameContr.text.trim(),
        _emailContr.text.trim(), 
        _passwordContr.text.trim()
      );
    }
  }
}