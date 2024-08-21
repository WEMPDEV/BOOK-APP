// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/Model/book.dart';
import 'package:app/Services/firestore.dart';
import 'package:app/User/Screens/descriptionScreen.dart';
import 'package:app/User/Screens/searchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/User/Utils/authors.dart';
import 'package:app/User/Utils/books.dart';
import 'package:app/User/Utils/bottomNavigation.dart';
import 'package:app/User/Utils/myTextButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Discoverscreen extends StatefulWidget {
  const Discoverscreen({super.key});

  @override
  State<Discoverscreen> createState() => _DiscoverscreenState();
}

class _DiscoverscreenState extends State<Discoverscreen> {
  Firestore _firestore = Firestore();
  bool ascending = false;
  bool Searching = false;
  String filterCriteria = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: ListTile(
                title: Text(
                  "Discover",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Searchscreen()));
                        },
                        icon: Icon(Icons.search)),
                    IconButton(
                      onPressed: () {
                        // _showFilterDialog(context);
                      },
                      icon: Icon(Icons.filter_alt),
                    ),
                  ],
                ))),
        body: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Popular Authors"),
                      TextButton(child: Text("See more"), onPressed: () {}),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Authors(
                    limit: 10,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Popular Genres"),
                      TextButton(child: Text("See more"), onPressed: () {}),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    myTextButton(text: "text", color: Colors.black12),
                    myTextButton(text: "text", color: Colors.black12),
                    myTextButton(text: "text", color: Colors.black12),
                    myTextButton(text: "text", color: Colors.black12),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Popular Books"),
                      TextButton(child: Text("See more"), onPressed: () {}),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 400,
                        height: 220,
                        child: myBooks(
                          limit: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        // bottomNavigationBar: BottomNavbar(),
        );
  }
}
