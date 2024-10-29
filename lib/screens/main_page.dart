import 'package:favmusic/cubits/cubit/bottom_navigation_bar_cubit.dart';
import 'package:favmusic/screens/home_page.dart';
import 'package:favmusic/screens/latest_releases_page.dart';
import 'package:favmusic/screens/my_playlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bodies = [
      HomePage(),
      LatestReleasesPage(),
      MyPlayListPage(),
    ];
    return BlocProvider(
      create: (context) => BottomNavigationBarCubit(),
      child: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
        builder: (context, state) {
          state as BottomNavigationBarInitial;
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.index,
              onTap: BlocProvider.of<BottomNavigationBarCubit>(context).onIndexChange,
              //selectedItemColor: AppColors.black,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: "Home",
                ),
                // homeState is HomeStateLoaded && homeState.numberActiveOrder > 0
                //     ? _getActiveOrdersWithBadge(homeState, localizations)
                //     : _getActiveOrdersWithoutBadge(localizations),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.music_note),
                  label: "Hot Releases",
                )
              ],
            ),
            body: bodies[state.index],
          );
        },
      ),
    );
  }

  // BottomNavigationBarItem _getActiveOrdersWithoutBadge(
  //   AppLocalizations localizations,
  // ) {
  //   return BottomNavigationBarItem(
  //     icon: const Icon(Icons.shopify_sharp),
  //     label: localizations.activeOrders,
  //   );
  // }

  // BottomNavigationBarItem _getActiveOrdersWithBadge(
  //   HomeStateLoaded homeState,
  //   AppLocalizations localizations,
  // ) {
  //   return BottomNavigationBarItem(
  //     icon: Badge(
  //         label: Text(homeState.numberActiveOrder.toString()),
  //         child: const Icon(Icons.shopify_sharp)),
  //     label: localizations.activeOrders,
  //   );
  // }
}
