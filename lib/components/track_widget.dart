import 'package:flutter/material.dart';
import '../model/track.dart';

class TrackWidget extends StatelessWidget {
  const TrackWidget(
      {required this.trackList,
      this.imageUrl,
      required this.selectedIndex,
      required this.onTap,
      Key? key})
      : super(key: key);

  final List<Track> trackList;
  final int selectedIndex;
  final String? imageUrl;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: trackList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(trackList[index].name),
              subtitle: Text(trackList[index].artistName),
              leading: Image(
                image: imageUrl != null
                    ? Image.network(imageUrl!).image
                    : const AssetImage('assets/images/no_cover.jpeg'),
              ),
              trailing: selectedIndex == index
                  ? IconButton(
                      onPressed: () => onTap(index), icon: Icon(Icons.pause))
                  : IconButton(
                      onPressed: () => onTap(index),
                      icon: Icon(Icons.play_arrow)));
        });
  }
}
