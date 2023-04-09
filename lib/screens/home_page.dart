import 'package:favmusic/components/loading_screen.dart';
import 'package:favmusic/components/music_carousel.dart';
import 'package:favmusic/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:favmusic/data/favourite_music.list.dart';
import 'package:favmusic/data/latest_music_list.dart';
import 'package:favmusic/data/trending_music_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../components/custom_app_bar.dart';

class HomePage extends StatelessWidget {
   HomePage( {required this.displayName, super.key});
  final String displayName;
  final HomePageCubit _cubit = HomePageCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              DisplayName: displayName,
            ),
            body: Column(children: [
              _getLatestMusic(context),
              _getTrendingMusic(),
              _getfavMusic()
            ]),
          );
        },
      ),
    );
  }

  _getTrendingMusic() {
    return MusicCarousel(
        seconds: 5,
        items: TrendingMusicList.trendingMusicList,
        title: "trending",
        icon: Icons.trending_up_rounded);
  }

  _getfavMusic() {
    return MusicCarousel(
        seconds: 4,
        items: FavouriteMusicList.favouriteMusicList,
        title: "favourite",
        icon: Icons.favorite);
  }

  _getLatestMusic(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push("/LatestMusic"),
      child: MusicCarousel(
        seconds: 3,
        items: LatestMusicList.latestMusicList,
        title: "latest",
        icon: Icons.av_timer,
      ),
    );
  }
}
