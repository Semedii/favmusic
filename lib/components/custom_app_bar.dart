import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getCircularImage('logo.png', 42),
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
