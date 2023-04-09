import 'package:carousel_slider/carousel_slider.dart';
import 'package:favmusic/components/trending_music_widget.dart';
import 'package:flutter/material.dart';

class MusicCarousel extends StatelessWidget {
  const MusicCarousel(
      {required this.items,
      required this.title,
      required this.icon,
      required this.seconds,
      super.key});
  final List items;
  final String title;
  final IconData icon;
  final int seconds;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlayInterval:  Duration(seconds: seconds),
              height: 200.0, autoPlay: true, viewportFraction: 1.0),
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return MusicWidget(i.imageurl, i.name);
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 27, 2, 70)),
            ),
          ],
        ),
      ],
    );
  }
}
