import 'package:app/Model/book.dart';
import 'package:app/Services/firestore.dart';
import 'package:app/User/Screens/descriptionScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  String _selection = 'title';
  bool isSearching = false;
  String? searchInput;
  final searchFieldController = TextEditingController();
  Future<List<Book>>? booksFuture;
  final Firestore _firestore = Firestore();

  void getBooksByTitle(String title) {
    setState(() {
      booksFuture = _firestore.getBooks(limit: 50).then((books) {
        return books
            .where((book) =>
                book.title.toLowerCase().contains(title.toLowerCase()))
            .toList();
      });
    });
  }

  void getBooksByAuthor(String author) {
    setState(() {
      booksFuture = _firestore.getBooks(limit: 50).then((books) {
        return books
            .where((book) => book.authors
                .any((a) => a.toLowerCase().contains(author.toLowerCase()))) 
            .toList();
      });
    });
  }

  void getBooksByGenre(String genre) {
    setState(() {
      booksFuture = _firestore.getBooks(limit: 50).then((books) {
        return books
            .where((book) => book.categories.any(
                (category) => category.toLowerCase() == genre.toLowerCase()))
            .toList();
      });
    });
  }

  void filterBooksByPrice(double maxPrice) {
    setState(() {
      booksFuture = _firestore.getBooks(limit: 50).then((books) {
        return books.where((book) => book.price <= maxPrice).toList();
      });
    });
  }

  void filterBooksByPublishedDate(String date) {
    setState(() {
      booksFuture = _firestore.getBooks(limit: 50).then((books) {
        return books.where((book) => book.publishedDate == date).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: TextField(
                          controller: searchFieldController,
                          onChanged: (value) {
                            searchInput = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: PopupMenuButton<String>(
                              icon: Icon(Icons.tune),
                              onSelected: (String newValue) {
                                setState(() {
                                  _selection = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'title',
                                  child: Text('Search Title'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'author',
                                  child: Text('Search Author'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'category',
                                  child: Text('Search Categories'),
                                ),
                              ],
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  searchFieldController.clear();
                                  setState(() {
                                    searchInput = null;
                                    booksFuture = null;
                                  });
                                }),
                            hintText: 'Search by title, author or genre',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (_selection == 'title' && searchInput != null) {
                          getBooksByTitle(searchInput!);
                          searchInput = null;
                          searchFieldController.clear();
                        } else if (_selection == 'author' &&
                            searchInput != null) {
                          getBooksByAuthor(searchInput!);
                          searchInput = null;
                          searchFieldController.clear();
                        } else if (_selection == 'category' &&
                            searchInput != null) {
                          getBooksByGenre(searchInput!);
                          searchInput = null;
                          searchFieldController.clear();
                        }
                      },
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt))
                  ],
                ),
              ),
              booksFuture == null
                  ? Expanded(
                      child: Container(
                        child: Center(),
                      ),
                    )
                  : Expanded(
                      child: FutureBuilder<List<Book>>(
                        future: booksFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Failed to load books'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('No books found'));
                          } else {
                            var books = snapshot.data!;
                            return ListView.builder(
                              itemCount: books.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var book = books[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Descriptionscreen(
                                          author: book.authors.join(', '),
                                          description: book.description,
                                          image: book.thumbnail,
                                          name: book.title,
                                          summary: book.summary,
                                          language: book.language,
                                          price: book.price,
                                          publishedDate: book.publishedDate,
                                          genre: book.categories.join(', '),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 6.0,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                book.authors.join(', '),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                book.title,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: 'Kaushan Script',
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                book.publishedDate,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                height: 60,
                                                child: Text(
                                                  book.description,
                                                  softWrap: true,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily:
                                                        'Source Sans Pro',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
