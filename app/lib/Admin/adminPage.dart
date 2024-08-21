import 'package:app/Model/book.dart';
import 'package:app/Services/apiService.dart';
import 'package:app/Services/firestore.dart';
import 'package:app/User/Screens/descriptionScreen.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final Firestore _firestore = Firestore();
  final BooksApi _apiService = BooksApi();
  bool _isLoading = true;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeBooks();
  }

  Future<void> _initializeBooks() async {
    try {
      List<Book> books = await _apiService.fetchBooks();
      for (Book book in books) {
        await _firestore.createBook(book);
      }
      _isInitialized = true;
    } catch (e) {
      print("Error initializing books: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Book>>(
              future: _isInitialized
                  ? _firestore.getBooks(limit: 100)
                  : Future.value([]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No books available'));
                }

                final books = snapshot.data!;

                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return ListTile(
                      leading: book.thumbnail.isNotEmpty
                          ? Image.network(
                              book.thumbnail,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : null,
                      title: Text(book.title),
                      subtitle: Text(book.authors.join(', ')),
                      trailing: IconButton(
                        onPressed: () {
                          _firestore.deleteBook(book.id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
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
                    );
                  },
                );
              },
            ),
    );
  }
}
