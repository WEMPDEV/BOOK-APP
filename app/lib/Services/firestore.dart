import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/Model/book.dart';

class Firestore {
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection("books");

  Future<void> createBook(Book book) async {
    try {
      // await booksCollection.doc(book.id).set(book.toMap());
      await booksCollection.add(book.toMap());
    } catch (e) {
      print("Error adding book: $e");
    }
  }

  Future<List<Book>> getBooks({int limit = 100}) async {
    try {
      final snapshot = await booksCollection.limit(limit).get();
      return snapshot.docs.map((doc) {
        return Book.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error getting books: $e");
      throw Exception("Error getting books: $e");
    }
  }

  Future<void> updateBook(String docId, Book book) async {
    try {
      await booksCollection.doc(docId).update(book.toMap());
    } catch (e) {
      print("Error updating book: $e");
    }
  }

  Future<void> deleteBook(String docId) async {
    try {
      await booksCollection.doc(docId).delete();
    } catch (e) {
      print("Error deleting book: $e");
    }
  }
}
