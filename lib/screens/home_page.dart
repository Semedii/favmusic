import 'package:favmusic/components/custom_app_bar.dart';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/SpotifyService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubits/homepage_cubit/homepage_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomepageCubit _cubit = HomepageCubit(SpotifyService())
    ..initializePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      appBar: const PreferredSize(preferredSize:  Size(double.infinity, 70),
      child: CustomAppBar(),
      ),
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocBuilder<HomepageCubit, HomepageState>(
            builder: (context, state) {
          if (state is HomepageIdle) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildSongSection(
                      context,
                      "Popular Today",
                      state.recommendedTracks ?? [],
                    ),
                    if (state.usersSavedEpisodes != null &&
                        state.usersSavedEpisodes!.isNotEmpty) ...{
                      _buildSongSection(
                        context,
                        "My Saved Episodes",
                        state.usersSavedEpisodes ?? [],
                      ),
                    },
                    if (state.usersSavedTracks != null &&
                        state.usersSavedTracks!.isNotEmpty) ...{
                      _buildSongSection(
                        context,
                        "My Saved Tracks",
                        state.usersSavedTracks!,
                      ),
                    }
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }

  Column _buildSongSection(
    BuildContext context,
    String sectionTitle,
    List<Track> tracks,
  ) {
    return Column(
      children: [
        Row(
          children: [
            _buildSectionTitle(sectionTitle),
            const Spacer(),
            _buildSeeAll(context, sectionTitle),
          ],
        ),
        SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                Track track = tracks[index];
                return _buildSongItem(context, track);
              },
            )),
      ],
    );
  }

  Text _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSeeAll(BuildContext context, String category) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push("/SeeAllPage", extra: category),
      child: Row(
        children: [
          Text(
            "See all",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[400], size: 18),
        ],
      ),
    );
  }

  GestureDetector _buildSongItem(BuildContext context, Track track) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push("/PlayPage", extra: track),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSongCover(track.imageUrl),
              const SizedBox(height: 8),
              _buildSongTitle(track.name),
              _buildArtistName(track.artistName),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSongCover(String? imageUrl) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl ?? "",
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;

            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return const Center(child: Icon(Icons.error));
          },
        ),
      ),
    );
  }

  Text _buildSongTitle(String songTitle) {
    return Text(
      songTitle,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      overflow: TextOverflow.ellipsis,
    );
  }

  Text _buildArtistName(String artistName) {
    return Text(
      artistName,
      style: const TextStyle(
        color: Color(0xFFA0A0A0),
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
