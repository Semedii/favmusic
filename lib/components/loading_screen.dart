import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadinScreen extends StatelessWidget {
  const LoadinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.hexagonDots (
            color: Colors.black,
            size: 100,
          ),
      ),
    );
  }
}