import 'package:budget_app/models/model.dart';
import 'package:budget_app/widgets/category_widget.dart';
import 'package:budget_app/widgets/wallet_widget.dart';

class AppConst {
  static Map<Type, Type> add_page_dict = {
    CategoryModelGen: CategoryWidget,
    WalletModelGen: WalletWidget,
    EntryModelGen: WalletWidget,
  };
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
