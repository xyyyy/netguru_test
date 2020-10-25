import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_test/theme/bloc/theme_event.dart';
import 'package:netguru_test/theme/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {


  bool _darkTheme;

  ThemeBloc(ThemeState initialState) : super(initialState){
    _darkTheme = initialState.dark;
  }


  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if(event is ChangeThemeEvent){
      yield* _mapChangeThemeEventToState();
    }
  }



  Stream<ThemeState> _mapChangeThemeEventToState() async* {
    _darkTheme = !_darkTheme;
    yield NewThemeState(_darkTheme);
  }




}

