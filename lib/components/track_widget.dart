import 'package:flutter/material.dart';
import '../model/track.dart';

class PlaylistTracks extends StatelessWidget {
  const PlaylistTracks({required this.name, required this.artistName, this.imageUrl, Key? key}) : super(key: key);

  final String name;
  final String artistName;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
        return ListTile(
            title: Text(name),
            subtitle: Text(artistName),
            leading: Image(
              image: imageUrl != null
                  ? Image.network(imageUrl!).image
                  : const AssetImage('assets/images/no_cover.jpeg'),
            ));
  
  }
}
