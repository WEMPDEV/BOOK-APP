// ignore_for_file: sort_child_properties_last, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

class myButtons extends StatelessWidget {
  myButtons({super.key, required this.onPressed, required this.child});

  VoidCallback onPressed;
  Widget child;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: child,
      color: color,
    );
  }
}
