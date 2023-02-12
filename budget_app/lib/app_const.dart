import 'package:budget_app/models/category.dart';
import 'package:budget_app/models/entry.dart';
import 'package:budget_app/models/wallet.dart';
import 'package:budget_app/widgets/category_widget.dart';
import 'package:budget_app/widgets/wallet_widget.dart';

class AppConst {
  static Map<Type, Type> add_page_dict = {
    CategoryModel: CategoryWidget,
    WalletModel: WalletWidget,
    EntryModel: WalletWidget,
  };
  static Map<Type, String> table_name_dict = {
    CategoryModel: "categories",
    WalletModel: "wallets",
    EntryModel: "entries",
  };
  static Map<Type, String> type_to_name = {
    CategoryModel: "Category",
    WalletModel: "Wallet",
    EntryModel: "Entry",
  };
}
