import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  final List<String> images = [
    "assets/bannerimage/banar1.jpg",
    "assets/bannerimage/banar2.jpg",
    "assets/bannerimage/banar3.jpg",
    "assets/bannerimage/banar4.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: images.map((item) {
            return Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: 350,
                ),
              ),
            );
          }).toList(),
        ),
        DotsIndicator(
          dotsCount: images.length,
          position: _currentIndex.toDouble(),
          decorator: DotsDecorator(
            size: const Size.square(8.0),
            activeSize: const Size(20.0, 8.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }
}
