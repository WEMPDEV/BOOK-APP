// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:app/User/Screens/cartScreen.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: ClipOval(
          child: Image(
            image: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ7-wr_mtVcXzMPCLl7_qLle_NKK_atDe6ZQ&s"),
            fit: BoxFit.contain,
          ),
        ),
        title: Text("Hi, Tony"),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_on_sharp,
                  size: 20,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border:
                      Border.all(color: Colors.grey, style: BorderStyle.solid)),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 20,
                  )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border:
                      Border.all(color: Colors.grey, style: BorderStyle.solid)),
            ),
          ],
        ),
      ),
    );
  }
}
