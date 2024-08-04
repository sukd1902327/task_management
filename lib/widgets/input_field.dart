import 'package:flutter/material.dart';

//we create this class to be used multiple times in the project
//we used in sign in page twice and in sign up page 3 times
//that makes our code clean and simple
class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.obs,
    this.hint,
    this.controller,
    this.icon,
    this.keyboardType,
    this.maxLines,
    this.validator,
  }) : super(key: key);

  final String? hint;
  final int? maxLines;
  final Widget? icon;
  final bool obs;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.85,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obs,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.green),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}