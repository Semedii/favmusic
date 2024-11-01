import 'package:bloc/bloc.dart';
import 'package:favmusic/services/preferences_service.dart';


part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerInitial());

  initPage()async{
    String? username = await PreferencesService.getUserName();
    emit(DrawerIdle(userName: username??""));
  }

  logout()async {
    await PreferencesService.clear();
  }
}
