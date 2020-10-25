
import 'package:flutter/material.dart';
import 'package:netguru_test/random_value/bloc/random_value_event.dart';

class AddNewValueDialog{
  TextEditingController _textEditingController = TextEditingController();

  Future<void> show(BuildContext context, Function(AddNewValueEvent) addNewValue) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New value'),
          content: SingleChildScrollView(
            child: TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                  //border: border,
                  hintText: 'Enter new value'
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },

            )
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                addNewValue(AddNewValueEvent(value: _textEditingController.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}