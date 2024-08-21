// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/User/Utils/authors.dart';
import 'package:app/User/Utils/books.dart';
import 'package:app/User/Utils/bottomNavigation.dart';
import 'package:app/User/Utils/carousel.dart';
import 'package:app/User/Utils/header.dart';
import 'package:app/User/Utils/myTextButton.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discover",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 25),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "See more",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                    )),
                Carousel(),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Best sellers",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                    )),
                SizedBox(
                  height: 250, // Set a fixed height for the ListView
                  child: myBooks(
                    limit: 10,
                    bestSeller: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    width: 380,
                    height: .5,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "New arrivals",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See All",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 250, // Set a fixed height for the ListView
                  child: myBooks(
                    limit: 10,
                    newArrival: true,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Authors",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                    )),
                SizedBox(
                  height: 100,
                  child: Authors(
                    limit: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavbar(),
    );
  }
}
