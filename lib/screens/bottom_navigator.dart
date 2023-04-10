import 'package:favmusic/screens/home_page.dart';
import 'package:favmusic/screens/latest_releases_page.dart';
import 'package:flutter/material.dart';

import 'my_playlist_page.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar();

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (s){
        ontap(s);
      },
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[500],
      backgroundColor: const Color.fromARGB(255, 50, 50, 50),
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
      case 0: // My Playlists
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyPlayListPage()));
        break;
      case 1: // Home
         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 2: // Hot Releases
        // Navigate to Hot Releases page
       // Navigator.push(context, MaterialPageRoute(builder: (context) => LatestReleasesPage()));
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }
}
