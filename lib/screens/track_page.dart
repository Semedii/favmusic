import 'package:favmusic/components/loading_screen.dart';
import 'package:favmusic/cubits/play_list_cubit/tracks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/track_widget.dart';

class TracksPage extends StatelessWidget {
  TracksPage(
      {required this.link, required this.isalbum, this.imageUrl, super.key});
  final String link;
  final bool isalbum;
  final String? imageUrl;
  final TrackCubit _cubit = TrackCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<TrackCubit, TrackState>(
        builder: (context, state) {
          if (state is TrackInitial) {
            BlocProvider.of<TrackCubit>(context).initializePage(link, isalbum);
          }
          if (state is TrackIdle) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 30, 30, 30),
                ),
                body: TrackWidget(
                  imageUrl: imageUrl,
                  trackList: state.track,
                  selectedIndex: state.selectedIndex,
                  onTap: (index) => BlocProvider.of<TrackCubit>(context)
                      .play(state.track[index].trackuri, index),
                ));
          }
          return const LoadinScreen();
        },
      ),
    );
  }
}
