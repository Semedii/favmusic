import 'package:favmusic/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({required this.category, super.key});

  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      appBar: const PreferredSize(preferredSize:  Size(double.infinity, 70),
      child: CustomAppBar(),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 70, color: Colors.red,),
          );
        },
      )
    );
  }

}