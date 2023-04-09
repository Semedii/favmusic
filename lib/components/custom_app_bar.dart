import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size(300, 150);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 63, 62, 62),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      elevation: 0,
      flexibleSpace: Center(
          child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: Image.asset("assets/images/lp_image.jpeg").image,
            ),
          ),
          const SizedBox(width: 16),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              "Good Morning",
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Iqra",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ]),
        ],
      )),
    );
  }
}
