

import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  CustomField(
      {super.key,
        required this.controller,
        this.title,
        this.keyboardType,
        this.validator,
        this.maxline,
        this.onChanged,
        this.icon,
        this.minLine});

  TextEditingController controller = TextEditingController();
  final String? title;
  final int? maxline;
  final int? minLine;
  final IconData? icon;
  final TextInputType? keyboardType;
  void Function(String)? onChanged;

  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: minLine,
      maxLines: maxline,
      onChanged:onChanged ,
      keyboardType: keyboardType,
      decoration: InputDecoration(

        suffixIcon: Icon(icon),
        isDense: true,
        hintText: title,

        hintStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
