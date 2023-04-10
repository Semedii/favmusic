import 'package:favmusic/components/loading_screen.dart';
import 'package:favmusic/components/my_button.dart';
import 'package:favmusic/components/my_text_field.dart';
import 'package:favmusic/cubits/login_cubits/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginCubit _loginCubit = LoginCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginCubit,
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginInitial) {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    _getTitle(),
                    _getLogo(),
                    SizedBox(height: 20.0),
                    _getEmailField(),
                    SizedBox(height: 10.0),
                    _getPassworfField(),
                    SizedBox(height: 10.0),
                    _getLoginButton(),
                    SizedBox(height: 10.0),
                    _getSpotifyButton(context),
                    Spacer(),
                    _getSignupButton()
                  ],
                ),
              ),
            );
          } else if (state is LoginSuccess) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              GoRouter.of(context).pushReplacement("/HomePage");
            });
          }

          return const Center(child: LoadinScreen());
        },
      ),
    );
  }

  _getTitle() {
    return const Text(
      "Welcome to FavMusic",
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
        letterSpacing: 1.5,
      ),
    );
  }

  _getLogo() {
    return Image.asset(
      'assets/images/logo.jpeg',
    );
  }

  _getEmailField() {
    return const MyTextField(
      labelText: "Email",
      prefixIconData: Icons.email,
    );
  }

  _getPassworfField() {
    return const MyTextField(
      labelText: "Password",
      prefixIconData: Icons.lock,
    );
  }

  _getLoginButton() {
    return MyButton(
        onTap: () {
          throw UnimplementedError();
        },
        text: "Log In");
  }

  _getSpotifyButton(BuildContext context) {
    return MyButton(
      text: 'Login with Spotify',
      color: const Color.fromARGB(255, 49, 51, 50),
      onTap: () {
        BlocProvider.of<LoginCubit>(context).authenticate();
      },
    );
  }

  _getSignupButton() {
    return TextButton(
      onPressed: () {
        throw UnimplementedError();
      },
      child: Text(
        "Don't have an account? Sign up",
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16,
        ),
      ),
    );
  }
}
