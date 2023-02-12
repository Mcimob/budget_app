import 'package:budget_app/models/model.dart';

class EntryModel implements Model {
  EntryModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.swId,
    required this.swShare,
    required this.walletId,
    required this.categoryId,
  });

  final int id;
  final String name;
  final int amount;
  final int? swId;
  final double? swShare;
  final int walletId;
  final int categoryId;

  factory EntryModel.fromJson(Map<String, dynamic> map) {
    return EntryModel(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      swId: map['swId'],
      swShare: map['swShare'],
      walletId: map['walletId'],
      categoryId: map['categoryId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'swId': swId,
      'swShare': swShare,
      'walletId': walletId,
      'categoryId': categoryId,
    };
  }
}
