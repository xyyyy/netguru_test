
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_test/random_value/bloc/random_value_bloc.dart';
import 'package:netguru_test/random_value/bloc/random_value_state.dart';

class ValueWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomValueBloc, RandomValueState>(
        //cubit: blocA, // provide the local bloc instance
        builder: (context, state) {
          return Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder:
                    (Widget child, Animation<double> animation) {
                      return SlideTransition(
                        child: child,
                        position: Tween<Offset>(
                            begin: Offset(0.0, -1.5),
                            end: Offset(0.0, 0.0))
                            .animate(animation),
                      );
                },
                child: Text(
                  state.value,
                  key: ValueKey<String>(state.value),
                  style: TextStyle(fontSize: 30,  fontFamily: 'RobotoMono'),
                  textAlign: TextAlign.center,
                ),
              )



          );
          // return widget here based on BlocA's state
        }
    );

  }
}
