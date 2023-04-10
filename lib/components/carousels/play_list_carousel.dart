import 'package:carousel_slider/carousel_slider.dart';
import 'package:favmusic/components/play_list_widget.dart';
import 'package:flutter/material.dart';

class PlayListCarousel extends StatelessWidget {
  const PlayListCarousel(
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
    return 
   Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF2196F3), width: 5)
      ),
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlayInterval: Duration(seconds: seconds),
                height: 200.0,
                autoPlay: true,
                viewportFraction: 1.0),
            items: items.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return PlayListWidget(i.image, i.name);
                },
              );
            }).toList(),
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
