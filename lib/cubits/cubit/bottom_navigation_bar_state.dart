part of 'bottom_navigation_bar_cubit.dart';

@immutable
class BottomNavigationBarState {}

class BottomNavigationBarInitial extends BottomNavigationBarState {
  final int index;

  BottomNavigationBarInitial({this.index = 1});

  BottomNavigationBarInitial copyWith({int? index}) {
    return BottomNavigationBarInitial(index: index ?? this.index);
  }
}
