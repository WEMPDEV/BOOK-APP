import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:app/Model/book.dart';

class BooksApi {
  final String filePath = 'assets/books.json';

  Future<List<Book>> fetchBooks() async {
    try {
      final jsonString = await rootBundle.loadString(filePath);
      final List<dynamic> data = json.decode(jsonString);

      return data.map((json) => Book.fromJson(json)).toList();
    } catch (e) {
      print('Error initializing books: $e');
      throw Exception('Error initializing books: $e');
    }
  }
}
