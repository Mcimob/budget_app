import 'package:budget_app/models/model.dart';

class AppConst {
  static Map<Type, String> table_name_dict = {
    CategoryModelGen: "categories",
    WalletModelGen: "wallets",
    EntryModelGen: "entries",
  };
  static Map<Type, String> type_to_name = {
    CategoryModelGen: "Category",
    WalletModelGen: "Wallet",
    EntryModelGen: "Entry",
  };
}
