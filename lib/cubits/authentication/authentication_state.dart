part of 'authentication_cubit.dart';

class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {
  final bool? isUserLoggedIn;

  AuthenticationInitial({this.isUserLoggedIn});

  AuthenticationInitial copyWith({bool? isUserLoggedIn}) {
    return AuthenticationInitial(
      isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
    );
  }
}
