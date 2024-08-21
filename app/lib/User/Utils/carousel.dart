// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app/User/Screens/discoverScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousel extends StatefulWidget {
  Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final List<String> imgList = [
    "https://img.freepik.com/free-photo/antique-book-collection-old-bookshelf-generated-by-ai_188544-42344.jpg?t=st=1721774032~exp=1721777632~hmac=6c7bcb9a2e7b956a688f00b710a099d4db04154b7fc8541eb11dc526da0df3de&w=826",
    "https://img.freepik.com/free-photo/antique-book-collection-old-bookshelf-generated-by-ai_188544-42344.jpg?t=st=1721774032~exp=1721777632~hmac=6c7bcb9a2e7b956a688f00b710a099d4db04154b7fc8541eb11dc526da0df3de&w=826",
    "https://img.freepik.com/free-photo/antique-book-collection-old-bookshelf-generated-by-ai_188544-42344.jpg?t=st=1721774032~exp=1721777632~hmac=6c7bcb9a2e7b956a688f00b710a099d4db04154b7fc8541eb11dc526da0df3de&w=826",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Discoverscreen()));
          },
          child: CarouselSlider.builder(
            itemCount: imgList.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = imgList[index];
              return buildImage(urlImage, index);
            },
            options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() => activeIndex = index);
                }),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        buildIndicator()
      ],
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          width: 400,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Image.network(
            urlImage,
            fit: BoxFit.contain,
          ),
        ),
      );

  int activeIndex = 0;

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imgList.length,
        effect: ExpandingDotsEffect(dotWidth: 15, activeDotColor: Colors.blue),
      );
}
