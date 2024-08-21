import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  double getTotalPrice() {
    return CartManager.getTotalPrice();
  }

  void incrementQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void decrementQuantity(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      }
    });
  }

  void removeItem(CartItem item) {
    setState(() {
      CartManager.cartItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartManager.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text('Your cart is empty'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
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
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize : MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => decrementQuantity(item),
                            icon: Icon(Icons.remove),
                          ),
                          Text(item.quantity.toString()),
                          IconButton(
                            onPressed: () => incrementQuantity(item),
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () => removeItem(item),
                        child: Text('Remove'),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${getTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Proceed to checkout
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartManager {
  static List<CartItem> _cartItems = [];

  static List<CartItem> get cartItems => _cartItems;

  static void addToCart(Book book) {
    bool found = false;
    for (var item in _cartItems) {
      if (item.name == book.name) {
        item.quantity++;
        found = true;
        break;
      }
    }
    if (!found) {
      _cartItems.add(CartItem(
        image: book.image,
        name: book.name,
        author: book.author,
        price: book.price,
      ));
    }
  }

  static double getTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
}

class CartItem {
  final String image;
  final String name;
  final String author;
  final double price;
  int quantity;

  CartItem({
    required this.image,
    required this.name,
    required this.author,
    required this.price,
    this.quantity = 1,
  });
}

class Book {
  final String image;
  final String name;
  final String author;
  final double price;

  Book({
    required this.image,
    required this.name,
    required this.author,
    required this.price,
  });
}
