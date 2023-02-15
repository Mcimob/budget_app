import 'package:budget_app/db.dart';
import 'package:budget_app/models/model.dart';
import 'package:budget_app/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  AddCategoryPageState createState() {
    return AddCategoryPageState();
  }
}

class AddCategoryPageState extends State<AddCategoryPage> {
  final titleController = TextEditingController();
  List<Model> cats = [];
  bool _submitted = false;

  void _submit() {
    setState(() => _submitted = true);
  }

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
    CategoryModelGen cat = CategoryModelGen(title: titleController.text);
    await DatabaseRepository.instance.insert(o: cat);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Adding Category "${titleController.text}"')));
    titleController.text = "";
    getCategories();
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

  final double _paddingWidth = 16;

  Icon? _icon = Icon(IconData(0xe25a, fontFamily: 'MaterialIcons'));

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
                        label: Text('Category Title'),
                        hintText: 'Think of some descriptive title',
                        errorText: _submitted ? _errorText : null,
                        suffixIcon: IconButton(
                          icon: _icon ?? Container(),
                          onPressed: _pickIcon,
                        ),
                      ),
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
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    padding: EdgeInsets.all(_paddingWidth),
                    itemBuilder: (context, index) {
                      return CategoryWidget(
                          item: cats[index] as CategoryModelGen);
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
