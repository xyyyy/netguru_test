import 'package:flutter/material.dart';

@immutable
abstract class RandomValueEvent{}



class StartEvent extends RandomValueEvent {
  final String value;

  StartEvent({@required this.value}) : super();


}


class NextEvent extends RandomValueEvent {
  final String value;
  final bool favorite;

  NextEvent({@required this.value, @required this.favorite}) : super();


}

class AddNewValueEvent extends RandomValueEvent {
  final String value;

  AddNewValueEvent({@required this.value}) : super();

}

class ChangeFavoriteValueEvent extends RandomValueEvent {}




