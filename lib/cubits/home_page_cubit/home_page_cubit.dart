import 'package:bloc/bloc.dart';
import 'package:favmusic/service/spotify_api.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());
}
