import 'package:budget_app/forms/add_template.dart';
import 'package:budget_app/models/wallet.dart';
import 'package:flutter/material.dart';

class NewAddPage extends StatefulWidget {
  @override
  NewAddPageState createState() {
    return NewAddPageState();
  }
}

class NewAddPageState extends State<NewAddPage> {
  @override
  Widget build(BuildContext context) {
    return AddTemplate<WalletModel>();
  }
}
