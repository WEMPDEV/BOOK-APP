// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/Model/book.dart';
import 'package:app/Services/firestore.dart';
import 'package:app/User/Screens/descriptionScreen.dart';
import 'package:flutter/material.dart';

class Allbooks extends StatefulWidget {
  const Allbooks({super.key});

  @override
  State<Allbooks> createState() => _AllbooksState();
}

class _AllbooksState extends State<Allbooks> {
  final Firestore _firestore = Firestore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Books'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Book>>(
        future: _firestore.getBooks(limit: 100),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load books'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                final author = book.authors.isNotEmpty
                    ? book.authors.join(', ')
                    : 'Unknown Author';
                final category = (book.categories as List).join(',');

                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  leading: book.thumbnail.isNotEmpty
                      ? Image.network(
                          book.thumbnail,
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 50,
                          height: 75,
                          color: Colors.grey,
                          child: Center(child: Text('No Image')),
                        ),
                  title: Text(
                    book.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    author,
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Descriptionscreen(
                                author: author,
                                description: book.description,
                                image: book.thumbnail,
                                name: book.title,
                                summary: book.summary,
                                language: book.language,
                                price: book.price,
                                publishedDate: book.publishedDate,
                                genre: category)));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
