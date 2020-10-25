


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RandomValueState extends Equatable {
  final String value;
  final bool favorite;


  RandomValueState(this.value, this.favorite);

}

class RunningState extends RandomValueState {
  RunningState(String value, bool favorite) : super(value, favorite);

  @override
  String toString() => value;

  @override
  List<Object> get props => [value, favorite];
}
