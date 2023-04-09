import 'package:bloc/bloc.dart';
import 'package:favmusic/service/spotify_api.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

void authenticate() async {
   await FlutterConfig.loadEnvVariables();
   final clientId = FlutterConfig.get('SPOTIFY_CLIENT_ID');
  final redirectUri =  'waryaa:/';
  final result = await FlutterWebAuth.authenticate(
    url:
        "https://accounts.spotify.com/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=user-read-currently-playing&response_type=token&state=123",
    callbackUrlScheme: 'waryaa'
  );

  final token = Uri.parse(result);
  String at = token.fragment;
  at = "http://website/index.html?$at"; // Just for easy persing
  var accesstoken = Uri.parse(at).queryParameters['access_token'];
 final profileData = await SpotifyApi.getSpotifyProfile(accesstoken);
final displayName = profileData['display_name'];
  emit(LoginSuccess(display_name: displayName));
}
}
