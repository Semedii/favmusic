import 'package:bloc/bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void launchSpotifyAuthUrl() async {
    await FlutterConfig.loadEnvVariables();
   final clientId = FlutterConfig.get('SPOTIFY_CLIENT_ID');
  final redirectUri = 'seemed.com';
  final scopes = ['user-read-email', 'user-read-private'];

  final url =
      'https://accounts.spotify.com/authorize?client_id=$clientId&response_type=code&redirect_uri=$redirectUri&scope=${scopes.join('%20')}';

  if (await canLaunch(url)) {
    emit(LoginLoading());
    await Future.delayed(Duration(seconds: 2));
    await launch(url);
    emit(LoginInitial());
  } else {
    throw 'Could not launch $url';
  }
}
}
