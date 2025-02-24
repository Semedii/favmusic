import 'package:bloc/bloc.dart';
import 'package:favmusic/services/authentication_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationService _authService;

  LoginCubit(this._authService) : super(LoginInitial());

  void authenticate() async {
    final accessToken = await _authService.authenticate();

    if (accessToken != null) {
      await _authService.saveToken(accessToken);
      await _authService.saveUsername(accessToken);
      emit(LoginSuccess());
    } else {
      // ignore: avoid_print
      print('Access token not found.');
    }
  }
}
