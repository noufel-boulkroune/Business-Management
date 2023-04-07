// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:business_management/constante/spacing.dart';

class CustomTextFormField extends StatelessWidget {
  final String productLabel;
  final String productHint;
  final IconData fieldIcon;

  const CustomTextFormField({
    Key? key,
    required this.productLabel,
    required this.productHint,
    required this.fieldIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: Spacing.MARGIN_SIZE_SMALL),
        child: TextField(
            decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue.shade100,
          labelText: productLabel,
          labelStyle: const TextStyle(color: Colors.blue),
          hintText: productHint,
          hintStyle: const TextStyle(color: Colors.blue),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide.none),
          prefixIcon: Icon(
            fieldIcon,
            color: Colors.white,
          ),
        )));
  }
}
