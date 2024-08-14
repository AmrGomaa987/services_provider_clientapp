import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class MyCarousel1 extends StatefulWidget {
  final List<String> images;
  final CarouselOptions carouselOptions;

  const MyCarousel1({
    Key? key,
    required this.images,
    required this.carouselOptions,
  }) : super(key: key);

  @override
  State<MyCarousel1> createState() => _CarouselState();
}

class _CarouselState extends State<MyCarousel1> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: widget.carouselOptions.copyWith(
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              if (widget.carouselOptions.onPageChanged != null) {
                widget.carouselOptions.onPageChanged!(index, reason);
              }
            },
          ),
          items: widget.images.map((item) {
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
          dotsCount: widget.images.length,
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
