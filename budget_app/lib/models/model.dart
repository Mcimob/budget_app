import 'package:annotations/annotations.dart';

part 'model.g.dart';

abstract class Model {
  Map<String, dynamic> toMap();
}

@generateModel
class WalletModel {
  int? id;
  String title = 'default';
  String? date;
  int iconId = 0;
  String iconFontFamily = 'default';
}

@generateModel
class CategoryModel {
  int? id;
  String title = 'default';
  String? date;
  int iconId = 0;
  String iconFontFamily = 'default';
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
