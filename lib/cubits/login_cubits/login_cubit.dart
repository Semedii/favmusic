import 'package:bloc/bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void authenticate() async {
    await FlutterConfig.loadEnvVariables();
    final clientId = FlutterConfig.get('SPOTIFY_CLIENT_ID');
    final redirectUri = 'waryaa:/';
    final result = await FlutterWebAuth.authenticate(
        url:
            "https://accounts.spotify.com/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=user-read-private%20user-read-email%20user-read-playback-state%20user-modify-playback-state&response_type=token&state=123",
        callbackUrlScheme: 'waryaa');

    final token = Uri.parse(result);
    String at = token.fragment;
    at = "http://website/index.html?$at";
    var accessToken = Uri.parse(at).queryParameters['access_token'];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken!);
    emit(LoginSuccess());
  }
}
