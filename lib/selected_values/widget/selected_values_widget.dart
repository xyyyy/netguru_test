
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_test/data/values_data.dart';
import 'package:netguru_test/selected_values/bloc/selected_values_bloc.dart';
import 'package:netguru_test/selected_values/bloc/selected_values_event.dart';
import 'package:netguru_test/selected_values/bloc/selected_values_state.dart';

class SelectedValuesWidget extends StatefulWidget {

  final ValuesData _valuesData;

  SelectedValuesWidget(this._valuesData);

  @override
  _SelectedValuesWidgetState createState() => _SelectedValuesWidgetState();
}

class _SelectedValuesWidgetState extends State<SelectedValuesWidget> {

  SelectedValuesBloc _selectedValuesBloc;

  @override
  void initState(){
    _selectedValuesBloc = SelectedValuesBloc(NewValuesState(List<String>()), widget._valuesData);
    _selectedValuesBloc.add(SelectedValuesStartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _selectedValuesBloc,
        child:   BlocBuilder<SelectedValuesBloc, SelectedValuesState>(
          builder: (context, state) {
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.selectedValues.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(

                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(child: Text(state.selectedValues[index], textAlign: TextAlign.center,)),
                    ),
                  );
                }
            );
          })
    );
  }

  @override
  void dispose(){
    _selectedValuesBloc.close();
    super.dispose();
  }
}
