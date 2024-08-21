// // ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_import

// import 'package:app/User/Screens/cartScreen.dart';
// import 'package:app/User/Screens/discoverScreen.dart';
// import 'package:app/User/Screens/homeScreen.dart';
// import 'package:flutter/material.dart';

// class BottomNavbar extends StatefulWidget {
//   const BottomNavbar({super.key});

//   @override
//   State<BottomNavbar> createState() => _BottomNavbarState();
// }

// class _BottomNavbarState extends State<BottomNavbar> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     homeScreen(),
//     Discoverscreen(),
//     // Cart(), // Pass required parameters if any
//     // ProfileScreen(), // Add your profile screen here
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed, // Ensures all items are visible
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore),
//             label: 'Discover',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
