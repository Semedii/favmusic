import 'package:flutter/material.dart';

import '../screens/track_page.dart';

class AlbumWidget extends StatelessWidget {
  const AlbumWidget(
      {super.key,
      required this.albumName,
      required this.artistName,
      required this.releaseDate,
      required this.trackCount,
      required this.albumLink,
      this.imageurl});

  final String? imageurl;
  final String albumName;
  final String artistName;
  final String releaseDate;
  final String albumLink;
  final int trackCount;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TracksPage(
                      link: albumLink,
                      isalbum: true,
                      imageUrl: imageurl,
                    )));
      },
      child: SizedBox(
        height: 320,
        width: double.infinity,
        child: Column(
          children: [
            Image(
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                image: imageurl != null
                    ? Image.network(imageurl!).image
                    : const AssetImage('assets/images/no_cover.jpeg')),
            Container(
              height: 100,
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      albumName.toUpperCase(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 28),
                    ),
                    _getAlbumDetails('ARTIST:', artistName),
                    _getAlbumDetails(
                        'TOTAL # OF TRACKS:', trackCount.toString()),
                    _getAlbumDetails("RELEASED ON:", releaseDate),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

_getAlbumDetails(String title, String text) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(title),
      ),
      const Spacer(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(text.toUpperCase()),
      ),
    ],
  );
}
