import 'package:budget_app/db.dart';
import 'package:budget_app/models/model.dart';
import 'package:budget_app/widgets/category_widget.dart';
import 'package:budget_app/widgets/text_input_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddCategoryPage extends StatefulWidget {
  AddCategoryPage({Key? key}) : super(key: key);

  @override
  AddCategoryPageState createState() {
    return AddCategoryPageState();
  }
}

class AddCategoryPageState extends State<AddCategoryPage> {
  final Icon defaultIcon = Icon(IconData(0xe25a, fontFamily: 'MaterialIcons'));
  final titleController = TextEditingController();
  List<Model> cats = [];
  bool _submitted = false;

  @override
  initState() {
    initDb();
    getCategories();
    super.initState();
  }

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  void getCategories() async {
    await DatabaseRepository.instance
        .getAllOfType<CategoryModelGen>()
        .then((value) {
      setState(() {
        cats = value;
      });
    });
  }

  void addCategory() async {
    if (titleController.text.isEmpty) {}
    FocusScope.of(context).requestFocus(new FocusNode());
    CategoryModelGen cat = CategoryModelGen(
        title: titleController.text,
        iconId: _icon != null
            ? _icon!.icon!.codePoint
            : defaultIcon.icon!.codePoint,
        iconFontFamily: _icon != null
            ? _icon!.icon!.fontFamily!
            : defaultIcon.icon!.fontFamily!,
        lastState: 0);
    await DatabaseRepository.instance.insert(o: cat);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Adding Category "${titleController.text}"')));
    titleController.text = "";
    _icon = defaultIcon;
    getCategories();
  }

  String? get _errorText {
    return TextInputMethods.errorText(titleController);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
            iconPackModes: [IconPack.material]) ??
        defaultIcon.icon;
    _icon = Icon(icon);
    setState(() {});
    debugPrint("icon selected");
  }

  delete(Model o) async {
    await DatabaseRepository.instance.delete(o: o);
    getCategories();
  }

  final double _paddingWidth = 16;

  Icon? _icon;

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
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(
                              label: Text('Category Title'),
                              hintText: 'Think of some descriptive title',
                              errorText: _submitted ? _errorText : null,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: _icon ?? defaultIcon,
                          onPressed: _pickIcon,
                        ),
                      ],
                    ),
                    MaterialButton(
                      color: Colors.black,
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: _errorText == null ? addCategory : null,
                      child: const Text(
                        'Add Category',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: _paddingWidth),
                        child: Text(
                          "Categories",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  key: UniqueKey(),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    padding: EdgeInsets.all(_paddingWidth),
                    itemBuilder: (context, index) {
                      return CategoryModelGenWidget(
                        item: cats[index] as CategoryModelGen,
                        delete: delete,
                      );
                    },
                    itemCount: cats.length,
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
