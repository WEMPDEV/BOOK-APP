import 'package:flutter/material.dart';

class Chaptercontainer extends StatelessWidget {
  const Chaptercontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 400,
            height: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: Colors.black12)),
            child: Align(
              alignment: Alignment.topCenter,
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey),
                ),
                title: Text('Introduction'),
                subtitle: Text('Chapter 1'),
                trailing:
                    IconButton(onPressed: () {}, icon: Icon(Icons.play_circle)),
              ),
            ),
          )),
    );
  }
}
