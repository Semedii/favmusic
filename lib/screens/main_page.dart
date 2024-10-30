import 'package:favmusic/cubits/cubit/bottom_navigation_bar_cubit.dart';
import 'package:favmusic/screens/home_page.dart';
import 'package:favmusic/screens/latest_releases_page.dart';
import 'package:favmusic/screens/my_playlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationBarCubit(),
      child: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
        builder: (context, state) {
          final index = (state as BottomNavigationBarInitial).index;
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 48, 48, 48),
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getCircularImage('logo.jpeg', 24),
                  const SizedBox(width: 4),
                  const Text(
                    "FavMusic",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _getCircularImage('profile_pic.jpeg', 48),
                ),
              ],
            ),
            bottomNavigationBar: _buildBottomNavigationBar(context, index),
            body: _getBody(index),
          );
        },
      ),
    );
  }

  ClipOval _getCircularImage(String imageName, double size) {
    return ClipOval(
      child: Image.asset(
        'assets/images/$imageName',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(
      BuildContext context, int index) {
    return BottomNavigationBar(
      useLegacyColorScheme: false,
      backgroundColor: Colors.black,
      selectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedLabelStyle: const TextStyle(color: Colors.white70),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      onTap: (newIndex) => BlocProvider.of<BottomNavigationBarCubit>(context)
          .onIndexChange(newIndex),
      items: _buildBottomNavigationBarItems(),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.trending_up,
        ),
        label: "Trending",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.save),
        label: "My Playlist",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Me",
      ),
    ];
  }

  Widget _getBody(int index) {
    var bodies = [
      HomePage(),
      LatestReleasesPage(),
      MyPlayListPage(),
      MyPlayListPage(),
    ];
    return bodies[index];
  }
}