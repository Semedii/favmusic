import 'package:favmusic/components/custom_app_bar.dart';
import 'package:favmusic/components/time_stamps_slider.dart';
import 'package:favmusic/cubits/play/play_cubit.dart';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/SpotifyService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PlayPage extends StatelessWidget {
  PlayPage({required this.track, super.key});

  final Track track;

  final SpotifyService _spotifyService = SpotifyService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      appBar: const PreferredSize(preferredSize:  Size(double.infinity, 70),
      child: CustomAppBar(),
      ),
      body: BlocProvider(
        create: (context) => PlayCubit(_spotifyService),
        child: BlocBuilder<PlayCubit, PlayState>(
          builder: (context, state) {
            state as PlayInitial;
            return Column(
              children: [
                _buildSongCover(context, track.imageUrl),
                const SizedBox(height: 20.0),
                _buildSongTitle(track.name),
                const SizedBox(height: 8.0),
                _buildArtistName(track.artistName),
                const SizedBox(height: 30),
                _buildPlayControls(context, state.isPlaying),
                const SizedBox(height: 20),
              //  const TimeStampsSlider(),
              ],
            );
          },
        ),
      ),
    );
  }

  Row _buildPlayControls(BuildContext context, bool isPlaying) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // IconButton(
        //   icon: const Icon(Icons.skip_previous, color: Colors.white),
        //   iconSize: 36,
        //   onPressed: () {
        //     // Implement previous song functionality
        //   },
        // ),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: isPlaying
                ? const Icon(Icons.pause, color: Colors.black)
                : const Icon(Icons.play_arrow, color: Colors.black),
            iconSize:42,
            onPressed: () {
              BlocProvider.of<PlayCubit>(context).playTrack(track);
            },
          ),
        ),
        const SizedBox(width: 20),
        // IconButton(
        //   icon: const Icon(Icons.skip_next, color: Colors.white),
        //   iconSize: 36,
        //   onPressed: () {
        //     // Implement next song functionality
        //   },
        // ),
      ],
    );
  }

  Widget _buildSongCover(BuildContext context, String? imageUrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * .5,
      width: MediaQuery.of(context).size.width,
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
      style: const TextStyle(color: Colors.white, fontSize: 24),
      overflow: TextOverflow.ellipsis,
    );
  }

  Text _buildArtistName(String artistName) {
    return Text(
      artistName,
      style: const TextStyle(
        color: Color(0xFFCCCCCC),
        fontSize: 16,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
