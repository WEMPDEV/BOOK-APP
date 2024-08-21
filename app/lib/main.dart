// ignore_for_file: prefer_const_constructors, unused_import

import 'package:app/Admin/adminPage.dart';
import 'package:app/User/Screens/allBooks.dart';
import 'package:app/User/Screens/cartScreen.dart';
import 'package:app/User/Screens/discoverScreen.dart';
import 'package:app/User/Screens/homeScreen.dart';
import 'package:app/User/Screens/searchScreen.dart';
import 'package:app/User/Utils/bottomNavigation.dart';
import 'package:app/User/Utils/searchBar.dart';
import 'package:app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminPage(),
    );
  }
}
