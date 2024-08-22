// ignore_for_file: prefer_const_constructors

import 'package:app/Model/book.dart';
import 'package:app/Services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final Firestore _firestore = Firestore();
final TextEditingController _controller = TextEditingController();

class _HomePageState extends State<HomePage> {
  void OpenNewBox({String? docId}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(controller: _controller),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      if (docId == null) {
                        _firestore.createBook(_controller.text as Book);
                      } else {
                        _firestore.updateBook(docId, _controller.text as Book);
                      }
                      _controller.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Save'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text("Notes"),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: OpenNewBox,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.getNotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List notes = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot = notes[index];
                    String docId = documentSnapshot.id;

                    Map<String, dynamic> data =
                        documentSnapshot.data() as Map<String, dynamic>;

                    String noteText = data['note'];

                    return ListTile(
                        title: Text(noteText),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () => OpenNewBox(docId: docId),
                                icon: Icon(Icons.settings)),
                            IconButton(
                                onPressed: () {
                                  _firestore.deleteBook(docId);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ));
                  });
            } else {
              return const Text("No data");
            }
          }),
    );
  }
}
