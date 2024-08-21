import 'dart:math';
import 'package:app/User/Screens/cartScreen.dart';
import 'package:app/User/Screens/wish_list_screen.dart';
import 'package:flutter/material.dart';

class Descriptionscreen extends StatefulWidget {
  Descriptionscreen({
    super.key,
    required this.author,
    required this.description,
    required this.image,
    required this.name,
    required this.summary,
    required this.language,
    required this.price,
    required this.publishedDate,
    required this.genre,
  });

  final String image;
  final String name;
  final String author;
  final String description;
  final String summary;
  final String language;
  final double price;
  final String publishedDate;
  final String genre;

  @override
  State<Descriptionscreen> createState() => _DescriptionscreenState();
}

class _DescriptionscreenState extends State<Descriptionscreen> {
  int _index = 0;
  final List<Widget> miniPages = [AboutBooks(), Reviews()];

  @override
  void initState() {
    super.initState();
    miniPages[0] = AboutBooks(
      description: widget.description,
      name: widget.author,
      image: widget.image,
      summary: widget.summary,
      language: widget.language,
      genre: widget.genre,
      publishedDate: widget.publishedDate,
    );
  }

  void miniNavClick(int index) {
    setState(() {
      _index = index;
    });
  }

  void addToWishlist() {
    final item = WishlistItem(
      image: widget.image,
      name: widget.name,
      author: widget.author,
      price: widget.price,
    );
    WishlistManager().addToWishlist(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.name} added to wishlist!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          size: 20,
                        )),
                  ),
                  Text(
                    "Book details",
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey)),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share,
                              size: 20,
                            )),
                      ),
                      SizedBox(width: 5.0),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey)),
                        child: IconButton(
                            onPressed: () {
                              addToWishlist();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WishlistScreen()));
                            },
                            icon: Icon(
                              Icons.favorite,
                              size: 20,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  child: ClipRRect(
                      child: Image(
                    image: NetworkImage(widget.image, scale: .5),
                    width: 200,
                  )),
                ),
              ),
              Text(widget.name),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.author,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.blue,
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(color: Colors.black)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => miniNavClick(0),
                        child: Text("About Book")),
                    TextButton(
                        onPressed: () => miniNavClick(1),
                        child: Text("Reviews")),
                  ],
                ),
              ),
              Container(
                child: miniPages[_index],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        shadowColor: Colors.blueGrey,
        height: 80,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ ${widget.price}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {
                    CartManager.addToCart(Book(
                      image: widget.image,
                      name: widget.name,
                      author: widget.author,
                      price: widget.price,
                    ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  },
                  child: Text("Buy Now"))
            ],
          ),
        ),
      ),
    );
  }
}

class AboutBooks extends StatelessWidget {
  AboutBooks(
      {super.key,
      this.description = ' ',
      this.name = '',
      this.image = '',
      this.summary = '',
      this.language = '',
      this.publishedDate = '',
      this.genre = ''});
  final String description;
  final String name;
  final String image;
  final String summary;
  final String language;
  final String publishedDate;
  final String genre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About this E-book",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(description),
              ],
            ),
          ),
          Text(
            "About Author",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(65),
              child: Image.network(
                image,
                width: 50,
                height: 50,
              ),
            ),
            title: Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Author',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          Text(
            "Book Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(summary),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              height: .1,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                border:
                    BorderDirectional(bottom: BorderSide(color: Colors.black)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Genre',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.person_3_rounded),
                  Text(
                    genre,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Container(
                height: 80,
                width: 2,
                color: Colors.black12,
              ),
              Column(
                children: [
                  Text(
                    'Released',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    publishedDate,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Container(
                height: 80,
                width: 2,
                color: Colors.black12,
              ),
              Column(
                children: [
                  Text(
                    'Language',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    language,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              height: .1,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                border:
                    BorderDirectional(bottom: BorderSide(color: Colors.black)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("Reviews")],
    );
  }
}
