import 'package:favmusic/cubits/cubit/drawer_cubit.dart';
import 'package:favmusic/screens/login_page.dart';
import 'package:favmusic/screens/see_all_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomEndDrawer extends StatelessWidget {
  const CustomEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerCubit()..initPage(),
      child: BlocBuilder<DrawerCubit, DrawerState>(
        builder: (context, state) {
          if (state is DrawerIdle) {
            return Drawer(
              backgroundColor: const Color.fromARGB(255, 48, 48, 48),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 48,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildUserInfo(state.userName),
                    _buildSections(context),
                    _buildLogoutButton(context),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Padding _buildUserInfo(String username) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _getCircularImage('profile_pic.jpeg', 48),
          const SizedBox(width: 16),
          Text(username,
              style: const TextStyle(color: Colors.white, fontSize: 24)),
        ],
      ),
    );
  }

  Widget _buildSections(BuildContext context) {
    Divider divider = const Divider(color: Colors.black);
    return Column(children: [
      divider,
      _buildSection(
        "Popular Today",
        "Today’s Top Tunes!",
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeeAllPage(
              category: 'Popular Today',
            ),
          ),
        ),
      ),
      divider,
      _buildSection(
        "My Saved Podcast",
        "Your Podcast Collection",
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeeAllPage(
              category: 'My Saved Episodes',
            ),
          ),
        ),
      ),
      divider,
      _buildSection(
        "My Saved Playlist",
        "Your Favorite Picks",
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeeAllPage(
              category: 'My Saved Tracks',
            ),
          ),
        ),
      ),
      divider,
    ]);
  }

  Padding _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<DrawerCubit>(context).logout();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Log out",
                style: TextStyle(color: Colors.white, fontSize: 24)),
            Icon(Icons.logout, color: Colors.red, size: 32)
          ],
        ),
      ),
    );
  }

  ListTile _buildSection(String title, String subtitle, Function() onTap) {
    return ListTile(
      onTap: onTap,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      leading: const Icon(
        Icons.music_note,
        color: Colors.white,
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
            color: Color.fromARGB(255, 151, 144, 144), fontSize: 12),
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
}
