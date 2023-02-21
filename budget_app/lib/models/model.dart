import 'package:annotations/annotations.dart';

import 'package:budget_app/widgets/text_input_methods.dart';
import 'package:budget_app/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:sqflite/sqflite.dart';

part 'model.g.dart';

abstract class Model {
  Map<String, dynamic> toMap();
  int? id;
}

@generateModelWidget
@generateModel
class WalletModel {
  int? id;
  String title = 'default';
  String? date;
  int iconId = 0;
  String iconFontFamily = 'default';
  int? lastState = 0;
}

@generateModelWidget
@generateModel
class CategoryModel {
  int? id;
  String title = 'default';
  String? date;
  int iconId = 0;
  String iconFontFamily = 'default';
  int? lastState = 0;
}

@generateModel
class EntryModel {
  int? id;
  String name = 'default';
  int amount = 0;
  int? swId;
  double? swShare;
  int walletId = 0;
  int categoryId = 0;
}
