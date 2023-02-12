import 'package:budget_app/forms/add_template.dart';
import 'package:budget_app/reflector.dart';
import 'package:budget_app/models/model.dart';

@reflector
class CategoryModel implements Model {
  CategoryModel({this.id, required this.title, this.date});

  final int? id;
  final String title;
  final String? date;

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(id: map['id'], title: map['title'], date: map['date']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
    };
  }
}
