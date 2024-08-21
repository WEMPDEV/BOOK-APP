import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final wishlistItems = WishlistManager().wishlistItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: wishlistItems.isEmpty
          ? Center(
              child: Text('Your wishlist is empty'),
            )
          : ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                return ListTile(
                  leading: Image.network(item.image, width: 50, height: 50),
                  title: Text(item.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Author: ${item.author}'),
                      Text('Price: \$${item.price.toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        WishlistManager().removeFromWishlist(item);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}

class WishlistManager {
  // Singleton pattern
  static final WishlistManager _instance = WishlistManager._internal();
  factory WishlistManager() => _instance;
  WishlistManager._internal();

  // List of wishlist items
  final List<WishlistItem> _wishlistItems = [];

  // Getter for wishlist items
  List<WishlistItem> get wishlistItems => List.unmodifiable(_wishlistItems);

  // Add a book to the wishlist
  void addToWishlist(WishlistItem item) {
    if (!_wishlistItems.contains(item)) {
      _wishlistItems.add(item);
    }
  }

  // Remove a book from the wishlist
  void removeFromWishlist(WishlistItem item) {
    _wishlistItems.remove(item);
  }
}

class WishlistItem {
  final String image;
  final String name;
  final String author;
  final double price;

  WishlistItem({
    required this.image,
    required this.name,
    required this.author,
    required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistItem &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
