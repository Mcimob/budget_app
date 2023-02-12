import 'package:budget_app/forms/add_template.dart';
import 'package:budget_app/reflector.dart';
import 'package:budget_app/models/model.dart';

@reflector
class WalletModel implements Model {
  WalletModel({this.id, required this.title, this.date});

  final int? id;
  final String title;
  final String? date;

  factory WalletModel.fromJson(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'],
      title: map['title'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
    };
  }
}
