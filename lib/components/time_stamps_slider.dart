import 'package:flutter/material.dart';

class TimeStampsSlider extends StatelessWidget {
  const TimeStampsSlider({this.isHideStamps=false, super.key});

  final bool isHideStamps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              trackHeight: 2,
              thumbColor: Colors.white,
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.grey,
            ),
            child: Slider(
              value: 0.4, // Example value, replace with actual progress
              onChanged: (value) {
                // Implement seeking functionality
              },
            ),
          ),
        ),
       if(!isHideStamps) Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1:47',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              Text(
                '-2:52',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
