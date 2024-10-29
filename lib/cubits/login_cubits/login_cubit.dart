import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void authenticate() async {
  final clientId = dotenv.env['SPOTIFY_CLIENT_ID'];
  final redirectUri = dotenv.env['REDIRECT_URI'];

  // Ensure clientId and redirectUri are not null
  if (clientId == null || redirectUri == null) {
    print('Client ID or Redirect URI is missing.');
    return;
  }

  try {
    print("asdsadas 1");
    final result = await FlutterWebAuth.authenticate(
      url: "https://accounts.spotify.com/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=user-read-private%20user-read-email%20user-read-playback-state%20user-modify-playback-state&response_type=token&state=123",
      callbackUrlScheme: 'waryaa',
    );
print("asdsadas 2");
    // Parse the result to extract the access token
    final token = Uri.parse(result);
    String fragment = token.fragment; // Get the fragment part directly
    var accessToken = Uri.parse('http://website/index.html?$fragment').queryParameters['access_token'];

    // Check if accessToken is not null before saving
    
    if (accessToken != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);
      emit(LoginSuccess()); // Call your success event
    } else {
      print('Access token not found in the result.');
    }
  } catch (e) {
    print("asdsadas 3");
    print('Authentication error: $e'); // Handle any errors
  }
}}