import 'package:favmusic/components/custom_app_bar.dart';
import 'package:favmusic/cubits/see_all/see_all_cubit.dart';
import 'package:favmusic/model/track.dart';
import 'package:favmusic/services/SpotifyService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeeAllPage extends StatelessWidget {
  SeeAllPage({required this.category, super.key});

  final String category;
  final SpotifyService _spotifyService = SpotifyService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: CustomAppBar(
              title: Text(
            category,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
        body: BlocProvider(
          create: (context) =>
              SeeAllCubit(_spotifyService)..fetchTracks(category),
          child:
              BlocBuilder<SeeAllCubit, SeeAllState>(builder: _mapStateToWidget),
        ));
  }

  Widget _mapStateToWidget(BuildContext context, SeeAllState state) {
    if (state is SeeAllInitial) {
      BlocProvider.of<SeeAllCubit>(context).fetchTracks(category);
    } else if (state is SeeAllIdle) {
      return _buildTrackList(state);
    }
    return const Center(child: CircularProgressIndicator());
  }

  ListView _buildTrackList(SeeAllIdle state) {
    return ListView.builder(
      itemCount: state.tracks?.length,
      itemBuilder: (context, index) {
        Track? track = state.tracks?[index];
        return track != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Container(
                    height: 70,
                    decoration: _buildBoxDecoration(),
                    child: Row(
                      children: [
                        _buildSongCover(track),
                        _buildSongAndArtistName(track),
                        const Spacer(),
                        _buildPlayButton(context, state, track, index)
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 84, 95, 95),
          Color.fromARGB(255, 102, 94, 94)
        ],
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }

  Container _buildSongCover(Track track) {
    return Container(
      height: 65,
      width: 70,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(track.imageUrl ?? ""), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12)),
    );
  }

  Padding _buildSongAndArtistName(Track track) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 12, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSongTitle(track.name),
          const SizedBox(height: 8),
          _buildArtistName(track.artistName)
        ],
      ),
    );
  }

  Padding _buildPlayButton(
    BuildContext context,
    SeeAllIdle state,
    Track track,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          disabledColor: Colors.grey,
          icon: state.playingIndex == index
              ? const Icon(Icons.pause, color: Colors.white)
              : const Icon(Icons.play_arrow, color: Colors.white),
          iconSize: 24,
          onPressed: state.isUpdating
              ? null
              : () {
                  BlocProvider.of<SeeAllCubit>(context).playTrack(track, index);
                }),
    );
  }

  Widget _buildSongTitle(String songTitle) {
    return SizedBox(
      width: 250,
      child: Text(
        softWrap: true,
        songTitle,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
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
