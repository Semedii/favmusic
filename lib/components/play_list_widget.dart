import 'package:favmusic/cubits/play_list_cubit/tracks_cubit.dart';
import 'package:flutter/material.dart';

import '../screens/track_page.dart';

class PlayListWidget extends StatelessWidget {
  PlayListWidget(
      {this.imageurl,
      required this.name,
      required this.playListLink,
      super.key});

  final String? imageurl;
  final String name;
  final String playListLink;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TracksPage(
                      link: playListLink,
                      isalbum: false,
                      imageUrl: imageurl,
                    )));
      },
      child: Container(
        height: 200.0,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: imageurl != null
              ? Image.network(imageurl!).image
              : const AssetImage('assets/images/no_cover.jpeg'),
        )),
        child: Column(
          children: [
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
