// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:app/Model/book.dart';
import 'package:app/Services/firestore.dart';
import 'package:app/User/Screens/descriptionScreen.dart';
import 'package:flutter/material.dart';

class myBooks extends StatefulWidget {
  final int limit;
  final bool bestSeller;
  final bool newArrival;

  const myBooks({
    Key? key,
    required this.limit,
    this.bestSeller = false,
    this.newArrival = false,
  });

  @override
  State<myBooks> createState() => _myBooksState();
}

class _myBooksState extends State<myBooks> {
  late Future<List<Book>> booksFuture;
  final Firestore _firestore = Firestore();

  @override
  void initState() {
    super.initState();
    booksFuture = _fetchBooks();
  }

  Future<List<Book>> _fetchBooks() async {
    var books = await _firestore.getBooks();

    if (widget.bestSeller) {
      books = books.where((book) => book.bestseller).toList();
    }

    if (widget.newArrival) {
      books = books.where((book) => isNewArrival(book.publishedDate)).toList();
    }

    return books;
  }

  bool isNewArrival(String publishedDate) {
    // Define your logic for new arrival here, for example, within the last 30 days
    final now = DateTime.now();
    final publishedDateTime = DateTime.parse(publishedDate);
    return now.difference(publishedDateTime).inDays <= 30;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: booksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load books'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No books found'));
        } else {
          return SizedBox(
            height: 180, // Set a fixed height for the ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.limit,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                final author = book.authors.isNotEmpty
                    ? book.authors.join(', ')
                    : 'Unknown Author';
                final category = (book.categories as List).join(',');
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: InkWell(
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
                            genre: category,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: book.thumbnail.isNotEmpty
                                ? Image.network(
                                    book.thumbnail,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 150,
                                    height: 150,
                                    color: Colors.grey,
                                    child: Center(child: Text('No Image')),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  book.title,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  author,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
