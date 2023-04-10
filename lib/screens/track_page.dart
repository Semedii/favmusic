import 'package:favmusic/components/loading_screen.dart';
import 'package:favmusic/cubits/play_list_cubit/tracks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TracksPage extends StatelessWidget {
  TracksPage({required this.link, super.key});
  final String link;

  final TrackCubit _cubit = TrackCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<TrackCubit, TrackState>(
        builder: (context, state) {
          print(state);
          if (state is TrackInitial) {
            BlocProvider.of<TrackCubit>(context).initializePage(link);
          }
          if (state is TrackIdle) {
            return Scaffold(
              appBar: AppBar(),
              body: ListView(
                children: [
                  ...state.track.map((e) => ListTile(
                      title: Text(e.name),
                      subtitle: Text(e.artistName),
                      trailing:
                          _getPlayIcon(context, state.isPlaying, e.trackuri)))
                ],
              ),
            );
          }
          return LoadinScreen();
        },
      ),
    );
  }

  _getPlayIcon(BuildContext context, bool isPlaying, String uri) {
    if (isPlaying) {
      return IconButton(
          onPressed: () {
            BlocProvider.of<TrackCubit>(context).play(uri);
          },
          icon: const Icon(Icons.pause));
    }
    return IconButton(
        onPressed: () {
          BlocProvider.of<TrackCubit>(context).play(uri);
        },
        icon: const Icon(Icons.play_arrow));
  }
}
