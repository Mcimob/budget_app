import 'package:budget_app/db.dart';
import 'package:budget_app/models/wallet.dart';
import 'package:budget_app/widgets/wallet_widget.dart';
import 'package:flutter/material.dart';

class AddWalletPage extends StatefulWidget {
  @override
  AddWalletPageState createState() {
    return AddWalletPageState();
  }
}

class AddWalletPageState extends State<AddWalletPage> {
  final titleController = TextEditingController();
  List<WalletModel> wallets = [];
  bool _submitted = false;

  void _submit() {
    setState(() => _submitted = true);
  }

  @override
  initState() {
    initDb();
    getWallets();
    super.initState();
  }

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  void getWallets() async {
    await DatabaseRepository.instance.getAllWallets().then((value) {
      setState(() {
        wallets = value;
      });
    });
  }

  void addWallet() async {
    if (titleController.text.isEmpty) {}
    FocusScope.of(context).requestFocus(new FocusNode());
    WalletModel cat = WalletModel(title: titleController.text);
    await DatabaseRepository.instance.insert(o: cat);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Adding Wallet "${titleController.text}"')));
    titleController.text = "";
    getWallets();
  }

  String? get _errorText {
    final text = titleController.text;
    if (text.isEmpty) {
      return 'Title can\'t be empty';
    }
    return null;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  final double _paddingWidth = 16;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: titleController,
      builder: (context, TextEditingValue value, __) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Column(
                  children: [
                    WalletTitleFormField(
                        titleController: titleController,
                        submitted: _submitted,
                        errorText: _errorText),
                    MaterialButton(
                      color: Colors.black,
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: _errorText == null ? addWallet : null,
                      child: const Text(
                        'Add Wallet',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: _paddingWidth),
                        child: Text(
                          "Wallets",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    padding: EdgeInsets.all(_paddingWidth),
                    itemBuilder: (context, index) {
                      return WalletWidget(item: wallets[index]);
                    },
                    itemCount: wallets.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WalletTitleFormField extends StatelessWidget {
  const WalletTitleFormField({
    super.key,
    required this.titleController,
    required bool submitted,
    required String? errorText,
  })  : _submitted = submitted,
        _errorText = errorText;

  final TextEditingController titleController;
  final bool _submitted;
  final String? _errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      decoration: InputDecoration(
        label: Text('Wallet Title'),
        hintText: 'Think of some descriptive title',
        errorText: _submitted ? _errorText : null,
      ),
    );
  }
}
