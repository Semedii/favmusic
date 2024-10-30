import 'package:favmusic/cubits/authentication/authentication_cubit.dart';
import 'package:favmusic/screens/home_page.dart';
import 'package:favmusic/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit()..checkIfUserLoggedIn(),
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          state as AuthenticationInitial;
          if(state.isUserLoggedIn==null || state.isUserLoggedIn==false){
            return LoginPage();
          }else {
            return HomePage();
          }
        },
      ),
    );
  }
}
