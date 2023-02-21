import 'package:budget_app/models/model.dart';
import 'package:budget_app/db.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  List<dynamic> cats = [];

  @override
  initState() {
    initDb();
    getCategories();
    super.initState();
  }

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  void getCategories() async {
    await DatabaseRepository.instance
        .getAllOfType<CategoryModelGen>()
        .then((value) {
      setState(() {
        cats = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.dashboard);
  }
}
