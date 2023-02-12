import 'package:budget_app/forms/add_category_page.dart';
import 'package:budget_app/forms/add_entry_form.dart';
import 'package:budget_app/forms/new_add_page.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  AddPageState createState() {
    return AddPageState();
  }
}

class AddPageState extends State<AddPage> with TickerProviderStateMixin {
  late TabController _tc;

  @override
  void initState() {
    super.initState();
    _tc = TabController(vsync: this, length: 3);
    _tc.animation!.addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              controller: _tc,
              tabs: [
                Tab(text: 'Entry'),
                Tab(text: 'Category'),
                Tab(text: 'Wallet'),
              ],
            )
          ],
        ),
      ),
      body: TabBarView(
        physics: BouncingScrollPhysics(),
        controller: _tc,
        children: [
          AddEntryForm(),
          AddCategoryPage(),
          NewAddPage(),
        ],
      ),
    );
  }
}
