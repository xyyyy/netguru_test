

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_test/data/values_data.dart';
import 'package:netguru_test/random_value/bloc/random_value_bloc.dart';
import 'package:netguru_test/random_value/bloc/random_value_event.dart';
import 'package:netguru_test/random_value/bloc/random_value_state.dart';
import 'package:netguru_test/random_value/widget/add_new_value_dialog.dart';
import 'package:netguru_test/random_value/widget/random_value_widget.dart';
import 'package:netguru_test/selected_values/widget/selected_values_widget.dart';
import 'package:netguru_test/theme/bloc/theme_bloc.dart';
import 'package:netguru_test/theme/bloc/theme_event.dart';


class HomePage extends StatefulWidget {

  final String _title;
  final ThemeBloc _themeBloc;

  HomePage(this._title, this._themeBloc);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  final ValuesData _valuesData = ValuesData();
  RandomValueBloc _randomValueBloc;

  @override
  void initState(){
    _randomValueBloc = RandomValueBloc(RunningState("", false), this._valuesData);
    _randomValueBloc.add(StartEvent());
    super.initState();
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => _randomValueBloc,
      child: Scaffold(
        appBar: AppBar(

          title: Text(widget._title),
          actions: [
            PopupMenuButton<String>(
              onSelected: (_) =>  widget._themeBloc.add(ChangeThemeEvent()),
              itemBuilder: (BuildContext context) {
                return {'change theme'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],


        ),
        body: _selectedIndex==0? Container(child: RandomValueWidget()):Container(child: SelectedValuesWidget(this._valuesData)),


        floatingActionButton:  _selectedIndex==0? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(

                  onPressed: () => AddNewValueDialog().show(context, _randomValueBloc.add),
                  tooltip: 'Add new value',
                  child: Icon(Icons.add),
                  backgroundColor: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<RandomValueBloc, RandomValueState>(
                //cubit: blocA, // provide the local bloc instance
                builder: (context, state) {
                  return FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () => _randomValueBloc.add(ChangeFavoriteValueEvent()),
                    tooltip: 'Add to favorites',
                    child:  Icon(Icons.favorite, color: state.favorite? Colors.red:Colors.white,),

                  );
                }
                ),
              ),

            ],
          ):Container(),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'All values',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite values',
            ),

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          backgroundColor: Colors.blue,
        )
      ),
    );
  }

  @override
  void dispose(){
    _randomValueBloc.close();
    super.dispose();
  }
}
