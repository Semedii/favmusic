import 'package:favmusic/components/loading_screen.dart';
import 'package:favmusic/components/play_list_widget.dart';
import 'package:favmusic/components/track_widget.dart';
import 'package:favmusic/cubits/play_list_cubit/play_list_track_cubit.dart';
import 'package:favmusic/service/spotify_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_navigator.dart';

class MyPlayListPage extends StatelessWidget {
  MyPlayListPage({super.key});

  final PlayListTrackCubit _cubit = PlayListTrackCubit()..initializePage();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<PlayListTrackCubit, PlayListTrackState>(
        builder: (context, state) {
          if (state is PlayListTrackIdle) {
            return Scaffold(
              bottomNavigationBar: MyBottomNavigationBar(),
              body: ListView.builder(
                  itemCount: state.track.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: _cubit.play,
                      child: PlaylistTracks(
                        artistName: state.track[index].artistName,
                        name: state.track[index].name,
                        imageUrl: state.track[index].imageUrl,
                      ),
                    );
                  }),
            );
          }
          return LoadinScreen();
        },
      ),
    );
  }
}
