import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netguru_test/data/values_data.dart';
import 'package:netguru_test/selected_values/bloc/selected_values_event.dart';
import 'package:netguru_test/selected_values/bloc/selected_values_state.dart';


class SelectedValuesBloc extends Bloc<SelectedValuesEvent, SelectedValuesState> {

  final ValuesData _valuesData;


  SelectedValuesBloc(SelectedValuesState initialState, this._valuesData) : super(initialState);


  @override
  Stream<SelectedValuesState> mapEventToState(SelectedValuesEvent event) async* {
    if(event is SelectedValuesStartEvent){
      yield* _mapStartEventToState();
    }
  }



  Stream<SelectedValuesState> _mapStartEventToState() async* {
   yield NewValuesState(await _valuesData.getFavoriteValues());
  }




}

