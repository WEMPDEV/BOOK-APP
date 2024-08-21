// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          suffixIcon: Container(
            child: IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt)),
            decoration: BoxDecoration(color: Color.fromARGB(179, 158, 158, 158)
                // gradient: RadialGradient(colors: Colors.b)
                ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        ),
        child: TextField(
          decoration: InputDecoration.collapsed(hintText: "Search Books"),
        ),
      ),
    );
  }
}
