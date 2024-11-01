part of 'drawer_cubit.dart';

 class DrawerState {}

class DrawerInitial extends DrawerState {
}

class DrawerIdle extends DrawerState{
  final String userName;

  DrawerIdle({required this.userName});
}
