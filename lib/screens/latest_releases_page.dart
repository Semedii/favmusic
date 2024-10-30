import 'package:favmusic/components/album_widget.dart';
import 'package:favmusic/components/custom_app_bar.dart';
import 'package:favmusic/components/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/user_cubit/user_cubit.dart';
class LatestReleasesPage extends StatelessWidget {
  LatestReleasesPage({super.key});

  final UserCubit _cubit = UserCubit()..initializePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(displayName: "displayName"),
        body: BlocProvider(
            create: (context) => _cubit,
            child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
              if (state is UserIdle) {
                return ListView(
                  children: [
                    ...state.latestReleases!.map(
                      (e) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              child: AlbumWidget(
                            imageurl: e.imageUrl,
                            albumName: e.albumName,
                            albumLink: e.albumLink,
                            artistName: e.artistName,
                            releaseDate: e.releaseDate,
                            trackCount: e.trackCount,
                          )),
                        );
                      },
                    ).toList(),
                  ],
                );
              }
              return const LoadinScreen();
            })));
  }
}
