import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AddEntryForm extends StatefulWidget {
  @override
  AddEntryFormState createState() {
    return AddEntryFormState();
  }
}

class AddEntryFormState extends State<AddEntryForm> {
  final _entry_form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _entry_form_key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.text_fields),
              labelText: 'Title',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.attach_money),
              labelText: 'Amount',
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
            ],
          ),
        ],
      ),
    );
  }
}
