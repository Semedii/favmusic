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

class MyPlayListPage extends StatelessWidget {
  MyPlayListPage({super.key});

  final HomePageCubit _cubit = HomePageCubit()..initializePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(displayName: "displayName"),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
          if (state is HomePageIdle) {
            return ListView(
              children: [
                ...state.playlist!.map(
                  (e) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          child: PlayListWidget(
                              imageurl: e.image,
                              name: e.name,
                              playListLink: e.link)),
                    );
                  },
                ).toList(),
              ],
            );
          }
          return const LoadinScreen();
        }),
      ),
    );
  }
}
