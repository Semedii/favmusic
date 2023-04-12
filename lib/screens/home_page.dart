import 'package:favmusic/components/carousels/album_carousel.dart';
import 'package:favmusic/components/loading_screen.dart';
import 'package:favmusic/components/carousels/play_list_carousel.dart';
import 'package:favmusic/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:favmusic/model/album.dart';
import 'package:favmusic/screens/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/custom_app_bar.dart';
import '../model/play_lists.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomePageCubit _cubit = HomePageCubit()..initializePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 50, 50),
      appBar: CustomAppBar(
        displayName: "displayName",
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
          if (state is HomePageIdle) {
            return Column(children: [
              _getLatestRelease(state.latestReleases!),
              const SizedBox(height: 10),
              _getPlayLists(state.playlist!),
            ]);
          }
          return const Center(
            child: LoadinScreen(),
          );
        }),
      ),
    );
  }

  _getPlayLists(List<Playlist> playLists) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PlayListCarousel(
          seconds: 5,
          items: playLists,
          title: "My PlayList",
          icon: Icons.trending_up_rounded),
    );
  }

  _getLatestRelease(List<Album> albums) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlbumCarousel(
          items: albums,
          title: "Latest Releases",
          icon: Icons.trending_up_rounded),
    );
  }
}
