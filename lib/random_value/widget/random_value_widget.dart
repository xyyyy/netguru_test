

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netguru_test/random_value/widget/value_wiget.dart';



class RandomValueWidget extends StatefulWidget {
  @override
  _RandomValueWidgetState createState() => _RandomValueWidgetState();
}

class _RandomValueWidgetState extends State<RandomValueWidget>{







  @override
  Widget build(BuildContext context) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Expanded(
              child: ValueWidget()
            ),
        ],
      );

  }




}
