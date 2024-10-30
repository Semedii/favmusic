import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/SpotifyService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/homepage_cubit/homepage_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomepageCubit _cubit = HomepageCubit(SpotifyService())
    ..initializePage();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child:
          BlocBuilder<HomepageCubit, HomepageState>(builder: (context, state) {
        if (state is HomepageIdle) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildSongSection(
                    "Popular Today", state.recommendedTracks ?? []),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }),
    );
  }

  Column _buildSongSection(String sectionTitle, List<Track> tracks) {
    return Column(
      children: [
        Row(
          children: [
            _buildSectionTitle(sectionTitle),
            const Spacer(),
            _buildSeeAll(),
          ],
        ),
        SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                Track track = tracks[index];
                return _buildSongItem(track);
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

  Row _buildSeeAll() {
    return Row(
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
    );
  }

  Padding _buildSongItem(Track track) {
    return Padding(
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
