

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SelectedValuesState extends Equatable {
  final List<String> _selectedValues;
  List<String>  get selectedValues => _selectedValues;

  SelectedValuesState(this._selectedValues);

}

class NewValuesState extends SelectedValuesState {
  NewValuesState(List<String> selectedValues) : super(selectedValues);

  @override
  String toString() => _selectedValues.toString();

  @override
  List<Object> get props => _selectedValues;
}
