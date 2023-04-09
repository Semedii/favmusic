import 'package:flutter/material.dart';

class MusicWidget extends StatelessWidget {
  const MusicWidget(this.imageurl, this.name, {super.key});

  final String imageurl;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.brown, width: 4),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(imageurl).image,
          )),
      child: Column(
        children: [
          const Spacer(),
          Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
