import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_test/data/value.dart';
import 'package:netguru_test/data/values_data.dart';
import 'package:netguru_test/random_value/bloc/random_value_event.dart';
import 'package:netguru_test/random_value/bloc/random_value_state.dart';

class RandomValueBloc extends Bloc<RandomValueEvent, RandomValueState> {

  final ValuesData _valuesData;
  final int _duration = 5;
  StreamSubscription<Future<Value>> _valuesSubscription;

  RandomValueBloc(RandomValueState initialState, this._valuesData) : super(initialState);


  @override
  Stream<RandomValueState> mapEventToState(RandomValueEvent event) async*{

    if(event is StartEvent){
      yield* _mapStartEventToState(event);
    }else if(event is NextEvent){
      yield* _mapNextEventToState(event);
    }if(event is AddNewValueEvent){
      _valuesData.addValue(event.value);
    }if(event is ChangeFavoriteValueEvent){
      yield* _mapChangeFavoriteToState(event);
    }

  }

  Stream<RandomValueState> _mapChangeFavoriteToState(ChangeFavoriteValueEvent event) async* {

    Value value = await _valuesData.changeFavoriteStatus();
    yield RunningState(value.value, value.favorite);

  }

  Stream<RandomValueState> _mapNextEventToState(NextEvent event) async* {
    yield RunningState(event.value.toString(), event.favorite);

  }

  Stream<RandomValueState> _mapStartEventToState(StartEvent event) async* {
    Value tmp = await this._valuesData.getNextValue();
    yield RunningState(tmp.value, tmp.favorite);
    _valuesSubscription?.cancel();
    _valuesSubscription = _valuesData.valueStream(duration: _duration).listen(
          (value) async {
            Value tmp = await value;
            add(NextEvent(value: tmp.value, favorite: tmp.favorite));

      },
    );
  }

  @override
  Future<void> close(){
    _valuesSubscription.cancel();
    return super.close();
  }


}