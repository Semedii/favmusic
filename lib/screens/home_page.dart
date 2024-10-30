import 'package:favmusic/components/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/user_cubit/user_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final UserCubit _cubit = UserCubit()..initializePage();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserIdle) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildSongSection("Popular Today"),
              ],
            ),
          );
        }
        return const Center(
          child: LoadinScreen(),
        );
      }),
    );
  }

  Column _buildSongSection(String sectionTitle) {
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildSongItem("Happier Than Ever", "Billie Eilish"),
            ],
          ),
        ),
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

  Padding _buildSongItem(String songTitle, String artistName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSongCover(),
          const SizedBox(height: 8),
          _buildSongTitle(songTitle),
          _buildArtistName(artistName),
        ],
      ),
    );
  }

  Container _buildSongCover() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Text _buildSongTitle(String songTitle) {
    return Text(
      songTitle,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  Text _buildArtistName(String artistName) {
    return Text(
      artistName,
      style: const TextStyle(
        color: Color(0xFFA0A0A0),
      ),
    );
  }
}
