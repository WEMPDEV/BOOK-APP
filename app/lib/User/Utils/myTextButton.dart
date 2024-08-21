// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class myTextButton extends StatelessWidget {
  myTextButton({super.key, required this.text, required this.color});
  final String text;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextButton(
        onPressed: () {},
        child: Text(text,style : TextStyle(color:Colors.white)),
        style: TextButton.styleFrom(
            backgroundColor: color),
      ),
    );
  }
}
