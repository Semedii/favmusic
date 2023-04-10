import 'package:flutter/material.dart';

class PlayListWidget extends StatelessWidget {
  const PlayListWidget(this.imageurl, this.name, {super.key});

  final String? imageurl;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: imageurl != null
                ? Image.network(imageurl!).image
                : const AssetImage('assets/images/no_cover.jpeg'),
          )),
      child: Column(
        children: [
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
