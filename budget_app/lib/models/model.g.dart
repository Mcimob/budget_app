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
    this.lastState,
  });
  int? id;
  String title;
  String? date;
  int iconId;
  String iconFontFamily;
  int? lastState;
  factory WalletModelGen.fromJson(Map<String, dynamic> map) {
    return WalletModelGen(
      id: map["id"],
      title: map["title"],
      date: map["date"],
      iconId: map["iconId"],
      iconFontFamily: map["iconFontFamily"],
      lastState: map["lastState"],
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
      "lastState": lastState,
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
    this.lastState,
  });
  int? id;
  String title;
  String? date;
  int iconId;
  String iconFontFamily;
  int? lastState;
  factory CategoryModelGen.fromJson(Map<String, dynamic> map) {
    return CategoryModelGen(
      id: map["id"],
      title: map["title"],
      date: map["date"],
      iconId: map["iconId"],
      iconFontFamily: map["iconFontFamily"],
      lastState: map["lastState"],
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
      "lastState": lastState,
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

// **************************************************************************
// ModelWidgetGenerator
// **************************************************************************

class WalletModelGenWidget extends StatefulWidget {
  final WalletModelGen item;
  final ValueChanged<Model> delete;
  WalletModelGenWidget({Key? key, required this.item, required this.delete})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WalletModelGenWidgetState();
  }
}

class WalletModelGenWidgetState extends State<WalletModelGenWidget> {
  final titleController = TextEditingController();
  bool inEditMode = false;
  Icon? _icon;

  @override
  initState() {
    _icon = Icon(
        IconData(widget.item.iconId, fontFamily: widget.item.iconFontFamily));
    titleController.value = TextEditingValue(text: widget.item.title);
    inEditMode = widget.item.lastState == 1 ? true : false;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  _editWalletModel() {
    setState(() {
      inEditMode = !inEditMode;
    });
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);
    _icon = Icon(icon);
    debugPrint("icon selected");
    _save();
  }

  _delete() async {
    widget.delete(widget.item);
  }

  _cancel() {}

  _save() async {
    widget.item.title = titleController.text;
    widget.item.iconId = _icon!.icon!.codePoint;
    widget.item.iconFontFamily = _icon!.icon!.fontFamily!;
    widget.item.lastState = inEditMode ? 1 : 0;
    await DatabaseRepository.instance.update(o: widget.item);
  }

  _save_and_close() async {
    _editWalletModel();
    await _save();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.1)),
      child: inEditMode ? getEditMode() : getViewMode(),
    );
  }

  Row getViewMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.item.title),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(IconData(widget.item.iconId,
                fontFamily: widget.item.iconFontFamily)),
            IconButton(onPressed: _editWalletModel, icon: Icon(Icons.edit)),
          ],
        )
      ],
    );
  }

  Widget getEditMode() {
    return ValueListenableBuilder(
        valueListenable: titleController,
        builder: (context, TextEditingValue value, __) {
          return Row(children: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _save_and_close,
            ),
            Flexible(
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  label: Text('WalletModel Title'),
                  hintText: 'Think of some descriptive title',
                  errorText: TextInputMethods.errorText(titleController),
                ),
              ),
            ),
            IconButton(
              icon: _icon!,
              onPressed: _pickIcon,
            ),
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: _editWalletModel,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _delete,
            ),
          ]);
        });
  }
}

class CategoryModelGenWidget extends StatefulWidget {
  final CategoryModelGen item;
  final ValueChanged<Model> delete;
  CategoryModelGenWidget({Key? key, required this.item, required this.delete})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategoryModelGenWidgetState();
  }
}

class CategoryModelGenWidgetState extends State<CategoryModelGenWidget> {
  final titleController = TextEditingController();
  bool inEditMode = false;
  Icon? _icon;

  @override
  initState() {
    _icon = Icon(
        IconData(widget.item.iconId, fontFamily: widget.item.iconFontFamily));
    titleController.value = TextEditingValue(text: widget.item.title);
    inEditMode = widget.item.lastState == 1 ? true : false;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  _editCategoryModel() {
    setState(() {
      inEditMode = !inEditMode;
    });
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);
    _icon = Icon(icon);
    debugPrint("icon selected");
    _save();
  }

  _delete() async {
    widget.delete(widget.item);
  }

  _cancel() {}

  _save() async {
    widget.item.title = titleController.text;
    widget.item.iconId = _icon!.icon!.codePoint;
    widget.item.iconFontFamily = _icon!.icon!.fontFamily!;
    widget.item.lastState = inEditMode ? 1 : 0;
    await DatabaseRepository.instance.update(o: widget.item);
  }

  _save_and_close() async {
    _editCategoryModel();
    await _save();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.1)),
      child: inEditMode ? getEditMode() : getViewMode(),
    );
  }

  Row getViewMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.item.title),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(IconData(widget.item.iconId,
                fontFamily: widget.item.iconFontFamily)),
            IconButton(onPressed: _editCategoryModel, icon: Icon(Icons.edit)),
          ],
        )
      ],
    );
  }

  Widget getEditMode() {
    return ValueListenableBuilder(
        valueListenable: titleController,
        builder: (context, TextEditingValue value, __) {
          return Row(children: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _save_and_close,
            ),
            Flexible(
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  label: Text('CategoryModel Title'),
                  hintText: 'Think of some descriptive title',
                  errorText: TextInputMethods.errorText(titleController),
                ),
              ),
            ),
            IconButton(
              icon: _icon!,
              onPressed: _pickIcon,
            ),
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: _editCategoryModel,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _delete,
            ),
          ]);
        });
  }
}
