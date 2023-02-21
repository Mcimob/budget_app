import 'package:budget_app/db.dart';
import 'package:budget_app/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddWalletPage extends StatefulWidget {
  @override
  AddWalletPageState createState() {
    return AddWalletPageState();
  }
}

class AddWalletPageState extends State<AddWalletPage> {
  final Icon defaultIcon = Icon(IconData(0xee33, fontFamily: 'MaterialIcons'));
  final titleController = TextEditingController();
  List<Model> wallets = [];
  bool _submitted = false;
  Icon? _icon;

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
    await DatabaseRepository.instance
        .getAllOfType<WalletModelGen>()
        .then((value) {
      setState(() {
        wallets = value;
      });
    });
  }

  void addWallet() async {
    if (titleController.text.isEmpty) {}
    FocusScope.of(context).requestFocus(new FocusNode());
    WalletModelGen wallet = WalletModelGen(
        title: titleController.text,
        iconId: _icon != null
            ? _icon!.icon!.codePoint
            : defaultIcon.icon!.codePoint,
        iconFontFamily: _icon != null
            ? _icon!.icon!.fontFamily!
            : defaultIcon.icon!.fontFamily!,
        lastState: 0);
    await DatabaseRepository.instance.insert(o: wallet);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Adding Wallet "${titleController.text}"')));
    titleController.text = "";
    _icon = defaultIcon;
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

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);
    _icon = Icon(icon);
    setState(() {});
    debugPrint("icon selected");
  }

  delete(Model o) async {
    await DatabaseRepository.instance.delete(o: o);
    getWallets();
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
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        label: Text('Wallet Title'),
                        hintText: 'Think of some descriptive title',
                        errorText: _submitted ? _errorText : null,
                        suffixIcon: IconButton(
                          icon: _icon != null ? _icon! : defaultIcon,
                          onPressed: _pickIcon,
                        ),
                      ),
                    ),
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
                      return WalletModelGenWidget(
                        item: wallets[index] as WalletModelGen,
                        delete: delete,
                      );
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
