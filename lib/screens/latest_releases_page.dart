import 'package:favmusic/components/album_widget.dart';
import 'package:favmusic/components/custom_app_bar.dart';
import 'package:favmusic/components/loading_screen.dart';
import 'package:favmusic/components/play_list_widget.dart';
import 'package:favmusic/components/track_widget.dart';
import 'package:favmusic/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:favmusic/cubits/play_list_cubit/tracks_cubit.dart';
import 'package:favmusic/screens/home_page.dart';
import 'package:favmusic/service/spotify_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_navigator.dart';

class LatestReleasesPage extends StatelessWidget {
  LatestReleasesPage({super.key});

  final HomePageCubit _cubit = HomePageCubit()..initializePage();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is HomePageIdle) {
            return Scaffold(
              appBar: CustomAppBar(displayName: state.displayName),
              bottomNavigationBar: MyBottomNavigationBar(),
              body: ListView(
                children: [
                  ...state.latestReleases!.map(
                    (e) {
                      return 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                         Card(child: AlbumWidget(imageurl: e.imageUrl, albumName:e.albumName, albumLink: e.albumLink, artistName: e.artistName, releaseDate: e.releaseDate, trackCount: e.trackCount,)),
                      );
                    },
                  ).toList(),
                ],
              ),
            );
          }
          return LoadinScreen();
        },
      ),
    );
  }
}
