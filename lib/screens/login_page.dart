import 'package:favmusic/components/loading_screen.dart';
import 'package:favmusic/components/my_button.dart';
import 'package:favmusic/cubits/login_cubits/login_cubit.dart';
import 'package:favmusic/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginCubit _loginCubit = LoginCubit(AuthenticationService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 81, 83, 84), Color.fromARGB(255, 0, 0, 0)],
        )),
        child: BlocProvider(
          create: (context) => _loginCubit,
          child:
              BlocBuilder<LoginCubit, LoginState>(builder: _mapStateToWidget),
        ),
      ),
    );
  }

  Widget _mapStateToWidget(BuildContext context, LoginState state) {
    if (state is LoginInitial) {
      return _buildLoginContent(context);
    } else if (state is LoginSuccess) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).pushReplacement("/Homepage");
      });
    }

    return const Center(child: LoadinScreen());
  }

  Padding _buildLoginContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120),
      child: Column(
        children: [
          _getTitle(),
          _getLogo(),
          _getSpotifyButton(context),
          Spacer(),
          Image.asset("assets/images/bottom-logo.png")
        ],
      ),
    );
  }

  Widget _getTitle() {
    return Text(
      "Welcome to FavMusic",
      style: _getTitleTextStyle(),
    );
  }

  TextStyle _getTitleTextStyle() {
    return const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      letterSpacing: 1.5,
    );
  }

  Widget _getLogo() {
    return Image.asset(
      'assets/images/logo.png',
    );
  }

  Widget _getSpotifyButton(BuildContext context) {
    return MyButton(
        text: 'Login with Spotify',
        color: const Color.fromARGB(255, 99, 101, 100),
        onTap: BlocProvider.of<LoginCubit>(context).authenticate);
  }
}
