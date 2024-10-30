import 'package:favmusic/components/custom_app_bar.dart';
import 'package:favmusic/components/loading_screen.dart';
import 'package:favmusic/components/play_list_widget.dart';
import 'package:favmusic/cubits/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyPlayListPage extends StatelessWidget {
  MyPlayListPage({super.key});

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
