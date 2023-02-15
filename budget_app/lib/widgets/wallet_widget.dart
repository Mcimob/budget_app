import 'package:budget_app/models/model.dart';
import 'package:flutter/material.dart';

class WalletWidget extends StatelessWidget {
  final WalletModelGen item;
  const WalletWidget({Key? key, required this.item}) : super(key: key);

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
          Icon(IconData(item.iconId, fontFamily: item.iconFontFamily)),
        ],
      ),
    );
  }
}
