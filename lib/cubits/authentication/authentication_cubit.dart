import 'package:bloc/bloc.dart';
import 'package:favmusic/services/PreferencesService.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  
  checkIfUserLoggedIn()async{
   String? accesToken =  await PreferencesService.getAccessToken();
   emit((state as AuthenticationInitial).copyWith(isUserLoggedIn: accesToken!=null));
  }
}
