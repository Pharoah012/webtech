import 'package:flutter/material.dart';
import 'package:webtech_project/constants.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;


  const CustomTextField({super.key, 
    this.controller,
    required this.labelText,
    
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: kGrey,
        ),
        borderRadius: BorderRadius.circular(20))

    ),

    );
  }
}