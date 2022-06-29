import 'package:flutter/material.dart';

class ApolloInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextStyle hintStyle;
  final AutovalidateMode autovalidateMode;
  final bool obscureText;

  const ApolloInputField({
    Key? key,
    required this.controller,
    this.hintText = "Enter here",
    this.validator,
    this.hintStyle = const TextStyle(fontSize: 14),
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: controller,
        autocorrect: false,
        onChanged: (text) {},
        validator: validator,
        autovalidateMode: autovalidateMode,
        obscureText: obscureText,
        decoration: InputDecoration(
            filled: true,
            alignLabelWithHint: true,
            hintText: hintText,
            hintStyle: hintStyle,
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
            disabledBorder: InputBorder.none,
            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
            labelStyle: const TextStyle(fontSize: 10, color: Colors.grey),
            fillColor: Colors.white,
            focusColor: Colors.white),
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
