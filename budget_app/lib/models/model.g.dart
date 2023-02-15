// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

class WalletModelGen implements Model {
  WalletModelGen({
    this.id,
    required this.title,
    this.date,
    required this.iconId,
    required this.iconFontFamily,
  });
  int? id;
  String title;
  String? date;
  int iconId;
  String iconFontFamily;
  factory WalletModelGen.fromJson(Map<String, dynamic> map) {
    return WalletModelGen(
      id: map["id"],
      title: map["title"],
      date: map["date"],
      iconId: map["iconId"],
      iconFontFamily: map["iconFontFamily"],
    );
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "date": date,
      "iconId": iconId,
      "iconFontFamily": iconFontFamily,
    };
  }
}

class CategoryModelGen implements Model {
  CategoryModelGen({
    this.id,
    required this.title,
    this.date,
    required this.iconId,
    required this.iconFontFamily,
  });
  int? id;
  String title;
  String? date;
  int iconId;
  String iconFontFamily;
  factory CategoryModelGen.fromJson(Map<String, dynamic> map) {
    return CategoryModelGen(
      id: map["id"],
      title: map["title"],
      date: map["date"],
      iconId: map["iconId"],
      iconFontFamily: map["iconFontFamily"],
    );
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "date": date,
      "iconId": iconId,
      "iconFontFamily": iconFontFamily,
    };
  }
}

class EntryModelGen implements Model {
  EntryModelGen({
    this.id,
    required this.name,
    required this.amount,
    this.swId,
    this.swShare,
    required this.walletId,
    required this.categoryId,
  });
  int? id;
  String name;
  int amount;
  int? swId;
  double? swShare;
  int walletId;
  int categoryId;
  factory EntryModelGen.fromJson(Map<String, dynamic> map) {
    return EntryModelGen(
      id: map["id"],
      name: map["name"],
      amount: map["amount"],
      swId: map["swId"],
      swShare: map["swShare"],
      walletId: map["walletId"],
      categoryId: map["categoryId"],
    );
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "amount": amount,
      "swId": swId,
      "swShare": swShare,
      "walletId": walletId,
      "categoryId": categoryId,
    };
  }
}
