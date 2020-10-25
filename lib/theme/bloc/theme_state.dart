import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ThemeState extends Equatable {
  final bool dark;

  ThemeState(this.dark);

}

class NewThemeState extends ThemeState {
  NewThemeState(bool dark) : super(dark);

  @override
  String toString() => dark.toString();

  @override
  List<Object> get props => [dark];
}
