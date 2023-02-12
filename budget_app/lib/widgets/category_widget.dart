import 'package:budget_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/reflector.dart';

@reflector
class CategoryWidget extends StatelessWidget {
  final CategoryModel item;
  const CategoryWidget({Key? key, required this.item}) : super(key: key);

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
          Builder(
            builder: (context) {
              return item.date != null ? Text(item.date as String) : Text("");
            },
          )
        ],
      ),
    );
  }
}