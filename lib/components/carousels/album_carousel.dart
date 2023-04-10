import 'package:carousel_slider/carousel_slider.dart';
import 'package:favmusic/components/album_widget.dart';
import 'package:favmusic/model/album.dart';
import 'package:flutter/material.dart';

class AlbumCarousel extends StatelessWidget {
  const AlbumCarousel(
      {required this.items,
      required this.title,
      required this.icon,
      super.key});
  final List<Album> items;
  final String title;
  final IconData icon;
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
                height: 300, autoPlay: true, viewportFraction: 1.0),
            items: items.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return AlbumWidget(
                    albumName: i.albumName,
                    artistName: i.artistName,
                    releaseDate: i.releaseDate,
                    imageurl: i.imageUrl,
                    trackCount: i.trackCount,
                  );
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
