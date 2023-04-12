import 'package:favmusic/screens/home_page.dart';
import 'package:favmusic/screens/latest_releases_page.dart';
import 'package:flutter/material.dart';

import 'my_playlist_page.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar();

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

int currentIndex = 1;

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: ontap,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[500],
      backgroundColor: const Color.fromARGB(255, 50, 50, 50),
      selectedLabelStyle: TextStyle(color: Colors.white),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_play),
          label: 'My Playlists',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          label: 'Hot Releases',
        ),
      ],
    );
  }

  void ontap(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyPlayListPage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LatestReleasesPage()));
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }
}
