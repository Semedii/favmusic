import 'package:flutter/material.dart';

class CustomEndDrawer extends StatelessWidget {
  const CustomEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 48,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildUserInfo(),
            _buildSections(),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Padding _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _getCircularImage('profile_pic.jpeg', 48),
          const SizedBox(width: 16),
          Text("Semedy", style: TextStyle(color: Colors.white, fontSize: 24)),
        ],
      ),
    );
  }

  Widget _buildSections() {
    Divider divider = const Divider(color: Colors.black);
    return Column(children: [
      divider,
      _buildSection("Popular Today", "Today’s Top Tunes!"),
      divider,
      _buildSection("My Saved Podcast", "Your Podcast Collection"),
      divider,
      _buildSection("My Saved Playlist", "Your Favorite Picks"),
      divider,
    ]);
  }

  Padding _buildLogoutButton() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Log out", style: TextStyle(color: Colors.white, fontSize: 24)),
          Icon(Icons.logout, color: Colors.red, size: 32)
        ],
      ),
    );
  }

  ListTile _buildSection(String title, String subtitle) {
    return ListTile(
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
