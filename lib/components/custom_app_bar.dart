import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/user_cubit/user_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({required this.displayName, super.key});
  final String displayName;
  @override
  Size get preferredSize => const Size(300, 100);
  final UserCubit _cubit = UserCubit()..initializePage();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserIdle) {
            return AppBar(
              backgroundColor: const Color.fromARGB(255, 30, 30, 30),
              elevation: 0,
              flexibleSpace: Center(
                  child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CircleAvatar(
                      radius: 40,
                      //backgroundImage: Image.asset("assets/images/lp_image.jpeg").image,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getGreeting(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 28),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          state.displayName,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ]),
                ],
              )),
            );
          }
          return Container(
            color: const Color.fromARGB(255, 30, 30, 30),
          );
        },
      ),
    );
  }

  String _getGreeting() {
    if (DateTime.now().hour >= 1 && DateTime.now().hour < 12) {
      return "Good Morning";
    }
    if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
      return "Good Afternoon";
    }
    if (DateTime.now().hour >= 18 && DateTime.now().hour < 22) {
      return "Good Evening";
    }
    if (DateTime.now().hour >= 22) {
      return "Good Night";
    }
    return "Hello";
  }
}
