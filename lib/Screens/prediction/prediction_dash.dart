import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Prediction extends StatelessWidget {
  final List<String> imageList = [
    "https://images.pexels.com/photos/6765371/pexels-photo-6765371.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/730552/pexels-photo-730552.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/7293821/pexels-photo-7293821.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
  ];

  Prediction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlay: true,
          ),
          items: imageList
              .map((e) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.network(
                          e,
                          width: 1050,
                          height: 350,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
