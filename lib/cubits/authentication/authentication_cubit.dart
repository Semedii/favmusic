import 'package:bloc/bloc.dart';
import 'package:favmusic/services/preferences_service.dart';
import 'package:favmusic/services/spotify_service.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  
  checkIfUserLoggedIn()async{
   String? accessToken =  await PreferencesService.getAccessToken();
   bool isUserLoggedIn;
   if(accessToken!=null){
    isUserLoggedIn = await SpotifyService().isTokenValid(accessToken);
     emit((state as AuthenticationInitial).copyWith(isUserLoggedIn: isUserLoggedIn));
   }else{
     emit((state as AuthenticationInitial).copyWith(isUserLoggedIn: false));
   }
  
  }
}
