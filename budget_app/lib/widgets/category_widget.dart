import 'package:budget_app/models/model.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModelGen item;
  const CategoryWidget({Key? key, required this.item}) : super(key: key);

  _editCategory() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.title),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(IconData(item.iconId, fontFamily: item.iconFontFamily)),
              IconButton(onPressed: _editCategory, icon: Icon(Icons.edit)),
            ],
          )
        ],
      ),
    );
  }
}
