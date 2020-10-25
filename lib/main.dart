import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_test/theme/bloc/theme_bloc.dart';
import 'package:netguru_test/theme/bloc/theme_state.dart';
import 'package:netguru_test/widgets/home_page_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final ThemeBloc _themeBloc = ThemeBloc(NewThemeState(false));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => _themeBloc,
        child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
            return MaterialApp(
              title: 'NG Values',
              theme: ThemeData(
                brightness: state.dark? Brightness.dark:Brightness.light,
              
              ),
              home: HomePage('NG Values', this._themeBloc),
          );
        })
    );
  }

  @override
  void dispose(){
    _themeBloc.close();
    super.dispose();
  }
}

