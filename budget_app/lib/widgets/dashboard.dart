import 'package:budget_app/models/model.dart';
import 'package:budget_app/widgets/category_widget.dart';
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
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return CategoryWidget(item: cats[index]);
        },
        itemCount: cats.length,
      ),
    );
  }
}
